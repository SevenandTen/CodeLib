//
//  HorizontallyOpposedView.m
//  DriverCimelia
//
//  Created by zw on 2018/10/10.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "HorizontallyOpposedView.h"

@interface HorizontallyOpposedView () {
    UIEdgeInsets _contentInset;
}

@property (nonatomic , strong) UILabel *leftLabel;

@property (nonatomic , strong) UILabel *rightLabel;


@end

@implementation HorizontallyOpposedView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureViews];
    }
    return self;
}


#pragma mark - Public

- (void)updateLeftTitle:(NSString *)title {
    self.leftLabel.text = title;
}

- (void)updateRightTitle:(NSString *)title {
    self.rightLabel.text = title;
}

- (void)updateTitleLeft:(NSString *)left right:(NSString *)right {
    [self updateLeftTitle:left];
    [self updateRightTitle:right];
}

- (void)updateLeftFont:(UIFont *)font {
    self.leftLabel.font = font;
}
- (void)updateRihtFont:(UIFont *)font {
    self.rightLabel.font = font;
}

- (void)updateFontLeft:(UIFont *)left right:(UIFont *)right {
    [self updateLeftFont:left];
    [self updateRihtFont:right];
}


- (void)updateLeftTitleColor:(UIColor *)color {
    self.leftLabel.textColor = color;
}

- (void)updateRightTitleColor:(UIColor *)color {
    self.rightLabel.textColor = color;
    
}

- (void)updateTitleColorLeft:(UIColor *)left right:(UIColor *)right {
    [self updateLeftTitleColor:left];
    [self updateRightTitleColor:right];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateSubViewFrame];
}



#pragma mark - Private


- (void)configureViews {
    [self addSubview:self.leftLabel];
    [self addSubview:self.rightLabel];
    [self updateSubViewFrame];
    
}

- (void)setContentInset:(UIEdgeInsets)contentInset {
    _contentInset = contentInset;
    [self updateSubViewFrame];
}

- (UIEdgeInsets)contentInset {
    return _contentInset;
}


#pragma mark - private

- (void)updateSubViewFrame {
    CGRect rect = CGRectMake(self.contentInset.left, self.contentInset.top, self.bounds.size.width - self.contentInset.left - self.contentInset.right, self.bounds.size.height - self.contentInset.top - self.contentInset.bottom);
    self.leftLabel.frame = rect;
    self.rightLabel.frame = rect;
    self.leftLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.rightLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}



#pragma mark - Getter

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}


@end
