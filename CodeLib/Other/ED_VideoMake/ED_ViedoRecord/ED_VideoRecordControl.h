//
//  ED_VideoRecordControl.h
//  CodeLib
//
//  Created by zw on 2019/12/31.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImage.h"



@interface ED_VideoRecordControl : NSObject

+ (void)saveVideoInPhotosWithVideoUrl:(NSURL *)videoUrl actionBlock:(void(^)(BOOL isSuccess))actionBlock;



+ (void)addWaterMarkTypeWithGPUImageUIElementAndInputVideoURL:(NSURL*)InputURL date:(NSDate *)date WithCompletionHandler:(void (^)(NSURL* outPutURL, int code))handler;








@end

