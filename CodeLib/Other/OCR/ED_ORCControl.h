//
//  ED_ORCControl.h
//  CodeLib
//
//  Created by zw on 2019/6/19.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface ED_ORCControl : NSObject


/**
  图片灰度处理
 */
+ (UIImage *)opencvGrayProcessingWithImage:(UIImage *)image;

/**
 图片二值化
 */
+ (UIImage *)opencvBinaryzationWithImage:(UIImage *)image;

@end


