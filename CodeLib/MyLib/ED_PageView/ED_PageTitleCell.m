//
//  ED_PageTitleCell.m
//  CodeLib
//
//  Created by zw on 2019/2/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PageTitleCell.h"
#import "ED_PageContext.h"

@interface ED_PageTitleCell ()

@property (nonatomic , strong) UILabel *label;

@end


@implementation ED_PageTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.label];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.label.frame = self.bounds;
}


- (void)refreshCellWithIndexPath:(NSIndexPath *)indexPath isSelected:(BOOL)isSelected {
    ED_PageContextManager *manager = [ED_PageContextManager shareIntance];
    ED_PageContext *context = [manager.dataSource objectAtIndex:indexPath.row];
    self.label.text = context.title;
    if (isSelected) {
        self.label.textColor = manager.seletColor;
    }else {
        self.label.textColor = manager.normalColor;
    }
    self.label.font = [UIFont systemFontOfSize:manager.fontNumber];
    
   
}


#pragma mark - Getter


- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}



@end
