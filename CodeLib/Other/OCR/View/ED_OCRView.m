//
//  ED_OCRView.m
//  CodeLib
//
//  Created by zw on 2019/6/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_OCRView.h"
#import <AVFoundation/AVFoundation.h>
#import "ED_RectView.h"
#import "UIImage+ModifyColor.h"

@interface ED_OCRView ()<AVCaptureMetadataOutputObjectsDelegate,AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic , strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@property (nonatomic , strong) AVCaptureSession *session;

@property (nonatomic , strong) AVCaptureInput *input;

@property (nonatomic , strong) AVCaptureMetadataOutput *output;

@property (nonatomic , strong) AVCaptureVideoDataOutput *videOutput;

@property (nonatomic , strong) AVCaptureDeviceInput *deviceInput;

@property (nonatomic , strong) AVCaptureDevice *frontDevice;

@property (nonatomic , strong) AVCaptureDevice *backDevice;

@property (nonatomic , strong) UIView *faceView;


@property (nonatomic , strong) CIDetector *detector;


@property (nonatomic , strong) ED_RectView *rectView;

@property (nonatomic , strong) UIImageView *fileImageView;

@property (nonatomic , assign) NSInteger count;







@end


@implementation ED_OCRView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    [self.layer addSublayer:self.videoPreviewLayer];
//    [self addSubview:self.fileImageView];
    [self addSubview:self.rectView];
    
//    self.output.metadataObjectTypes = @[AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode,AVMetadataObjectTypeFace];
    
    [self.session startRunning];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.videoPreviewLayer.frame = self.bounds;
//    self.fileImageView.frame = CGRectMake(0, 0, 100, 300);
    self.rectView.frame = self.bounds;
    
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    [self.faceView removeFromSuperview];
    if (metadataObjects.count > 0) {
        NSLog(@"--------------------------")
        for (AVMetadataObject *obj in metadataObjects) {
            if ([obj.type isEqualToString: AVMetadataObjectTypeFace]) {
                AVMetadataFaceObject *face = (AVMetadataFaceObject *)obj;
                NSLog(@"%ld", face.faceID);
                NSLog(@"%f",face.yawAngle);
                NSLog(@"%f",face.rollAngle);
                NSLog(@"%@",NSStringFromCGRect(face.bounds));
              AVMetadataObject * newFace = [self.videoPreviewLayer transformedMetadataObjectForMetadataObject:face];
                NSLog(@"%@",NSStringFromCGRect(newFace.bounds));
                
                [self addSubview:self.faceView];
          
                self.faceView.frame = newFace.bounds;

            }else {
                AVMetadataMachineReadableCodeObject *code = (AVMetadataMachineReadableCodeObject *)obj;
                NSLog(@"%@",code.stringValue);
            }
        }
    }
}


#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    if (!CMSampleBufferIsValid(sampleBuffer)) {
        return;
    }
    self.count ++ ;
    if (self.count % 2 == 0) {
        return;
    }
    
    
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *image = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    
    CIFilter *transform = [CIFilter filterWithName:@"CIAffineTransform"];
    [transform setValue:image forKey:kCIInputImageKey];
    NSValue *rotation = [NSValue valueWithCGAffineTransform:CGAffineTransformMakeRotation(-90 * (M_PI/180))];
    [transform setValue:rotation forKey:@"inputTransform"];
    image = [transform outputImage];
 

    
    NSLog(@"--------------------------");
    NSArray<CIFeature *> * features = [self.detector featuresInImage:image];
    
   
    
    if (features.count != 0) {
        CGRect previewRect = self.bounds;
        CGRect imageRect = image.extent;
        CGFloat deltaX = CGRectGetWidth(previewRect)/CGRectGetWidth(imageRect);
        CGFloat deltaY = CGRectGetHeight(previewRect)/CGRectGetHeight(imageRect);
        CGAffineTransform transform2 = CGAffineTransformMakeTranslation(0.f, CGRectGetHeight(previewRect));
        transform2 = CGAffineTransformScale(transform2, 1, -1);
        transform2 = CGAffineTransformScale(transform2, deltaX, deltaY);
        CIRectangleFeature *currentRect = nil;
        
        for (CIFeature *obj in features) {
            if ([obj.type isEqualToString:CIFeatureTypeRectangle]) {
                CIRectangleFeature *rectObject = (CIRectangleFeature *)obj;
                if (currentRect && rectObject.bounds.size.width * rectObject.bounds.size.height > currentRect.bounds.size.width * currentRect.bounds.size.height) {
                    currentRect = rectObject;
                }else {
                    currentRect = rectObject;
                }
            }
        }
       
            CGPoint points[4];
            points[0] = CGPointApplyAffineTransform(currentRect.topLeft, transform2);
            points[1] = CGPointApplyAffineTransform(currentRect.topRight, transform2);
            points[2] = CGPointApplyAffineTransform(currentRect.bottomRight, transform2);
            points[3] = CGPointApplyAffineTransform(currentRect.bottomLeft, transform2);
        
        [self.rectView refreshPoint1:points[0] point2:points[1] point3:points[2] point4:points[3]];
    
        
        
    }else{
        [self.rectView refreshPoint1:CGPointZero point2:CGPointZero point3:CGPointZero point4:CGPointZero];
    }
    
    
}

#pragma mark - Private

- (UIImage *)imageFromSampleBuffer:(CMSampleBufferRef)sampleBuffer{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer);
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8,
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context);
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}


#pragma mark - Getter

- (AVCaptureSession *)session {
    if (!_session) {
        _session = [[AVCaptureSession alloc] init];
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([_session canAddInput:self.input]) {
            [_session addInput:self.input];
        }
//        if ([_session canAddOutput:self.output]) {
//            [_session addOutput:self.output];
//        }
        if ([_session canAddOutput:self.videOutput]) {
            [_session addOutput:self.videOutput];
        }
    }
    return _session;
}


- (AVCaptureVideoPreviewLayer *)videoPreviewLayer {
    if (!_videoPreviewLayer) {
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspect];
    }
    return _videoPreviewLayer;
}

- (AVCaptureDevice *)frontDevice {
    if (!_frontDevice) {
        _frontDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _frontDevice;
}


- (AVCaptureInput *)input {
    if (!_input) {
        _input = [[AVCaptureDeviceInput alloc] initWithDevice:self.frontDevice error:nil];
    }
    return _input;
}


- (AVCaptureMetadataOutput *)output {
    if (!_output) {
        _output = [[AVCaptureMetadataOutput alloc] init];
        [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
       
    }
    return _output;
}

- (AVCaptureVideoDataOutput *)videOutput {
    if (!_videOutput) {
        _videOutput = [[AVCaptureVideoDataOutput alloc] init];
       
        [_videOutput setAlwaysDiscardsLateVideoFrames:YES];
        [_videOutput setVideoSettings:@{(id)kCVPixelBufferPixelFormatTypeKey:@(kCVPixelFormatType_32BGRA)}];
        [_videOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
        
        
    }
    return _videOutput;
}


- (CIDetector *)detector {
    if (!_detector) {
        _detector = [CIDetector detectorOfType:CIDetectorTypeRectangle context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    }
    return _detector;
}

- (UIView *)faceView {
    if (!_faceView) {
        _faceView = [[UIView alloc] init];
        _faceView.backgroundColor = [UIColor redColor];
    }
    return _faceView;
}

- (ED_RectView *)rectView {
    if (!_rectView) {
        _rectView = [[ED_RectView alloc] init];
    }
    return _rectView;
}


//- (UIImageView *)fileImageView {
//    if (!_fileImageView) {
//        _fileImageView = [[UIImageView alloc] init];
////        _fileImageView.layer.masksToBounds = YES;
////        _fileImageView.contentMode = UIViewContentModeCenter;
////        _fileImageView.backgroundColor = [UIColor whiteColor];
//    }
//    return _fileImageView;
//}

@end
