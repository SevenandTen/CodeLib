//
//  ED_VideoRecordView.m
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_VideoRecordView.h"
#import <AVFoundation/AVFoundation.h>
#import "ED_VideoRecordControl.h"
#import "ED_ProgressView.h"

@interface ED_VideoRecordView ()<AVCaptureFileOutputRecordingDelegate>

@property (nonatomic , strong) AVCaptureSession *session; //负责输入和输出设备之间的连接会话

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic , strong) UIButton *startRecordBtn;


@property (nonatomic , strong) NSTimer *timer;


@property (nonatomic , strong) AVCaptureDeviceInput *videoIntput;// 视频输入源

@property (nonatomic , strong) AVCaptureDeviceInput *otherVideoInput;

@property (nonatomic , strong) AVCaptureMovieFileOutput *movieOutput; //视频输出

@property (nonatomic , strong) AVCaptureDeviceInput *audioIntput; // 音频输入


//@property (nonatomic , strong) AVCaptureOutput

@property (nonatomic , strong) AVCaptureConnection *videoConnection;


@property (nonatomic , strong) ED_ProgressView *progressView;

@property (nonatomic , strong) NSDate *beginDate;




@end

@implementation ED_VideoRecordView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
     [self.layer addSublayer:self.previewLayer];
    [self addSubview:self.progressView];
    [self addSubview:self.startRecordBtn];
    
}


- (void)layoutSubviews {
    self.previewLayer.frame = self.bounds;
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
           [self.session startRunning];
    });
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    
    self.progressView.frame = CGRectMake((width - 74)/2.0, height - 74 - 60, 74, 74);
    
    self.startRecordBtn.frame =  CGRectMake((width - 74)/2.0, height - 74 - 60, 74, 74);
}



#pragma mark - Action

- (void)didClickStartBtn {
    if (self.movieOutput.isRecording) {
        [self.movieOutput stopRecording];
        [self.progressView stopRecordTime];
    }else {
        NSString *defultPath = [self getVideoPathCache];
        NSString *outputFielPath=[ defultPath stringByAppendingPathComponent:[self getVideoNameWithType:@"mp4"]];
        NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
        [self.movieOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
        self.beginDate = [NSDate date];
        __weak typeof(self)weakSelf = self;
        [self.progressView startRecordTimeActionBlock:^{
            [weakSelf.movieOutput stopRecording];
        }];
        
    }

}




#pragma mark - Private
//获取当前时间
- (NSString *)getNowDate {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return  [formatter stringFromDate:date];
}

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



- (void)captureOutput:(AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *whiteView = [[UIView alloc] initWithFrame:CGRectMake((self.bounds.size.width - 50)/2.0, (self.bounds.size.height - 50)/2.0, 50, 50)];
          whiteView.backgroundColor = [UIColor whiteColor];
          
          UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
          [whiteView addSubview:activityView];
          [self addSubview:whiteView];
        
            [activityView startAnimating];
        
              [ED_VideoRecordControl addWaterMarkTypeWithGPUImageUIElementAndInputVideoURL:outputFileURL date:self.beginDate  WithCompletionHandler:^(NSURL *outPutURL, int code) {
                  
                  dispatch_async(dispatch_get_main_queue(), ^{
                      if ([self.delegate respondsToSelector:@selector(recordView:didFinishWithUrl:)]) {
                           [self.delegate recordView:self didFinishWithUrl:outPutURL];
                        }
                                       
                           [activityView stopAnimating];
                           [whiteView removeFromSuperview];
                         
                      });
                 
                }];

  
       });

    
    
  
}



#pragma mark - Getter


- (ED_ProgressView *)progressView {
    if (!_progressView) {
        _progressView = [[ED_ProgressView alloc] init];
    }
    return _progressView;
}


- (UIButton *)startRecordBtn {
    if (!_startRecordBtn) {
        _startRecordBtn = [[UIButton alloc] init];
        _startRecordBtn.backgroundColor = [UIColor clearColor];
        [_startRecordBtn addTarget:self action:@selector(didClickStartBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startRecordBtn;
    
}



#pragma mark - AV Getter

-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}





- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPresetHigh; // 画质
        if ([_session canAddInput:self.videoIntput]) {
            [_session addInput:self.videoIntput];
        }else if ([_session canAddInput:self.otherVideoInput]) {
            [_session addInput:self.otherVideoInput];
        }
        
        if ([_session canAddInput:self.audioIntput]) {
            [_session addInput:self.audioIntput];
        }
        if ([_session canAddOutput:self.movieOutput]) {
            [_session addOutput:self.movieOutput];
        }

        
        
    }
    return _session;
}

- (AVCaptureDeviceInput *)videoIntput {
    if (!_videoIntput) {
        AVCaptureDevice *defaultDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        NSError *error = nil;
        _videoIntput = [[AVCaptureDeviceInput alloc] initWithDevice:defaultDevice error:&error];
    }
    return _videoIntput;
}


- (AVCaptureDeviceInput *)otherVideoInput {
    if (!_otherVideoInput) {
        AVCaptureDevice *device = nil;
        if (@available(iOS 10 , *)) {
            AVCaptureDeviceDiscoverySession * dissesson = [AVCaptureDeviceDiscoverySession discoverySessionWithDeviceTypes:@[AVCaptureDeviceTypeBuiltInDuoCamera,AVCaptureDeviceTypeBuiltInTelephotoCamera,AVCaptureDeviceTypeBuiltInWideAngleCamera] mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionFront];
            for (AVCaptureDevice *obj in dissesson.devices) {
                if ([obj position] == AVCaptureDevicePositionFront ) {
                    device = obj;
                }
            }
           
        }else{
            NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
            for (AVCaptureDevice *obj in devices) {
                if (obj.position == AVCaptureDevicePositionFront ) {
                    device = obj;
                }
            }
        }
        _otherVideoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:nil];
        
    }
    return _otherVideoInput;
}



- (AVCaptureDeviceInput *)audioIntput {
    if (!_audioIntput) {
        _audioIntput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
    }
    return _audioIntput;
}



- (AVCaptureMovieFileOutput *)movieOutput {
    if (!_movieOutput) {
        _movieOutput = [[AVCaptureMovieFileOutput alloc] init];
    }
    return _movieOutput;
}


- (AVCaptureConnection *)videoConnection {
    _videoConnection = [self.movieOutput connectionWithMediaType:AVMediaTypeVideo];
    if ([_videoConnection isVideoStabilizationSupported ]) {   _videoConnection.preferredVideoStabilizationMode=AVCaptureVideoStabilizationModeAuto;
    }
    return _videoConnection;
}






@end
