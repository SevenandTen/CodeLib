//
//  ED_MovieRecord.m
//  CodeLib
//
//  Created by zw on 2019/11/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_MovieRecord.h"


@interface ED_MovieRecord ()

@property (nonatomic , strong) AVAssetWriter *writter;

@property (nonatomic , strong) AVAssetWriterInput *videoInput;

@property (nonatomic , strong) AVAssetWriterInput *audioInput;

@property (nonatomic , strong) AVAssetWriterInput *textInput;

@property (nonatomic , strong) NSURL *fileUrl;


@property (nonatomic , strong) NSDictionary *videoSettings;

@property (nonatomic , strong) NSDictionary *audioSettings;



@end

@implementation ED_MovieRecord


- (void)startRecording {
    
}



- (NSString *)getVideoPathCache {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * videoCache = [[paths firstObject] stringByAppendingPathComponent:@"videos"];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:videoCache isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) ) {
        [fileManager createDirectoryAtPath:videoCache withIntermediateDirectories:YES attributes:nil error:nil];
    };
    return videoCache;
}


- (NSString *)getVideoNameWithType:(NSString *)fileType{
    NSTimeInterval now = [[NSDate date] timeIntervalSince1970];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSDate * NowDate = [NSDate dateWithTimeIntervalSince1970:now];
    NSString * timeStr = [formatter stringFromDate:NowDate];
    NSString *fileName = [NSString stringWithFormat:@"video_%@.%@",timeStr,fileType];
    return fileName;
}




#pragma mark - Getter


- (NSURL *)fileUrl {
    if (!_fileUrl) {
        NSString *filePath = [[self getVideoPathCache] stringByAppendingPathComponent:[self getVideoNameWithType:@"mov"]];
        _fileUrl = [NSURL fileURLWithPath:filePath];
    }
    return _fileUrl;
}


- (AVAssetWriterInput *)audioInput {
    if (!_audioInput) {
        _audioInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeAudio outputSettings:nil];
    }
    return _audioInput;
}

- (AVAssetWriterInput *)videoInput {
    if (!_videoInput) {
        _videoInput = [AVAssetWriterInput assetWriterInputWithMediaType:AVMediaTypeVideo outputSettings:nil];
    }
    return _videoInput;
}

- (AVAssetWriter *)writter {
    if (!_writter) {
        _writter = [[AVAssetWriter alloc] initWithURL:self.fileUrl fileType:AVFileTypeQuickTimeMovie error:nil];
    }
    return _writter;
}



@end
