//
//  ED_VideoMakerView.m
//  CodeLib
//
//  Created by zw on 2019/10/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_VideoMakerView.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>


@interface ED_VideoMakerView ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic , strong) AVCaptureSession *session; //负责输入和输出设备之间的连接会话

@property (nonatomic , strong) AVCaptureDeviceInput *captureDeviceInput;// 输入源

@property (nonatomic , strong) AVCaptureDeviceInput * audioMicInput;//麦克风输入

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (strong, nonatomic) AVCaptureConnection * videoConnection;//视频录制连接

@property (strong,nonatomic) AVCaptureMovieFileOutput * captureMovieFileOutput;

@property (nonatomic, assign) AVCaptureFlashMode mode;//设置聚焦曝光

@property (nonatomic, strong) AVCaptureDevice *captureDevice;   // 输入设备

@property (nonatomic, assign) AVCaptureDevicePosition position;//设置焦点



@property (nonatomic , strong) UIButton *startRecordBtn;

@property (nonatomic , strong) CALayer *itemLayer;





@end

@implementation ED_VideoMakerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureView];
    }
    return self;
}


- (void)configureView {
    [self.layer addSublayer:self.previewLayer];
    [self addSubview:self.startRecordBtn];
    
    [AVVideoCompositionCoreAnimationTool videoCompositionCoreAnimationToolWithPostProcessingAsVideoLayer:self.previewLayer inLayer:self.layer];
}


- (void)layoutSubviews {
    self.previewLayer.frame = self.bounds;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.session startRunning];
    });
    
    self.startRecordBtn.frame = CGRectMake((self.bounds.size.width - 50)/2.0, self.bounds.size.height - 100, 50, 50);
}


#pragma mark - Action

- (void)didClickStartBtn {
    if (self.captureMovieFileOutput.isRecording) {
        self.startRecordBtn.backgroundColor = [UIColor redColor];
        [self.captureMovieFileOutput stopRecording];
    }else{
        NSString *defultPath = [self getVideoPathCache];
        NSString *outputFielPath=[ defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mp4"]];
        NSLog(@"视频保存地址%@",outputFielPath);
        NSURL *fileUrl = [NSURL fileURLWithPath:outputFielPath];
        
        self.startRecordBtn.backgroundColor = [UIColor greenColor];
        [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
    }
}

#pragma mark - Private

- (NSString *)getVideoNameWithType:(NSString *)fileType{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@",timeStr,fileType];
    return fileName;
}

- (NSString *)getVideoPathCache {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}



#pragma mark - AVCaptureFileOutputRecordingDelegate


- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    if (error) {
        NSLog(@"------------------- %@",error.description);
        return;
    }
    
    
    if (@available(iOS 9,*)) {
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetResourceCreationOptions * options = [[PHAssetResourceCreationOptions alloc] init];
        [[PHAssetCreationRequest creationRequestForAsset] addResourceWithType:PHAssetResourceTypeVideo fileURL:outputFileURL options:options];
            
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                NSLog(@"保存成功");
            }else {
                NSLog(@"%@",error.description);
            }
        }];
    }else {
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library writeVideoAtPathToSavedPhotosAlbum:outputFileURL completionBlock:^(NSURL *assetURL, NSError *error) {
            if (error) {
                NSLog(@"%@",error.description);
            }else{
                 NSLog(@"保存成功");
            }
        }];
    }
    
    
}



#pragma mark - Getter

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPreset1920x1080; // 画质
        if ([_session canAddInput:self.captureDeviceInput]) {
            [_session addInput:self.captureDeviceInput];
        }
        if ([_session canAddInput:self.audioMicInput]) {
            [_session addInput:self.audioMicInput];
        }
        if ([_session canAddOutput:self.captureMovieFileOutput]) {
            [_session  addOutput:self.captureMovieFileOutput];
        }
        
        
    }
    return _session;
}


- (AVCaptureDeviceInput *)captureDeviceInput {
    if (!_captureDeviceInput) {
        _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:self.captureDevice error:nil];
    }
    return _captureDeviceInput;
}

- (AVCaptureDeviceInput *)audioMicInput {
    if (_audioMicInput == nil) {
        AVCaptureDevice *mic = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio];
        NSError *error;
        _audioMicInput = [AVCaptureDeviceInput deviceInputWithDevice:mic error:&error];
        if (error) {
          //  NSLog(@"获取麦克风失败~%d",[self isAvailableWithMic]);
        }
    }
    return _audioMicInput;
}


- (AVCaptureMovieFileOutput *)captureMovieFileOutput
{
    if(!_captureMovieFileOutput ){
        _captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc]init];
    }
    return _captureMovieFileOutput;
}


- (AVCaptureDevice *)captureDevice {
    if (!_captureDevice) {
        _captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _captureDevice;
}

-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}


- (AVCaptureConnection *)videoConnection {
    if (!_videoConnection) {
        _videoConnection = [self.captureMovieFileOutput connectionWithMediaType:AVMediaTypeVideo];
        if ([_videoConnection isVideoStabilizationSupported]) {
            _videoConnection.preferredVideoStabilizationMode = AVCaptureVideoStabilizationModeAuto;
        }
    }
    return _videoConnection;
}


-(AVCaptureDevicePosition)position{
    if (!_position) {
        _position = AVCaptureDevicePositionFront;
    }
    return _position;
}

#pragma mark - Getter UI


- (UIButton *)startRecordBtn {
    if (!_startRecordBtn) {
        _startRecordBtn = [[UIButton alloc] init];
        [_startRecordBtn addTarget:self action:@selector(didClickStartBtn) forControlEvents:UIControlEventTouchUpInside];
        _startRecordBtn.backgroundColor = [UIColor redColor];
    }
    return _startRecordBtn;
}


- (CALayer *)itemLayer {
    if (!_itemLayer) {
        _itemLayer = [CALayer layer];
    }
    return _itemLayer;
}

@end
