//
//  ED_QRCodeView.m
//  CodeLib
//
//  Created by zw on 2019/9/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_QRCodeView.h"
#import <AVFoundation/AVFoundation.h>

@interface ED_QRCodeView ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic , strong) AVCaptureSession *session;

@property (nonatomic , strong) AVCaptureDeviceInput *videoInput; //视频输入

@property (nonatomic , strong) AVCaptureMetadataOutput *metaDataOutPut;// 二维码输入

@property (nonatomic , strong) AVCaptureDevice *defautDevice; // 摄像头 默认背摄像头

@property (nonatomic , strong) AVCaptureVideoDataOutput *videoDataOutPut;


@property (nonatomic , strong) AVCaptureVideoPreviewLayer *videoPreviewLayer; //视频展示layer





@property (nonatomic , strong) UIView *topBlackView;

@property (nonatomic , strong) UIView *bottomBlackView;

@property (nonatomic , strong) UIView *leftBlackView;

@property (nonatomic , strong) UIView *rightBlackView;




@property (nonatomic , strong) UIView *scanView;

@property (nonatomic , strong) UIView *leftTopLineView;

@property (nonatomic , strong) UIView *leftBottomLineView;

@property (nonatomic , strong) UIView *rightBottomLineView;

@property (nonatomic , strong) UIView *rightTopLineView;

@property (nonatomic , strong) UIView *topLeftLineView;

@property (nonatomic , strong) UIView *topRightLineView;

@property (nonatomic , strong) UIView *bottomLeftLineView;

@property (nonatomic , strong) UIView *bottomRightLineView;


@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIImageView *animationView;

@property (nonatomic , strong) UIButton *lightBtn;


@property (nonatomic , assign) BOOL isContinue;

@property (nonatomic , assign) BOOL isAutoLight;







@end

@implementation ED_QRCodeView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}





- (void)configureViews {
    [self.layer addSublayer:self.videoPreviewLayer];
    self.videoPreviewLayer.frame = self.bounds;
    self.metaDataOutPut.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeInterleaved2of5Code,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode,AVMetadataObjectTypeAztecCode];
    
    [self addSubview:self.topBlackView];
    [self addSubview:self.bottomBlackView];
    [self addSubview:self.rightBlackView];
    [self addSubview:self.leftBlackView];
    
    [self addSubview:self.scanView];
    
    [self.scanView addSubview:self.topLeftLineView];
    [self.scanView addSubview:self.topRightLineView];
    [self.scanView addSubview:self.bottomLeftLineView];
    [self.scanView addSubview:self.bottomRightLineView];
    [self.scanView addSubview:self.leftTopLineView];
    [self.scanView addSubview:self.leftBottomLineView];
    [self.scanView addSubview:self.rightTopLineView];
    [self.scanView addSubview:self.rightBottomLineView];
    [self.scanView addSubview:self.animationView];
    
    [self addSubview:self.tipLabel];
    
    [self addSubview:self.lightBtn];
    
    
    
    
    
}


- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    CGFloat scanWidth = width - 2 * self.spaceWidth;
    
    self.topBlackView.frame = CGRectMake(0, 0, width, (height - scanWidth)/2.0 - self.spaceHeight);
    
    self.bottomBlackView.frame = CGRectMake(0, CGRectGetMaxY(self.topBlackView.frame) + scanWidth, width, (height - scanWidth)/2.0 + self.spaceHeight);
    
    self.leftBlackView.frame = CGRectMake(0, CGRectGetMaxY(self.topBlackView.frame), self.spaceWidth, scanWidth);
    self.rightBlackView.frame = CGRectMake(self.spaceWidth + scanWidth,  CGRectGetMaxY(self.topBlackView.frame), self.spaceWidth, scanWidth);
    
    
    self.scanView.frame = CGRectMake(self.spaceWidth, CGRectGetMaxY(self.topBlackView.frame), scanWidth, scanWidth);
    
    self.tipLabel.frame = CGRectMake(0, CGRectGetMaxY(self.scanView.frame) + 10, width, 24);
    
    
    CGFloat lineWidth = 25;
    CGFloat lineHeight = 3;
    
    
    self.topLeftLineView.frame = CGRectMake(0, 0, lineWidth, lineHeight);
    
    self.topRightLineView.frame = CGRectMake(scanWidth - lineWidth, 0, lineWidth, lineHeight);
    
    
    self.bottomLeftLineView.frame = CGRectMake(0, scanWidth - lineHeight, lineWidth, lineHeight);
    
    self.bottomRightLineView.frame = CGRectMake(scanWidth - lineWidth, scanWidth - lineHeight, lineWidth, lineHeight);
    
    
    self.leftTopLineView.frame = CGRectMake(0, 0, lineHeight, lineWidth);
    self.leftBottomLineView.frame = CGRectMake(0, scanWidth - lineWidth, lineHeight, lineWidth);
    self.rightTopLineView.frame = CGRectMake(scanWidth - lineHeight, 0, lineHeight, lineWidth);
    self.rightBottomLineView.frame = CGRectMake(scanWidth - lineHeight, scanWidth - lineWidth, lineHeight, lineWidth);
    
    if (@available(iOS 11.0 , *)) {
        self.lightBtn.frame = CGRectMake((width - 18 )/2.0, height -  self.safeAreaInsets.bottom  - 60 - 36 , 18, 36);
        
    }else {
        self.lightBtn.frame = CGRectMake((width - 18 )/2.0, height -  60 - 36 , 18, 36);
    }
    
    
    
}

#pragma mark - Publish

- (void)startRuning {
    
    [self.session startRunning];
    self.isContinue = YES;
    self.isAutoLight = YES;

}

- (void)stopRuning {
    self.isContinue = NO;
    self.isAutoLight = NO;
    [self.session stopRunning];
    
    [self.defautDevice lockForConfiguration:nil];
      
      if ([self.defautDevice hasFlash]) {
          if (self.defautDevice.flashMode == AVCaptureFlashModeOn) {
              self.defautDevice.flashMode = AVCaptureFlashModeOff;
              self.defautDevice.torchMode = AVCaptureFlashModeOff;
              self.lightBtn.selected = NO;
          }
      }
      
      [self.defautDevice unlockForConfiguration];
    
    
    
}

- (void)continueRuning {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isContinue = YES;
    });
    
    
}



#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (!self.isContinue) {
        return;
    }
    self.isContinue = NO;
    
    if (metadataObjects.count > 0) {
         AVMetadataMachineReadableCodeObject *code = (AVMetadataMachineReadableCodeObject *)metadataObjects.lastObject;
        NSLog(@"%@",code.stringValue);
    }
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (!self.isAutoLight) {
        return;
    }
    
  
    self.isAutoLight = NO;
     CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
     NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    // brightnessValue 值代表光线强度，值越小代表光线越暗
    if (brightnessValue <= -2) {
        if (self.defautDevice.flashMode == AVCaptureFlashModeOn) {
            return;
        }else{
            [self didClickLight];
        }
    }
    NSLog(@"%f",brightnessValue);
        
    
}

#pragma mark - Action

- (void)didClickLight {
    
    [self.defautDevice lockForConfiguration:nil];
    
    if ([self.defautDevice hasFlash]) {
        if (self.defautDevice.flashMode == AVCaptureFlashModeOn) {
            self.defautDevice.flashMode = AVCaptureFlashModeOff;
            self.defautDevice.torchMode = AVCaptureFlashModeOff;
            self.lightBtn.selected = NO;
        }else {
            self.defautDevice.flashMode = AVCaptureFlashModeOn;
            self.defautDevice.torchMode = AVCaptureTorchModeOn;
            self.lightBtn.selected = YES;
        }
    }
    
    [self.defautDevice unlockForConfiguration];
}


#pragma mark - Private

- (UIView *)getBlackView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    return view;
}


- (UIView *)getLineView {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0 green:235/255.0 blue:104/255.0 alpha:1];
    return view;
}


 
#pragma mark - Getter   AVFoundation


- (AVCaptureSession *)session {
    if (!_session) {
         _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.videoInput]) {
            [_session addInput:self.videoInput];
        }
        if ([_session canAddOutput:self.metaDataOutPut]) {
            [_session addOutput:self.metaDataOutPut];
        }
        if ([_session canAddOutput:self.videoDataOutPut]) {
            [_session addOutput:self.videoDataOutPut];
        }
        
    }
    return _session;
}



- (AVCaptureInput *)videoInput {
    if (!_videoInput) {
        _videoInput = [[AVCaptureDeviceInput alloc ] initWithDevice:self.defautDevice error:nil];
    }
    return _videoInput;
}

- (AVCaptureMetadataOutput *)metaDataOutPut {
    if (!_metaDataOutPut) {
        _metaDataOutPut = [[AVCaptureMetadataOutput alloc] init];
        [_metaDataOutPut setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    }
    return _metaDataOutPut;
}

- (AVCaptureVideoDataOutput *)videoDataOutPut {
    if (!_videoDataOutPut) {
        _videoDataOutPut = [[AVCaptureVideoDataOutput alloc] init];
        [_videoDataOutPut setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    }
    return _videoDataOutPut;
}

- (AVCaptureDevice *)defautDevice {
    if (!_defautDevice) {
        _defautDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _defautDevice;
}


- (AVCaptureVideoPreviewLayer *)videoPreviewLayer { // 视频展示layer
    if (!_videoPreviewLayer) {
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    }
    return _videoPreviewLayer;
}


#pragma mark - Getter   space


- (CGFloat)spaceWidth {
    if (_spaceWidth == 0) {
        _spaceWidth = 30;
    }
    return _spaceWidth;
}


#pragma mark - Getter   UIKit


- (UIView *)topBlackView {
    if (!_topBlackView) {
        _topBlackView = [self getBlackView];
    }
    return _topBlackView;
}


- (UIView *)bottomBlackView {
    if (!_bottomBlackView) {
        _bottomBlackView = [self getBlackView];
    }
    return _bottomBlackView;
}

- (UIView *)leftBlackView {
    if (!_leftBlackView) {
        _leftBlackView = [self getBlackView];
    }
    return _leftBlackView;
}

- (UIView *)rightBlackView {
    if (!_rightBlackView) {
        _rightBlackView = [self getBlackView];
    }
    return _rightBlackView;
}


- (UIView *)scanView {
    if (!_scanView) {
        _scanView = [[UIView alloc] init];
        _scanView.backgroundColor = [UIColor clearColor];
        _scanView.layer.masksToBounds = YES;
    }
    return _scanView;
}


- (UIView *)leftBottomLineView {
    if (!_leftBottomLineView) {
        _leftBottomLineView = [self getLineView];
    }
    return _leftBottomLineView;
}

- (UIView *)leftTopLineView {
    if (!_leftTopLineView) {
        _leftTopLineView = [self getLineView];
    }
    return _leftTopLineView;
}


- (UIView *)rightTopLineView {
    if (!_rightTopLineView) {
        _rightTopLineView = [self getLineView];
    }
    return _rightTopLineView;
}


- (UIView *)topRightLineView {
    if (!_topRightLineView) {
        _topRightLineView = [self getLineView];
    }
    return _topRightLineView;
}

- (UIView *)topLeftLineView {
    if (!_topLeftLineView) {
        _topLeftLineView = [self getLineView];
    }
    return _topLeftLineView;
}



- (UIView *)bottomLeftLineView {
    if (!_bottomLeftLineView) {
        _bottomLeftLineView = [self getLineView];
    }
    return _bottomLeftLineView;
}


- (UIView *)bottomRightLineView {
    if (!_bottomRightLineView) {
        _bottomRightLineView = [self getLineView];
    }
    return _bottomRightLineView;
}


- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.text = @"请保持二维码位于拍摄框内";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1];
    }
    return _tipLabel;
}


- (UIButton *)lightBtn {
    if (!_lightBtn) {
        _lightBtn = [[UIButton alloc] init];
        [_lightBtn setImage:[UIImage imageNamed:@"nav_dt_off"] forState:UIControlStateNormal];
        [_lightBtn setImage:[UIImage imageNamed:@"nav_dt_on"] forState:UIControlStateSelected];
        [_lightBtn addTarget:self action:@selector(didClickLight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lightBtn;
}

- (UIImageView *)animationView {
    if (!_animationView) {
        _animationView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zx_code_line"]];
    }
    return _animationView;
}


@end
