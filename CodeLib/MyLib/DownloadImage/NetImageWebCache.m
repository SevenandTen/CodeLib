//
//  NetImageWebCache.m
//  BaseCode
//
//  Created by zw on 2018/8/27.
//  Copyright © 2018年 zw. All rights reserved.
//

#import "NetImageWebCache.h"
#import <CommonCrypto/CommonDigest.h>

@interface NetImageWebCache()

@property (nonatomic , strong) NSMutableDictionary *lockDic;

@property (nonatomic , readonly) dispatch_queue_t queue;

@property (nonatomic , strong) NSString *createPath;


@end

@implementation NetImageWebCache

@synthesize queue = _queue;

+ (instancetype)shareInstance {
    static NetImageWebCache *manager ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NetImageWebCache alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _queue = dispatch_queue_create("NetImageWebCache", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}


#pragma Public


- (void)removeLockForKey:(NSString *)key {
    if (key.length != 0) {
        dispatch_barrier_async(_queue, ^{
            [self.lockDic removeObjectForKey:key];
        });
    }
}



- (void)setImageData:(NSData *)data ForKey:(NSString *)key {
    //1.缓存存入
    [self setObject:data forKey:key];
    //文件写入
    dispatch_barrier_sync(_queue, ^{
        NSString *path = [self.createPath stringByAppendingPathComponent:[self md5:key]];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [data writeToFile:path atomically:YES];
        }
    });
}

- (UIImage *)getImageFromCacheForKey:(NSString *)key {
   __block NSData *data = [self objectForKey:key];
    if (data.length == 0) {
        dispatch_sync(_queue, ^{
            NSString *path = [self.createPath stringByAppendingPathComponent:[self md5:key]];
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                data = [NSData dataWithContentsOfFile:path];
            }
            if (data.length != 0) {
                [self setObject:data forKey:key];
            }
        });
    }
    if (data.length != 0) {
        return [UIImage imageWithData:data];
    }
    return nil;

}


#pragma mark - MD5

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}


#pragma mark - Getter

- (NSMutableDictionary *)lockDic {
    if (!_lockDic) {
        _lockDic = [[NSMutableDictionary alloc] init];
    }
    return _lockDic;
}


- (NSString *)createPath {
    if (!_createPath) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        
        NSString *path = [paths objectAtIndex:0];
        _createPath = [path stringByAppendingPathComponent:@"SQWebImage"];
        BOOL flag =  [[NSFileManager defaultManager] fileExistsAtPath:_createPath];
        if (!flag) {
            [[NSFileManager defaultManager] createDirectoryAtPath:_createPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    return _createPath;
}


@end
