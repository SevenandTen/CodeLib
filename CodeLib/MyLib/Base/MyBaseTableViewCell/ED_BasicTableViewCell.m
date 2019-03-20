//
//  ED_BasicTabelViewCell.m
//  CodeLib
//
//  Created by zw on 2018/11/5.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_BasicTableViewCell.h"

@interface ED_BasicTableViewCell ()

@property (nonatomic , strong) NSMutableArray *hightLightViewArray;

@property (nonatomic , strong) CALayer *selectionLayer;

@property (nonatomic , strong) CALayer *separatorLineLayer;

@end

@implementation ED_BasicTableViewCell


#pragma mark - Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initializeHightlightedSetting];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initializeHightlightedSetting];
    }
    return self;
}

#pragma mark - Private

- (void)initializeHightlightedSetting {
    if (self.textLabel) {
        [self.hightLightViewArray addObject:self.textLabel];
    }
    if (self.detailTextLabel) {
        [self.hightLightViewArray addObject:self.detailTextLabel];
    }
    if (self.imageView) {
        [self.hightLightViewArray addObject:self.imageView];
    }
    _showType = ED_BasicTabelViewCellNone;
}

- (void)updateStatus:(BOOL)status animated:(BOOL)animated {
    for (id subView in self.hightLightViewArray) {
        if ([subView respondsToSelector:@selector(setHighlighted:)]) {
            [subView setHighlighted:status];
        }
    }
    [[self selectionView].layer insertSublayer:self.selectionLayer atIndex:0];
    self.selectionLayer.frame = [self selectionView].bounds;
    self.selectionLayer.backgroundColor = self.selectedColor ?self.selectedColor.CGColor : [UIColor lightGrayColor].CGColor;
    [CATransaction begin];
    [CATransaction setDisableActions:NO];
    if (self.showType == ED_BasicTabelViewCellSelected) {
        _selectionLayer.hidden = !(self.isSelected || self.isHighlighted);
    }else{
        _selectionLayer.hidden = !self.highlighted;
    }
    [CATransaction commit];
}


#pragma mark - SystemMethod


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    if (self.selected != selected && self.showType != ED_BasicTabelViewCellNone) {
        [super setSelected:selected animated:animated];
        [self updateStatus:selected animated:animated];
    }else{
        [super setSelected:selected animated:animated];
    }
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (self.highlighted != highlighted && self.showType != ED_BasicTabelViewCellNone) {
        [super setHighlighted:highlighted animated:animated];
        [self updateStatus:highlighted animated:animated];
    }else{
        [super setHighlighted:highlighted animated:animated];
    }
}


- (void)willMoveToWindow:(UIWindow *)newWindow {
    [super willMoveToWindow:newWindow];
    if (newWindow) {
        _separatorLineLayer = [CALayer layer];
        [self.layer addSublayer:_separatorLineLayer];
    }else{
        [_separatorLineLayer removeFromSuperlayer];
        _separatorLineLayer = nil;
    }
    
    [self setNeedsLayout];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    if (!_separatorLineLayer) {
        return;
    }
    CGRect separatorLineFrame = CGRectZero;
    separatorLineFrame.origin.x = self.lineInset.left;
    if (self.lineInset.top == 0 && self.lineInset.bottom == 0) {
        separatorLineFrame.origin.y = CGRectGetHeight(self.bounds) - self.lineWidth ;
        separatorLineFrame.size.height = self.lineWidth;
    }else if (self.lineInset.top != 0 &&self.lineInset.bottom == 0) {
        separatorLineFrame.origin.y =  self.lineInset.top;
        separatorLineFrame.size.height = self.lineWidth;
    }else if (self.lineInset.top == 0 && self.lineInset.bottom !=0 ){
        separatorLineFrame.origin.y = CGRectGetHeight(self.bounds) - self.lineInset.bottom;
        separatorLineFrame.size.height = self.lineWidth;
    }else {
         separatorLineFrame.origin.y =  self.lineInset.top;
        separatorLineFrame.size.height = CGRectGetHeight(self.bounds) - self.lineInset.top - self.lineInset.bottom;
    }
    
    
    
    separatorLineFrame.size.width = CGRectGetWidth(self.bounds) - self.lineInset.left - self.lineInset.right;
    _separatorLineLayer.backgroundColor = self.lineColor ? self.lineColor.CGColor : [UIColor grayColor].CGColor;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.separatorLineLayer.frame = separatorLineFrame;
    [CATransaction commit];
    
}

#pragma mark - Public

- (UIView *)selectionView {
    return self;
}

- (void)setShowType:(ED_BasicTabelViewCellShowType)showType {
    if (showType != ED_BasicTabelViewCellNone) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    _showType = showType;
}



#pragma mark - Getter

- (NSMutableArray *)hightLightViewArray {
    if (!_hightLightViewArray) {
        _hightLightViewArray = [[NSMutableArray alloc] init];
    }
    return _hightLightViewArray;
}

- (CALayer *)selectionLayer {
    if (!_selectionLayer) {
        _selectionLayer = [CALayer layer];
        _selectionLayer.actions = @{@"position":[NSNull null],
                                    @"bounds":[NSNull null],
                                    @"backgroundColor":[NSNull null]};
    }
    return _selectionLayer;
}




@end
