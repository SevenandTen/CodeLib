//
//  NetFileManager.m
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "NetFileManager.h"
#import "NetFileRequest.h"
#import "UIView+SQWebCache.h"
#import "NetImageWebCache.h"
@interface NetFileManager()<NetFileRequestDelegate>

@property (nonatomic ,strong) NSMutableDictionary *requestDic;

@property (nonatomic ,readonly) dispatch_queue_t queue;

@property (nonatomic ,strong) NSMutableArray *requestArray;

@end



@implementation NetFileManager

+ (instancetype)shareInstance {
    static NetFileManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetFileManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _queue  = dispatch_queue_create("NetFileManager", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


- (void)startLoadFileWithUrl:(NSString *)url withView:(UIView *)view {
    BOOL flag = [self saveImageView:view withUrl:url];
    if (!flag) {
        NetFileRequest *requset = [NetFileRequest startRequestWithUrl:url delegate:self];
        [self.requestArray addObject:requset];
    }
    
}


- (void)netFileRequest:(NetFileRequest *)request didDownLoadData:(NSData *)data url:(NSString *)url {
    NSArray *viewArray = [self selectImageViewsForKey:url];
    [self.requestArray removeObject:request];
    [[NetImageWebCache shareInstance] setImageData:data ForKey:url];
    [self removeViewArrayForUrl:url];
    if (viewArray.count != 0) {
        for (UIView *view in viewArray) {
            [view  updateWebImage:[UIImage imageWithData:data]];
        }
    }
    
}


- (void)netFileRequest:(NetFileRequest *)request didWriteData:(int64_t)bytesWritten
     totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrit url:(NSString *)url {
    NSArray *viewArray = [self selectImageViewsForKey:url];
    if (viewArray.count != 0) {
        for (UIView *view in viewArray) {
            [view  updateWebImageProgressWriteData:bytesWritten totalBytesWritten:totalBytesWritten totalBytesExpectedToWrite:totalBytesExpectedToWrit];
        }
    }
    
    
}

- (void)netFileRequest:(NetFileRequest *)request didReciveError:(NSError *)error url:(NSString *)url {
    NSArray *viewArray = [self selectImageViewsForKey:url];
    [self removeViewArrayForUrl:url];
    if (viewArray.count != 0) {
        for (UIView *view in viewArray) {
            [view  updateWebImageWithError:error];;
        }
    }
    
}




#pragma mark - Private 

- (BOOL)saveImageView:(UIView *)view withUrl:(NSString *)url {
    __block BOOL flag = NO;
    dispatch_barrier_sync(_queue, ^{
        NSArray * viewArray = [self.requestDic objectForKey:url];
        if (viewArray.count == 0) {
            [self.requestDic setObject:@[view] forKey:url];
            flag = NO;
        }else {
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:viewArray];
            [array addObject:view];
            [self.requestDic setObject:array forKey:url];
            flag = YES;
        }
    });
    return flag;
}

- (void)removeImageView:(UIView *)view forUrl:(NSString *)url {
     dispatch_barrier_sync(_queue, ^{
         NSArray * viewArray = [self.requestDic objectForKey:url];
         if (viewArray.count != 0) {
             NSMutableArray *array = [[NSMutableArray alloc] initWithArray:viewArray];
             [array removeObject:view];
             [self.requestDic setObject:array forKey:url];
         }
    });
}

- (void)removeViewArrayForUrl:(NSString *)url {
    dispatch_barrier_sync(_queue, ^{
        [self.requestDic removeObjectForKey:url];
    });
}

- (NSArray *)selectImageViewsForKey:(NSString *)url {
    __block NSArray *viewArray;
    dispatch_barrier_sync(_queue, ^{
        viewArray = [self.requestDic objectForKey:url];
    });
    return viewArray;
}



#pragma mark - Getter

- (NSMutableDictionary *)requestDic {
    if (!_requestDic) {
        _requestDic = [[NSMutableDictionary alloc] init];
    }
    return _requestDic;
}


- (NSMutableArray *)requestArray {
    if (!_requestArray) {
        _requestArray = [[NSMutableArray alloc] init];
    }
    return _requestArray;
}
@end
