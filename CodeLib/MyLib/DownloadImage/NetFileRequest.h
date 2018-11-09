//
//  NetImage.h
//  BaseCode
//
//  Created by zw on 2018/8/23.
//  Copyright © 2018年 zw. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NetFileRequest;
@protocol NetFileRequestDelegate<NSObject>


- (void)netFileRequest:(NetFileRequest *)request didDownLoadData:(NSData *)data url:(NSString *)url;


- (void)netFileRequest:(NetFileRequest *)request didWriteData:(int64_t)bytesWritten
      totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrit url:(NSString *)url;

- (void)netFileRequest:(NetFileRequest *)request didReciveError:(NSError *)error url:(NSString *)url;

@end

@interface NetFileRequest : NSObject


+ (instancetype)startRequestWithUrl:(NSString *)url delegate:(id<NetFileRequestDelegate>)delegate;




@end
