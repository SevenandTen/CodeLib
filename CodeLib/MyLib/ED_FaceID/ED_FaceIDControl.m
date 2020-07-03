//
//  ED_FaceIDControl.m
//  CodeLib
//
//  Created by zw on 2020/1/15.
//  Copyright © 2020 seventeen. All rights reserved.
//

#import "ED_FaceIDControl.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <UIKit/UIKit.h>

@implementation ED_FaceIDControl


+ (void)checkFaceId {
    if ( [[UIDevice currentDevice].systemVersion floatValue] < 8.0) {
        return;
    }
   
    
    LAContext *context = [[LAContext alloc] init];
      context.localizedFallbackTitle = @"石崎崎";
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"啊啊啊啊啊" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
            }
        }];
    }
}

@end
