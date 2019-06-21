//
//  ED_SignView.m
//  CodeLib
//
//  Created by zw on 2019/1/23.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_SignView.h"

@interface ED_SignView ()

@property (nonatomic , strong) UIPanGestureRecognizer *panGesture;

@property (nonatomic , strong) NSMutableArray *pointArray;

@property (nonatomic , strong) NSMutableArray *colorArray;

@property (nonatomic , strong) NSMutableArray *lineWidthArray;

@end

@implementation ED_SignView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addGestureRecognizer:self.panGesture];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    if (self.pointArray.count == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
  
    for (int j = 0 ;j < self.pointArray.count ; j++) {
        NSArray *array = [self.pointArray objectAtIndex:j];
        UIColor *lineColor = nil;
        CGFloat lineWidth = 0;
        if (j >= self.colorArray.count) {
            lineColor = self.lineColor;
        }else{
            lineColor = [self.colorArray objectAtIndex:j];
        }
        if (j >= self.lineWidthArray.count) {
            lineWidth = self.lineWidth;
        }else{
            lineWidth = [[self.lineWidthArray objectAtIndex:j] floatValue];
        }
        CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
        CGContextSetLineWidth(context, lineWidth);
        
        for (int i = 0; i < array.count; i ++) {
            NSValue *value = [array objectAtIndex:i];
            CGPoint point = [value CGPointValue];
            if (i == 0) {
                CGContextMoveToPoint(context, point.x, point.y);
            }
            CGContextAddLineToPoint(context, point.x, point.y);
        }
        
        CGContextStrokePath(context);
    }
    
}


#pragma mark - Public

- (void)resetSign {
    [self.pointArray removeAllObjects];
    [self.colorArray removeAllObjects];
    [self.lineWidthArray removeAllObjects];
    [self setNeedsDisplay];
}


- (void)withdrawAction {
    if (self.pointArray.count == 0) {
        [self setNeedsDisplay];
        return;
    }
    [self.pointArray removeLastObject];
    [self.colorArray removeLastObject];
    [self.lineWidthArray removeLastObject];
    [self setNeedsDisplay];
}


- (UIImage *)getSign {
    if (self.pointArray.count == 0) {
        return nil;
    }
    
    CGSize s = self.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - Action

- (void)signAction {
    NSMutableArray *array = self.pointArray.lastObject;
    
    if (self.panGesture.state == UIGestureRecognizerStateBegan) {
        array = [[NSMutableArray alloc] init];
        [self.pointArray addObject:array];
        UIColor *color = self.lineColor;
        [self.colorArray addObject:color];
        NSNumber *number = [NSNumber numberWithFloat:self.lineWidth];
        [self.lineWidthArray addObject:number];
        
    }
    CGPoint point = [self.panGesture locationInView:self];
    
    [array addObject:[NSValue valueWithCGPoint:point]];
  
    [self setNeedsDisplay];
    
}


#pragma mark - Getter

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(signAction)];
    }
    return _panGesture;
}

- (NSMutableArray *)pointArray {
    if (!_pointArray) {
        _pointArray = [[NSMutableArray alloc] init];
    }
    return _pointArray;
}

- (NSMutableArray *)colorArray {
    if (!_colorArray) {
        _colorArray = [[NSMutableArray alloc] init];
    }
    return _colorArray;
}

- (NSMutableArray *)lineWidthArray {
    if (!_lineWidthArray) {
        _lineWidthArray = [[NSMutableArray alloc] init];
    }
    return _lineWidthArray;
}

- (CGFloat)lineWidth {
    if (_lineWidth == 0) {
        _lineWidth = 1.0;
    }
    return _lineWidth;
}

- (UIColor *)lineColor {
    if (!_lineColor) {
        _lineColor = [UIColor blackColor];
    }
    return _lineColor;
}


@end
