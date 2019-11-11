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
#import <CoreGraphics/CoreGraphics.h>
#import "ED_VideoMakeControl.h"
#import "ED_MovieRecord.h"





@interface ED_VideoMakerView ()<AVCaptureVideoDataOutputSampleBufferDelegate,AVCaptureAudioDataOutputSampleBufferDelegate>

@property (nonatomic , strong) AVCaptureSession *session; //负责输入和输出设备之间的连接会话



@property (nonatomic , strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic , strong) UIButton *startRecordBtn;

@property (nonatomic , strong) UIView *timeView;

@property (nonatomic , strong) UILabel *timeLabel;

@property (nonatomic , strong) NSTimer *timer;


@property (nonatomic , strong) AVCaptureDeviceInput *videoIntput;// 视频输入源

@property (nonatomic , strong) AVCaptureVideoDataOutput *videoOutput; //视频输出源

@property (nonatomic , strong) AVCaptureDeviceInput *audioIntput; // 音频输入

@property (nonatomic , strong) AVCaptureAudioDataOutput *audioOutput; // 音频输出


@property (nonatomic , strong) NSDictionary *videoSettings;

@property (nonatomic , strong) NSDictionary *audioSettings;


@property (nonatomic , strong) ED_MovieRecord *movieRecord;


@property (nonatomic , strong) UIImageView *testImageView;

@property (nonatomic , assign) NSInteger count;







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
   
    
    [self addSubview:self.timeView];
    [self.timeView addSubview:self.timeLabel];
    
     [self addSubview:self.startRecordBtn];
    
    [self addSubview:self.testImageView];

    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}


- (void)layoutSubviews {
    self.previewLayer.frame = self.bounds;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self.session startRunning];
    });
    
    self.timeView.frame = self.bounds;
    self.timeLabel.frame = CGRectMake(0, 100 , self.bounds.size.width - 20, 24);
    
    self.testImageView.frame = CGRectMake(0, 0, self.bounds.size.width/2.0, self.bounds.size.height / 2.0);
    
    self.startRecordBtn.frame = CGRectMake((self.bounds.size.width - 50)/2.0, self.bounds.size.height - 100, 50, 50);
}


#pragma mark - Action

- (void)didClickStartBtn {
    
}

- (void)updateTime {
    self.timeLabel.text  = [self getNowDate];
   
    
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






- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}



#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate


- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {

    
    
    if ([connection isEqual:[self.videoOutput connectionWithMediaType:AVMediaTypeVideo]]) {
        if (!self.videoSettings) {
            self.videoSettings = [self.videoOutput recommendedVideoSettingsForAssetWriterWithOutputFileType:AVFileTypeQuickTimeMovie];
            
        }
        
        NSData *data = [self convertVideoSmapleBufferToYuvData:sampleBuffer];
        NSLog(@"%@",data);
        
        dispatch_async(dispatch_get_main_queue(), ^{
        
           
        });
        
    }else {
        if (!self.audioSettings) {
             self.audioSettings = [self.audioOutput recommendedAudioSettingsForAssetWriterWithOutputFileType:AVFileTypeQuickTimeMovie];
        }
      
     
        
    }
    
}



- (NSData *)convertVideoSmapleBufferToYuvData:(CMSampleBufferRef) videoSample{

    // 获取yuv数据

    // 通过CMSampleBufferGetImageBuffer方法，获得CVImageBufferRef。

    // 这里面就包含了yuv420(NV12)数据的指针

    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(videoSample);

    //表示开始操作数据

    CVPixelBufferLockBaseAddress(pixelBuffer, 0);

    //图像宽度（像素）

    size_t pixelWidth = CVPixelBufferGetWidth(pixelBuffer);

    //图像高度（像素）

    size_t pixelHeight = CVPixelBufferGetHeight(pixelBuffer);

    //yuv中的y所占字节数

    size_t y_size = pixelWidth * pixelHeight;

    //yuv中的uv所占的字节数

    size_t uv_size = y_size / 2;

    uint8_t *yuv_frame = malloc(uv_size + y_size);

    //获取CVImageBufferRef中的y数据

    uint8_t *y_frame = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);

    memcpy(yuv_frame, y_frame, y_size);

    //获取CMVImageBufferRef中的uv数据

    uint8_t *uv_frame = CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 1);

    memcpy(yuv_frame + y_size, uv_frame, uv_size);

    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);

//    return yuv_frame;


    return [NSData dataWithBytesNoCopy:yuv_frame length:y_size + uv_size];

}





- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer{

    // 为媒体数据设置一个CMSampleBuffer的Core Video图像缓存对象

    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);

    // 锁定pixel buffer的基地址

    CVPixelBufferLockBaseAddress(imageBuffer, 0);

    // 得到pixel buffer的基地址

    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);

    // 得到pixel buffer的行字节数

    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);

    // 得到pixel buffer的宽和高

    size_t width = CVPixelBufferGetWidth(imageBuffer);

    size_t height = CVPixelBufferGetHeight(imageBuffer);

    // 创建一个依赖于设备的RGB颜色空间

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // 用抽样缓存的数据创建一个位图格式的图形上下文（graphics context）对象

    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,

    bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);

    // 根据这个位图context中的像素数据创建一个Quartz image对象

    CGImageRef quartzImage = CGBitmapContextCreateImage(context);

    // 解锁pixel buffer

    CVPixelBufferUnlockBaseAddress(imageBuffer,0);

    // 释放context和颜色空间

    CGContextRelease(context);

    CGColorSpaceRelease(colorSpace);

    // 用Quartz image创建一个UIImage对象image

    UIImage *image = [UIImage imageWithCGImage:quartzImage scale:1.0 orientation:UIImageOrientationRight];

    // 释放Quartz image对象

    CGImageRelease(quartzImage);

    return (image);

}


- (UIImage *)imageSetString_image:(UIImage *)image text:(NSString *)text textPoint:(CGPoint)point attributedString:(NSDictionary * )attributed
{
    //1.开启上下文
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    //2.绘制图片
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    //添加水印文字
    [text drawAtPoint:point withAttributes:attributed];
    //3.从上下文中获取新图片
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    //4.关闭图形上下文
//    UIGraphicsEndImageContext();
    //返回图片
    return img;
}



- (UIImage *)imageWithView:(UIView *)view {
    
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}


- (UIImage *)combineImageOne:(UIImage *)image1 imageTwo:(UIImage *)image2 {
  
    CGImageRef imgRef = image2.CGImage;
    CGFloat w = CGImageGetWidth(imgRef);
    CGFloat h = CGImageGetHeight(imgRef);
    
    //以1.png的图大小为底图
   
    CGImageRef imgRef1 = image1.CGImage;
    CGFloat w1 = CGImageGetWidth(imgRef1);
    CGFloat h1 = CGImageGetHeight(imgRef1);
    
    //以1.png的图大小为画布创建上下文
    UIGraphicsBeginImageContext(CGSizeMake(w1, h1));
    [image1 drawInRect:CGRectMake(0, 0, w1, h1)];//先把1.png 画到上下文中
    [image2 drawInRect:CGRectMake(0, 0, w, h)];//再把小图放在上下文中
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();//从当前上下文中获得最终图片
    UIGraphicsEndImageContext();//关闭上下文

    CGImageRelease(imgRef);
    CGImageRelease(imgRef1);
    return resultImg ;
   
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



- (UIView *)timeView {
    if (!_timeView) {
        _timeView = [[UIView alloc] init];
        _timeView.backgroundColor = [UIColor clearColor];
    }
    return _timeView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentRight;
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.font = [UIFont systemFontOfSize:18];
    }
    return _timeLabel;
}


- (UIImageView *)testImageView {
    if (!_testImageView) {
        _testImageView = [[UIImageView alloc] init];
        _testImageView.layer.masksToBounds = YES;
    }
    return _testImageView;
}



#pragma mark - Getter

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        _session.sessionPreset = AVCaptureSessionPreset1920x1080; // 画质
        if ([_session canAddInput:self.videoIntput]) {
            [_session addInput:self.videoIntput];
        }
        
        if ([_session canAddOutput:self.videoOutput]) {
            [_session addOutput:self.videoOutput];
        }
        
        if ([_session canAddInput:self.audioIntput]) {
            [_session addInput:self.audioIntput];
        }
        
        if ([_session canAddOutput:self.audioOutput]) {
            [_session addOutput:self.audioOutput];
        }
        
        
    }
    return _session;
}

- (AVCaptureDeviceInput *)videoIntput {
    if (!_videoIntput) {
        _videoIntput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo] error:nil];
    }
    return _videoIntput;
}

- (AVCaptureVideoDataOutput *)videoOutput {
    if (!_videoOutput) {
        _videoOutput = [[AVCaptureVideoDataOutput alloc] init];
        [_videoOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)}];
        [_videoOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)];
    }
    return _videoOutput;
}


- (AVCaptureDeviceInput *)audioIntput {
    if (!_audioIntput) {
        _audioIntput = [[AVCaptureDeviceInput alloc] initWithDevice:[AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeAudio] error:nil];
    }
    return _audioIntput;
}

- (AVCaptureAudioDataOutput *)audioOutput  {
    if (!_audioOutput) {
        _audioOutput = [[AVCaptureAudioDataOutput alloc] init];
        [_audioOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)];
    }
    return _audioOutput;
}



-(AVCaptureVideoPreviewLayer *)previewLayer{
    if (!_previewLayer) {
        _previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return _previewLayer;
}





@end
