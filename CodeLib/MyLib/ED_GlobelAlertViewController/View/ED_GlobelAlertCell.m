//
//  ED_GlobelAlertCell.m
//  CodeLib
//
//  Created by zw on 2020/1/16.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_GlobelAlertCell.h"
#import "ED_GlobelAlertModel.h"

@interface ED_GlobelAlertCell ()

@property (nonatomic , strong) UILabel *contentLabel;

@property (nonatomic , strong) UIView *lineView;

@end

@implementation ED_GlobelAlertCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    [self addSubview:self.contentLabel];
    [self addSubview:self.lineView];
}


- (void)setLineColor:(UIColor *)lineColor {
    self.lineView.backgroundColor = lineColor;
}

- (void)refreshCellWithObject:(id)object {
    if (object && [object isKindOfClass:[NSString class]]) {
        self.contentLabel.text = object;
    }
    if (object && [object isKindOfClass:[ED_GlobelAlertModel class]]) {
        ED_GlobelAlertModel *model = (ED_GlobelAlertModel *)object;
        if (model.attributeText) {
            self.contentLabel.attributedText = model.attributeText;
        }
        self.contentLabel.text = model.text;
        self.contentLabel.textColor = model.textColor;
        self.contentLabel.font = model.font;
    }
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentLabel.frame = self.bounds;
    CGFloat height = 1 /[UIScreen mainScreen].scale;
    self.lineView.frame = CGRectMake(0, self.bounds.size.height - height , self.bounds.size.width,height);
}


#pragma mark - Getter

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.font = [UIFont systemFontOfSize:18];
        _contentLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0  alpha:1];
    }
    return _contentLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0  alpha:1];
    }
    return _lineView;
}

@end
