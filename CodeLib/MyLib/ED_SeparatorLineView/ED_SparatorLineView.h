//
//  ED_SparatorLineView.h
//  CodeLib
//
//  Created by zw on 2019/9/6.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  NS_ENUM(NSInteger , ED_SparatorLineViewStyle) {
    ED_SparatorLineViewStyleHorizontal, // 水平
    ED_SparatorLineViewStyleVertical, // 垂直
};

@interface ED_SparatorLineView : UIView

@property (nonatomic , readonly) ED_SparatorLineViewStyle style;

@property (nonatomic , readonly) CGFloat lineLength;

@property (nonatomic , readonly) CGFloat space;

@property (nonatomic , readonly) UIColor *lineColor;


- (instancetype)initWithLineLength:(CGFloat)lineLength
                             space:(CGFloat)space
                         lineColor:(UIColor *)lineColor
                             style:(ED_SparatorLineViewStyle) style;

@end


