//
//  UIImage+QRcode.h
//  CodeLib
//
//  Created by zw on 2019/3/26.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (QRcode)


+ (UIImage *)createQRcodeWithContent:(NSString *)content size:(CGSize)size;


+ (UIImage *)getHDImageWithCIImage:(CIImage *)image size:(CGSize)size;

+ (UIImage *)getHDImageWithUIImage:(UIImage *)image size:(CGSize)size;


+ (NSString *)readQRcodeFromImage:(UIImage *)image;

@end

NS_ASSUME_NONNULL_END
