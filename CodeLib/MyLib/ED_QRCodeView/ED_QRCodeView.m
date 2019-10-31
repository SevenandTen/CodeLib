//
//  ED_QRCodeView.m
//  CodeLib
//
//  Created by zw on 2019/9/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_QRCodeView.h"
#import <AVFoundation/AVFoundation.h>

@interface ED_QRCodeView ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic , strong) AVCaptureSession *session;

@property (nonatomic , strong) AVCaptureInput *input;

@property (nonatomic , strong) AVCaptureMetadataOutput *output;

@property (nonatomic , strong) AVCaptureVideoDataOutput *videOutput;

@property (nonatomic , strong) AVCaptureDeviceInput *deviceInput;

@property (nonatomic , strong) AVCaptureDevice *frontDevice;

@property (nonatomic , strong) AVCaptureDevice *backDevice;

@property (nonatomic , strong) UILabel *tipLabel;

@property (nonatomic , strong) UIButton *lightBtn;

@property (nonatomic , strong) UIView *topBackView;

@property (nonatomic , strong) UIView *bottomBackView;

@property (nonatomic , strong) UIView *leftBackView;

@property (nonatomic , strong) UIView *rightBackView;



@end

@implementation ED_QRCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    self.flag = YES;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusAuthorized) {
        [self.layer addSublayer:self.videoPreviewLayer];
        self.videoPreviewLayer.frame = self.bounds;
        
        //设置扫一扫支持的类别
         self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];
        
        [self.session startRunning];
        [self addSubview:self.topBackView];
         [self addSubview:self.leftBackView];
         [self addSubview:self.rightBackView];
         [self addSubview:self.bottomBackView];
        
        [self addSubview:self.lightBtn];
        self.lightBtn.frame = CGRectMake(50,50 , 40, 40);
    }else{
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.layer addSublayer:self.videoPreviewLayer];
                    self.videoPreviewLayer.frame = self.bounds;
                    
                    //设置扫一扫支持的类别
                    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];
                    
                    [self.session startRunning];
                    
                    [self addSubview:self.topBackView];
                    [self addSubview:self.leftBackView];
                    [self addSubview:self.rightBackView];
                    [self addSubview:self.bottomBackView];
                    
                    [self addSubview:self.lightBtn];
                    self.lightBtn.frame = CGRectMake(50,50 , 40, 40);
                    
                });
                
            }else {
                NSLog(@"没有权限");
            }
        }];
    }
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.videoPreviewLayer.frame = self.bounds;
    
    CGFloat width = self.bounds.size.width - 64;
    
    self.topBackView.frame = CGRectMake(0, 0, self.bounds.size.width, (self.bounds.size.height - width)/2.0 );
    self.leftBackView.frame = CGRectMake(0, CGRectGetMaxY(self.topBackView.frame), 32, width);
    
    self.rightBackView.frame = CGRectMake(self.bounds.size.width - 32, CGRectGetMaxY(self.topBackView.frame), 32, width);
    
    self.bottomBackView.frame = CGRectMake(0, CGRectGetMaxY(self.rightBackView.frame), self.bounds.size.width, self.bounds.size.height - CGRectGetMaxY(self.rightBackView.frame));
    
}


#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (!self.flag) {
        return;
    }
    self.flag = NO;
    
    if (metadataObjects.count > 0) {
        AVMetadataObject  *obj = metadataObjects.lastObject;
        AVMetadataMachineReadableCodeObject *code = (AVMetadataMachineReadableCodeObject *)obj;
        NSLog(@"%@",code.stringValue);
        if (self.delegate && [self.delegate respondsToSelector:@selector(QRCodeView:didReceviceCode:)]) {
            [self.delegate QRCodeView:self didReceviceCode:code.stringValue];
        }
        
    }
}

#pragma mark - Action

- (void)didClickLight {
    self.lightBtn.selected = ! self.lightBtn.selected;
    NSError *error = nil;
    if (self.lightBtn.selected) {
        if ( [self.frontDevice hasTorch]) {
            BOOL lock = [self.frontDevice lockForConfiguration:&error];
            if (lock) {
                self.frontDevice.torchMode = AVCaptureTorchModeOn;
                [self.frontDevice unlockForConfiguration];
            }
        }
       
    }else{
        if ( [self.frontDevice hasTorch]) {
            BOOL lock = [self.frontDevice lockForConfiguration:&error];
            if (lock) {
                self.frontDevice.torchMode = AVCaptureTorchModeOff;
                [self.frontDevice unlockForConfiguration];
            }
        }
    }
    
}




#pragma mark - Getter


- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
        if ([_session canAddOutput:self.output]) {
            [_session addOutput:self.output];
            
        }
    }
    return _session;
}



- (AVCaptureDevice *)frontDevice {
    if (!_frontDevice) {
        _frontDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _frontDevice;
}

- (AVCaptureDevice *)backDevice {
    if (!_backDevice) {
        NSArray *array =  [AVCaptureDevice  devicesWithMediaType:AVMediaTypeVideo];
        for (AVCaptureDevice  *device in array) {
            if (device.position == AVCaptureDevicePositionFront) {
                _backDevice = device;
            }
        }
    }
    return _backDevice;
}


- (AVCaptureInput *)input {
    if (!_input) {
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:self.frontDevice error:nil];
    }
    return _input;
}



- (AVCaptureVideoPreviewLayer *)videoPreviewLayer {
    if (!_videoPreviewLayer) {
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    }
    return _videoPreviewLayer;
}



- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        
    }
    return _output;
}

- (UIButton *)lightBtn {
    if (!_lightBtn) {
        _lightBtn = [[UIButton alloc] init];
        [_lightBtn addTarget:self action:@selector(didClickLight) forControlEvents:UIControlEventTouchUpInside];
        _lightBtn.backgroundColor = [UIColor redColor];
        
    }
    return _lightBtn;
}

- (UIView *)topBackView {
    if (!_topBackView) {
        _topBackView = [[UIView alloc] init];
        _topBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return _topBackView;
}


- (UIView *)leftBackView {
    if (!_leftBackView) {
        _leftBackView = [[UIView alloc] init];
        _leftBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return _leftBackView;
}

- (UIView *)rightBackView {
    if (!_rightBackView) {
        _rightBackView = [[UIView alloc] init];
        _rightBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return _rightBackView;
}


- (UIView *)bottomBackView {
    if (!_bottomBackView) {
        _bottomBackView = [[UIView alloc] init];
        _bottomBackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
    }
    return _bottomBackView;
}


@end
