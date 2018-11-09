//
//  ED_TimeSelectControl.h
//  CodeLib
//
//  Created by zw on 2018/11/6.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ED_TimeSelectControl : NSObject

+ (void)showTimeSelectWithDate:(NSDate *)selectDate hasDay:(BOOL)isHasDay complete:(void(^)(BOOL hasDay ,NSDate *date))complete;

@end

