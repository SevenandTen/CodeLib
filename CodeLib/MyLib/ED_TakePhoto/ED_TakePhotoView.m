//
//  ED_TakePhotoView.m
//  CodeLib
//
//  Created by zw on 2020/1/14.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_TakePhotoView.h"
#import <AVFoundation/AVFoundation.h>

@interface ED_TakePhotoView ()<AVCapturePhotoCaptureDelegate>

@property (nonatomic , strong) AVCaptureSession *session; //负责输入和输出设备之间的连接会话

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic , strong) AVCaptureDeviceInput *videoIntput;// 视频输入源

@property (nonatomic , strong) AVCaptureOutput * imageOutPut;





@end

@implementation ED_TakePhotoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
     [self.layer addSublayer:self.previewLayer];
}


- (void)layoutSubviews {
    self.previewLayer.frame = self.bounds;
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
           [self.session startRunning];
    });
}


#pragma mark - Action

- (void)takePhoto {
    if (@available(iOS 10,*)) {
        AVCapturePhotoOutput *imageOut = (AVCapturePhotoOutput *)self.imageOutPut;
        [imageOut capturePhotoWithSettings:[AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecJPEG}] delegate:self];
        
    }else{
        __weak typeof(self)weakSelf = self;
        AVCaptureStillImageOutput *imageOut = (AVCaptureStillImageOutput *)self.imageOutPut;
        [imageOut captureStillImageAsynchronouslyFromConnection:[self findVideoConnectionWithOutPut:imageOut] completionHandler:^(CMSampleBufferRef  _Nullable imageDataSampleBuffer, NSError * _Nullable error) {
            if (!error) {
                NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                
                UIImage *image = [UIImage imageWithData:imageData];
                if ([weakSelf.delegate respondsToSelector:@selector(takePhotoView:didClickTakePhoto:)]) {
                    [weakSelf.delegate takePhotoView:weakSelf didClickTakePhoto:image];
                }
                
            }
        }];
        
    }
}

#pragma mark - Private

- (AVCaptureConnection *)findVideoConnectionWithOutPut:(AVCaptureStillImageOutput *)outPut
{
      AVCaptureConnection *videoConnection = nil;
      for (AVCaptureConnection *connection in outPut.connections) {
          for (AVCaptureInputPort *port in connection.inputPorts) {
              if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                  videoConnection = connection;
                  break;
              }
          }
          if (videoConnection) {
              break;
          }
      }
      return videoConnection;
}

#pragma mark - AVCapturePhotoCaptureDelegate

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhoto:(AVCapturePhoto *)photo error:(nullable NSError *)error  API_AVAILABLE(ios(11.0)){
    if (!error) {
        NSData *data =  [photo fileDataRepresentation];
        UIImage *image = [UIImage imageWithData:data];
        if ([self.delegate respondsToSelector:@selector(takePhotoView:didClickTakePhoto:)]) {
            [self.delegate takePhotoView:self didClickTakePhoto:image];
        }
    }
    
}

- (void)captureOutput:(AVCapturePhotoOutput *)output didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error {
    if (!error) {
         NSData *data = [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
        UIImage *image = [UIImage imageWithData:data];
        if ([self.delegate respondsToSelector:@selector(takePhotoView:didClickTakePhoto:)]) {
            [self.delegate takePhotoView:self didClickTakePhoto:image];
        }
    }
}


#pragma mark - AV Getter

-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}



- (AVCaptureDeviceInput *)videoIntput {
    if (!_videoIntput) {
        AVCaptureDevice *defaultDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        _videoIntput = [[AVCaptureDeviceInput alloc] initWithDevice:defaultDevice error:&error];
    }
    return _videoIntput;
}


- (AVCaptureOutput * )imageOutPut {
    if (!_imageOutPut) {
        if (@available(iOS 10 ,*)) {
            AVCapturePhotoOutput *imageOutput = [[AVCapturePhotoOutput alloc] init];
           AVCapturePhotoSettings *settings =[AVCapturePhotoSettings photoSettingsWithFormat:@{AVVideoCodecKey:AVVideoCodecJPEG}];
            [imageOutput setPhotoSettingsForSceneMonitoring:settings];
            _imageOutPut = imageOutput;
            
            
        }else{
            AVCaptureStillImageOutput * imageOutPut = [[AVCaptureStillImageOutput alloc] init];
            imageOutPut.outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];//输出jpeg
            _imageOutPut = imageOutPut;
        }
        
    }
    return _imageOutPut;
}


- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh; // 画质
        if ([_session canAddInput:self.videoIntput]) {
            [_session addInput:self.videoIntput];
        }
        if ([_session canAddOutput:self.imageOutPut]) {
            [_session addOutput:self.imageOutPut];
        }
    }
    return _session;
}



@end
