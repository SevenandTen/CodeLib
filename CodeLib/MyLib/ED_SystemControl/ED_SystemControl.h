//
//  ED_SystemControl.h
//  CodeLib
//
//  Created by zw on 2019/3/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AdSupport/AdSupport.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_SystemControl : NSObject



// 打开网址
+ (BOOL)openUrl:(NSString *)url;


// 打电话
+ (void)callPhoneNumber:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
