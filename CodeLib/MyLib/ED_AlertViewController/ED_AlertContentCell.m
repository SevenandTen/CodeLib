//
//  ED_AlertContentCell.m
//  SJBJingJiRen
//
//  Created by zw on 2018/8/22.
//  Copyright © 2018年 mzw. All rights reserved.
//

#import "ED_AlertContentCell.h"
@interface ED_AlertContentCell ()

@property (nonatomic , strong) UILabel *label;

@end

@implementation ED_AlertContentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    [self.contentView addSubview:self.label];
    self.label.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
    
    self.label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
   
}


- (void)refreshCellWithString:(NSString *)string isTitle:(BOOL)isTitle {
    self.label.text = string ;
    self.label.textColor = isTitle ? [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1] : [UIColor colorWithRed:28/255.0 green:196/255.0 blue:102/255.0 alpha:1];
//    self.label.font = isTitle ? [UIFont systemFontOfSize:13] : [UIFont systemFontOfSize:18];
    
}

#pragma mark - Getter

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:18];
    }
    return _label;
    
}

@end
