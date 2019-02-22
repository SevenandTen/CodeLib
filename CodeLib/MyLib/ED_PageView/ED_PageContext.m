//
//  ED_PageContext.m
//  CodeLib
//
//  Created by zw on 2019/2/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PageContext.h"

@implementation ED_PageContextManager
@synthesize dataSource = _dataSource;
@synthesize fontNumber = _fontNumber;
@synthesize totalWidth = _totalWidth;

+ (instancetype)shareIntance {
    static ED_PageContextManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_PageContextManager alloc] init];
    });
    return manager;
}


- (void)fillWithTitleArray:(NSArray<NSString *> *)titleArray fontNumber:(CGFloat)fontNumber {
    _fontNumber = fontNumber;
    NSMutableArray *dataSource  = [NSMutableArray arrayWithCapacity:titleArray.count];
    for (NSString *title in titleArray) {
        ED_PageContext *context = [[ED_PageContext alloc] initWithTitle:title fontNumber:fontNumber];
        [dataSource addObject:context];
    }
    _dataSource = [NSArray arrayWithArray:dataSource];
}



#pragma mark - Getter

- (CGFloat)fontNumber {
    if (!_fontNumber) {
        _fontNumber = 15;
    }
    return _fontNumber;
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1];
    }
    return _lineColor;
}

- (CGFloat)totalWidth {
    if (!_totalWidth) {
        for (ED_PageContext *context in self.dataSource) {
            _totalWidth =  _totalWidth + context.width +  self.minSpace /2.0;
        }
        
    }
    return _totalWidth;
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = [UIColor blackColor];
    }
    return _normalColor;
}

- (UIColor *)seletColor {
    if (!_seletColor) {
        _seletColor = [UIColor redColor];
    }
    return _seletColor ;
}

- (CGFloat)itemWidth {
    if (!_itemWidth) {
        _itemWidth = 60;
    }
    return _itemWidth;
}


- (CGFloat)lineWidth {
    if (!_lineWidth) {
        _lineWidth = 20;
    }
    return _lineWidth;
}



@end


@implementation ED_PageContext

@synthesize width = _width;
- (instancetype)initWithTitle:(NSString *)title fontNumber:(CGFloat)fontNumber {
    if (self = [super init]) {
        _title = title;
        _fontNumber = fontNumber;
        _lastPoint = CGPointZero;
        _contentOffSet = CGPointZero;
    }
    return self;
}


#pragma mark - Private

+ (CGSize)calculateSizeWithAttributeText:(NSString *)text font:(UIFont *)font width:(CGFloat)width {
    if (text.length == 0) {
        return CGSizeZero;
    }
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:text];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.numberOfLines = 0;
    label.preferredMaxLayoutWidth = width;
    label.font = font;
    label.attributedText = attributedText;
    CGSize intrinsicContentSize = [label intrinsicContentSize];

    return CGSizeMake(ceilf(MIN(intrinsicContentSize.width, width)) , ceilf(intrinsicContentSize.height));

}


- (CGFloat)fontNumber {
    if (!_fontNumber) {
        _fontNumber = 15;
    }
    return _fontNumber;
}



- (CGFloat)width {
    if (!_width ) {
        _width = [ED_PageContext calculateSizeWithAttributeText:self.title font:[UIFont systemFontOfSize:self.fontNumber] width:MAXFLOAT].width;
    }
    return _width;
}



@end

