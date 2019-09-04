//
//  ED_ImagePickerCell.m
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_ImagePickerCell.h"

@interface ED_ImagePickerCell ()

@property (nonatomic , strong) UIImageView *pictureView;

@end

@implementation ED_ImagePickerCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    [self addSubview:self.pictureView];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.pictureView.frame = self.bounds;
}




#pragma mark - Getter

- (UIImageView *)pictureView {
    if (!_pictureView) {
        _pictureView = [[UIImageView alloc] init];
        _pictureView.contentMode = UIViewContentModeScaleAspectFill;
        _pictureView.layer.masksToBounds = YES;
    }
    return _pictureView;
}

@end
