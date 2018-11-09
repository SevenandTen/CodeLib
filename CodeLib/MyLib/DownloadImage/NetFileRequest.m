//
//  NetImage.m
//  BaseCode
//
//  Created by zw on 2018/8/23.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "NetFileRequest.h"
#import <UIKit/UIKit.h>

@interface NetFileRequest()<NSURLSessionDelegate>

@property (nonatomic , strong) NSString *url;

@property (nonatomic , strong) NSURLSession *session;

@property (nonatomic , strong) NSURLRequest *request;

@property (nonatomic , strong) NSMutableData *data;

@property (nonatomic , weak) id<NetFileRequestDelegate> delegate;

@end

@implementation NetFileRequest


+ (instancetype)startRequestWithUrl:(NSString *)url delegate:(id<NetFileRequestDelegate>)delegate {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NetFileRequest *fileRequest = [[NetFileRequest alloc] init];
    fileRequest.request = request;
    fileRequest.url = url;
    fileRequest.delegate = delegate;
    [fileRequest startConnect];
    
    return fileRequest;

}


- (void)startConnect {
    [[self.session downloadTaskWithRequest:self.request] resume];
}



#pragma mark - NSURLSessionDelegate


- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location {
    if ([self.delegate respondsToSelector:@selector(netFileRequest:didDownLoadData:url:)]) {
        [self.data appendData:[NSData dataWithContentsOfURL:location]];
        [self.delegate netFileRequest:self didDownLoadData:self.data url:self.url];
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if ([self.delegate respondsToSelector:@selector(netFileRequest:didWriteData:totalBytesWritten:totalBytesExpectedToWrite:url:)]) {
        [self.delegate netFileRequest:self didWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrite url:self.url];
    
    }
    
}



- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didCompleteWithError:(nullable NSError *)error {
    if (error) {
        if ([self.delegate respondsToSelector:@selector(netFileRequest:didReciveError:url:)]) {
            [self.delegate netFileRequest:self didReciveError:error url:self.url];
        }
    }else{
        NSURLResponse *respone = [task response];
        if ([respone isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpRespone = (NSHTTPURLResponse *)respone;
            if ([httpRespone statusCode] != 200) {
                if ([self.delegate respondsToSelector:@selector(netFileRequest:didReciveError:url:)]) {
                    NSError *newError = [NSError errorWithDomain:@"系统错误" code:1077 userInfo:nil];
                    [self.delegate netFileRequest:self didReciveError:newError url:self.url];
                }
            }
        }
        
    }
}



#pragma mark - Getter

- (NSURLSession *)session {
    if (!_session) {
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}

- (NSMutableData *)data {
    if (!_data) {
        _data = [[NSMutableData alloc] init];
    }
    return _data;
}


@end
