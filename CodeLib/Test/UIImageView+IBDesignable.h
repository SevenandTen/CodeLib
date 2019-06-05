//
//  UIImageView+IBDesignable.h
//  CodeLib
//
//  Created by zw on 2019/4/25.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (IBDesignable)

@property (nonatomic , strong) IBInspectable UIImage *image;

@end

NS_ASSUME_NONNULL_END
