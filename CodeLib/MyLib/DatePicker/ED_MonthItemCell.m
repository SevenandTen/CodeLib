//
//  ED_MonthItemCell.m
//  CodeLib
//
//  Created by zw on 2018/12/12.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_MonthItemCell.h"

@interface ED_MonthItemCell ()

@property (nonatomic , strong) UILabel *label1;

@property (nonatomic , strong) UILabel *label2;

@property (nonatomic , weak) UICollectionView *collectView;

@property (nonatomic , assign) CGFloat lastOffsetX;

@end

@implementation ED_MonthItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}


- (void)configureViews {
    [self addSubview:self.label1];
    
    [self addSubview:self.label2];

    
}


- (void)refreshCellWithTitle:(NSString *)title {
    self.label1.text = title;
    self.label2.text = title;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && [newSuperview isKindOfClass:[UICollectionView class]]) {
        self.collectView = (UICollectionView *)newSuperview;
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld;
        [self.collectView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    
    }
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self collectViewDidScroll];
    }
}



- (void)collectViewDidScroll {
    CGFloat offSetX = self.collectView.contentOffset.x;
    CGFloat contentLeft = self.collectView.contentInset.left;
    CGFloat originX = self.frame.origin.x;
    CGFloat maxX = CGRectGetMaxX(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat zeroPointX1 = offSetX + contentLeft;
    CGFloat zeroPointX2 =  zeroPointX1 + width;
    if (maxX < zeroPointX1 || originX > zeroPointX2)  {
        self.label2.hidden = YES;
        CALayer *layer = [CALayer layer];
        layer.frame = self.label1.bounds;
        [self.label1.layer setMask:layer];
        layer.backgroundColor = [UIColor redColor].CGColor;
//        [self.label1 setNeedsDisplay];
        
    }else{
        self.label2.hidden = NO;
        if (originX  >= zeroPointX1) {
            CGFloat itemWidth =  maxX -zeroPointX2 ;
//            self.label1.layer.contentsGravity = kCAGravityRight ;
//            self.label2.layer.contentsGravity = kCAGravityLeft;
            CALayer *layer1 = [CALayer layer];
            layer1.frame = CGRectMake((1 - itemWidth/width)*self.label1.bounds.size.width, 0, itemWidth/width * self.label1.bounds.size.width, self.label1.bounds.size.height);
//            self.label1.layer.contentsRect = CGRectMake(1 - itemWidth/width, 0, itemWidth/width, 1);
            layer1.backgroundColor = [UIColor blueColor].CGColor;
            [self.label1.layer setMask:layer1];
//
            
            CALayer *layer2 = [CALayer layer];
             layer2.backgroundColor = [UIColor redColor].CGColor;
            layer2.frame = CGRectMake(0, 0, (1- itemWidth/width) *self.label2.bounds.size.width, self.label2.bounds.size.height);
            
            [self.label2.layer setMask:layer2];

//            self.label2.layer.contentsRect = CGRectMake(0, 0, 1- itemWidth/width, 1);
            
        }else{
//            self.label1.layer.contentsGravity =  kCAGravityLeft;
//            self.label2.layer.contentsGravity = kCAGravityRight;
            CGFloat itemWidth = zeroPointX1 - originX;
//            self.label1.layer.contentsRect = CGRectMake(0, 0, itemWidth/width, 1);
            CALayer *layer1 = [CALayer layer];
            layer1.frame = CGRectMake(0, 0, itemWidth/width * self.label1.bounds.size.width, self.label1.bounds.size.height);
       
            layer1.backgroundColor = [UIColor redColor].CGColor;
            [self.label1.layer setMask:layer1];

            
            CALayer *layer2 = [CALayer layer];
            layer2.backgroundColor = [UIColor redColor].CGColor;
            layer2.frame = CGRectMake(itemWidth/width * self.label2.bounds.size.width, 0, (1- itemWidth/width) *self.label2.bounds.size.width, self.label2.bounds.size.height);
            
            [self.label2.layer setMask:layer2];
 
//            self.label2.layer.contentsRect = CGRectMake(itemWidth/width, 0, 1- itemWidth/width, 1);
        }
    }

}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.label1.frame = self.bounds;
    self.label2.frame = self.bounds;
    [self collectViewDidScroll];
}


#pragma mark - Getter

- (UILabel *)label1 {
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.font = [UIFont systemFontOfSize:24];
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.textColor = [UIColor colorWithRed:206/255.0 green:216/255.0 blue:226/255.0 alpha:1];
    }
    return _label1;
}

- (UILabel *)label2 {
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.font = [UIFont systemFontOfSize:32];
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.textColor = [UIColor colorWithRed:60/255.0 green:79/255.0 blue:94/255.0 alpha:1];
        
    }
    return _label2;
}

- (void)dealloc {
    [self.collectView removeObserver:self forKeyPath:@"contentOffset"];
    self.collectView = nil;
}

@end
