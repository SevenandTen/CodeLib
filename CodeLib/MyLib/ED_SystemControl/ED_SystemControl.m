//
//  ED_SystemControl.m
//  CodeLib
//
//  Created by zw on 2019/3/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_SystemControl.h"

@implementation ED_SystemControl





+ (BOOL)openUrl:(NSString *)url {
    NSURL * _url = [NSURL URLWithString:url];
    if (_url && [[UIApplication sharedApplication] openURL:_url]) {
        return YES;
    }
    return NO;
}


+ (void)callPhoneNumber:(NSString *)phoneNumber {
    if (phoneNumber.length > 0 ) {
        [self openUrl:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    }
}



+ (NSString *)getUUID {
    return  [[ASIdentifierManager sharedManager].advertisingIdentifier UUIDString];
}


@end
