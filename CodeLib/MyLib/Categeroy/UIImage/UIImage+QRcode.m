//
//  UIImage+QRcode.m
//  CodeLib
//
//  Created by zw on 2019/3/26.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "UIImage+QRcode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (QRcode)


+ (UIImage *)createQRcodeWithContent:(NSString *)content size:(CGSize)size {
    if (content.length == 0) {
        return nil;
    }
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    CIImage *image = [filter outputImage];
    
    return [self getHDImageWithCIImage:image size:size];
}


+ (UIImage *)getHDImageWithCIImage:(CIImage *)image size:(CGSize)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
     // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
        // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (UIImage *)getHDImageWithUIImage:(UIImage *)image size:(CGSize)size {
    return [self getHDImageWithCIImage:image.CIImage size:size];
}



+ (NSString *)readQRcodeFromImage:(UIImage *)image {
    if (!image) {
        return nil;
    }
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy:CIDetectorAccuracyHigh}];
    //转成CIImage
    NSData *data = UIImagePNGRepresentation(image);
    CIImage *ciimage = [CIImage imageWithData:data];
    if (!ciimage) {
        return nil;
    }
    //检测结果
    NSArray *features = [detector featuresInImage:ciimage];
    if (features.count == 0) {
        return nil;
    }
    CIQRCodeFeature *feature = [features firstObject];
    //打印
    NSString *string = [feature messageString];
    return string;
}

@end
