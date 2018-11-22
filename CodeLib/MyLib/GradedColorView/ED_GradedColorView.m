//
//  ED_GradedColorView.m
//  CodeLib
//
//  Created by zw on 2018/11/21.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_GradedColorView.h"



@interface ED_GradedColorView ()

@property (nonatomic , strong) CAGradientLayer *colorLayer;

@end

@implementation ED_GradedColorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureViews];
    }
    return self;
}

- (void)configureViews {
    [self.layer addSublayer:self.colorLayer];
    self.colorLayer.frame = self.layer.bounds;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.colorLayer.frame = self.bounds;
}

- (void)setColors:(NSArray<UIColor *> *)colors {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [array addObject:(id)color.CGColor];
    }
    self.colorLayer.colors = array;
}

- (void)setEndPoint:(CGPoint)endPoint {
    self.colorLayer.endPoint = endPoint;
}

- (void)setStartPoint:(CGPoint)startPoint {
    self.colorLayer.startPoint = startPoint;
}

- (void)setLocations:(NSArray<NSNumber *> *)locations {
    self.colorLayer.locations = locations;
}


- (NSArray<NSNumber *> *)locations {
    return self.colorLayer.locations;
}

- (NSArray<UIColor *> *)colors {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:self.colorLayer.colors.count];
    for (id color in self.colorLayer.colors) {
        [array addObject: [UIColor colorWithCGColor:(CGColorRef)color]];
    }
    return array;
}

- (CGPoint)startPoint {
    return self.colorLayer.startPoint;
}

- (CGPoint)endPoint {
    return self.colorLayer.endPoint;
}

#pragma mark - Getter

- (CAGradientLayer *)colorLayer {
    if (!_colorLayer) {
        _colorLayer = [CAGradientLayer layer];
        _colorLayer.startPoint = CGPointMake(0, 1);
        _colorLayer.endPoint = CGPointMake(1, 1);
        _colorLayer.colors = @[(id)[UIColor redColor].CGColor ,(id)[UIColor purpleColor].CGColor];
        _colorLayer.locations = @[@(0),@(1)];
    }
    return _colorLayer;
}



@end
