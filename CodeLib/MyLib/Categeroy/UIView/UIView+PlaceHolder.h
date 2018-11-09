//
//  UIView+PlaceHolder.h
//  MyCode
//
//  Created by 崎崎石 on 2018/5/25.
//  Copyright © 2018年 崎崎石. All rights reserved.
//

#import <UIKit/UIKit.h>
// 只对 UISearchBar 或者其子类 textFiled 或者是其子类生效

@interface UIView (PlaceHolder)

//
- (void)changePlaceHolderFont:(UIFont *)font;


- (void)changePlaceHolderColor:(UIColor *)color;

- (void)changePlaceHolderWithFontNumber:(NSInteger) fontNumber;


- (void)changePlaceHolder:(NSString *)placeHolder
                    color:(UIColor *)color
                     font:(UIFont *)font;

@end
