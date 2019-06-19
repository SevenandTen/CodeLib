//
//  ED_PrecentTransition.m
//  CodeLib
//
//  Created by zw on 2019/1/15.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PrecentTransition.h"


@interface ED_PrecentTransition ()
{
    BOOL _isPanGestureInteration;
}


@property (nonatomic , strong) UIPanGestureRecognizer *panGesture;


@end

@implementation ED_PrecentTransition
@synthesize isPanGestureInteration = _isPanGestureInteration;

#pragma mark - Public


- (instancetype)initWithViewController:(UIViewController *)vc {
    return [self initWithView:vc.view];
}


- (instancetype)initWithView:(UIView *)view {
    if (self = [super init]) {
        self.type = ED_TouchRight;
        [view addGestureRecognizer:self.panGesture];
    }
    return self;
}








#pragma mark - Action

- (void)handlePanGetureResponse {
    CGPoint translatePoint = [self.panGesture translationInView:self.panGesture.view];
    
    CGFloat progress = 0;
    CGFloat maxLength = 0;
  
    if (self.type == ED_TouchRight  || self.type == ED_TouchLeft) {
        maxLength = self.maxOffSet.x;
        if (maxLength == 0) {
            maxLength = [UIScreen mainScreen].bounds.size.width;
        }
        progress = fabs(translatePoint.x)/maxLength;
        
        if (self.type == ED_TouchRight && translatePoint.x < 0  ) {
            progress = 0;
        }
        
        if (self.type == ED_TouchLeft && translatePoint.x > 0) {
            progress = 0;
        }
        
    }else if (self.type == ED_TouchUp || self.type == ED_TouchDown){
        maxLength = self.maxOffSet.y;
        if (maxLength == 0) {
            maxLength = [UIScreen mainScreen].bounds.size.height;
        }
         progress = fabs(translatePoint.y)/maxLength;
        if (self.type == ED_TouchDown && translatePoint.y < 0) {
            progress = 0;
        }
        if (self.type == ED_TouchUp && translatePoint.y > 0) {
            progress = 0;
        }
        
    }
    progress = MIN(1.0,(MAX(0.0, progress)));
    
    
    UIGestureRecognizerState  state = self.panGesture.state;
    if (state == UIGestureRecognizerStateBegan) {
        _isPanGestureInteration = YES;
        if (self.actionBlock) {
            self.actionBlock();
        }
       
        
    }else if (state == UIGestureRecognizerStateChanged){
        [self updateInteractiveTransition:progress];
    }else if (state == UIGestureRecognizerStateEnded || state == UIGestureRecognizerStateCancelled){
        if (self.startPercent == 0) {
            if (progress > 0.5) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }else{
            if (progress > self.startPercent) {
                [self finishInteractiveTransition];
            }else{
                [self cancelInteractiveTransition];
            }
        }
       
        _isPanGestureInteration = NO;
    }
    
}




#pragma mark - Getter

- (UIPanGestureRecognizer *)panGesture {
    if (!_panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGetureResponse)];
    }
    return _panGesture;
}
@end
