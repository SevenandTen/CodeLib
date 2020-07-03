//
//  ED_GlobelAlertModel.m
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_GlobelAlertModel.h"

@implementation ED_GlobelAlertModel


- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color attributeText:(NSAttributedString *)attributeText {
    if (self = [super init]) {
        self.font = font;
        self.text = text;
        self.textColor = color;
        self.attributeText = attributeText;
    }
    return self;
}

- (instancetype)initWithText:(NSString *)text textColor:(UIColor *)textColor {
    return [self initWithFont:nil text:text textColor:textColor attributeText:nil];
}

- (instancetype)initWithText:(NSString *)text {
    return [self initWithFont:nil text:text textColor:nil attributeText:nil];
}

- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text {
    return [self initWithFont:font text:text textColor:nil attributeText:nil];
}

- (instancetype)initWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color {
      return [self initWithFont:font text:text textColor:color attributeText:nil];
}

- (instancetype)initWithAttributeText:(NSAttributedString *)attributeText {
      return [self initWithFont:nil text:nil textColor:nil attributeText:attributeText];
}


+ (instancetype)modelWithText:(NSString *)text {
    return [self modelWithFont:nil text:text textColor:nil attributeText:nil];
}

+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color attributeText:(NSAttributedString *)attributeText {
    return  [[self alloc] initWithFont:font text:text textColor:color attributeText:attributeText];
}

+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text {
    return [self modelWithFont:font text:text textColor:nil attributeText:nil];
}

+ (instancetype)modelWithAttributeText:(NSAttributedString *)attributeText {
     return [self modelWithFont:nil text:nil textColor:nil attributeText:attributeText];
}

+ (instancetype)modelWithText:(NSString *)text textColor:(UIColor *)color {
    return [self modelWithFont:nil text:text textColor:color attributeText:nil];
}

+ (instancetype)modelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)color {
    return [self modelWithFont:font text:text textColor:color attributeText:nil];
}


- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0  alpha:1];
    }
    return _textColor;
}

- (UIFont *)font {
    if (!_font) {
        _font = [UIFont systemFontOfSize:18];
    }
    return _font;
}

@end
