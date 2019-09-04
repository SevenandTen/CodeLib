//
//  ED_ImagePickerViewController.h
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ED_ImagePickerViewController : UINavigationController

@property (nonatomic , readonly) NSInteger maxCount;

@property (nonatomic , readonly) BOOL isContainVideo;

@property (nonatomic , readonly) void(^complete)(NSArray <UIImage *> * imageArray);


+ (void)showWithViewContoller:(UIViewController *)viewController
                     maxCount:(NSInteger)maxCount
               isContainVideo:(BOOL)isContainVideo
                      appName:(NSString *)appName
                     complete:(void(^)(NSArray <UIImage *> * imageArray))complete;

@end

NS_ASSUME_NONNULL_END
