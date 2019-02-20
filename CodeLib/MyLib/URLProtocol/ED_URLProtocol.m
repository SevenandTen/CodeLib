//
//  ED_URLProtocol.m
//  CodeLib
//
//  Created by zw on 2019/2/14.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_URLProtocol.h"

@implementation ED_URLProtocol


+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSLog(@"%@",request.URL.absoluteString);
    return NO;
}

@end
