//
//  ED_ImagePickerViewController.m
//  CodeLib
//
//  Created by zw on 2019/8/22.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_ImagePickerViewController.h"
#import <Photos/Photos.h>
#import "ED_NoAccessTipViewController.h"
#import "ED_PictureLibraryViewController.h"

@interface ED_ImagePickerViewController (){
    NSInteger _maxCount;
    BOOL _isContainVideo;
    void(^_complete)(NSArray <UIImage *> * imageArray) ;
    
}

@end

@implementation ED_ImagePickerViewController

@synthesize maxCount = _maxCount;
@synthesize isContainVideo = _isContainVideo;
@synthesize complete = _complete;


+ (void)showWithViewContoller:(UIViewController *)viewController maxCount:(NSInteger)maxCount isContainVideo:(BOOL)isContainVideo appName:(NSString *)appName complete:(void (^)(NSArray<UIImage *> * _Nonnull))complete{
    
    if (!viewController) {
        viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
    }
    PHAuthorizationStatus photoStatus = [PHPhotoLibrary authorizationStatus];
    if (photoStatus == PHAuthorizationStatusRestricted ) { //没有权限使用相册，用户也不能改变权限，可能权限受家长控制的
        
    }else if (photoStatus == PHAuthorizationStatusNotDetermined){ //用户还没用做出选择
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self gotoChoosePictureWithViewController:viewController maxCount:maxCount isContainVideo:isContainVideo  complete:complete];
                });
            }
        }];
        
    }else if (photoStatus == PHAuthorizationStatusDenied){ //用户禁止使用相册
        [self giveTipsWithViewController:viewController appName:appName];
    }else if (photoStatus == PHAuthorizationStatusAuthorized) { //用户允许使用相册
        
        [self gotoChoosePictureWithViewController:viewController maxCount:maxCount isContainVideo:isContainVideo  complete:complete];
    }
}



+ (void)giveTipsWithViewController:(UIViewController *)viewController appName:(NSString *)appName {
  
    ED_NoAccessTipViewController *vc = [[ED_NoAccessTipViewController alloc] init];
    vc.appName = appName;
    ED_ImagePickerViewController *nav = [[ED_ImagePickerViewController alloc] initWithRootViewController:vc];
    [viewController presentViewController:nav animated:YES completion:nil];
    
}


+ (void)gotoChoosePictureWithViewController:(UIViewController *)viewController  maxCount:(NSInteger)maxCount isContainVideo:(BOOL)isContainVideo complete:(void (^)(NSArray<UIImage *> * _Nonnull))complete {

//    PHAssetCollectionTypeAlbum      = 1, 自定义相册
//    PHAssetCollectionTypeSmartAlbum = 2, 系统相册
//    PHAssetCollectionTypeMoment     = 3, 时刻
    ED_PictureLibraryViewController *vc = [[ED_PictureLibraryViewController alloc] init];
     ED_ImagePickerViewController *nav = [[ED_ImagePickerViewController alloc] initWithRootViewController:vc];
    nav -> _maxCount = maxCount;
    nav -> _isContainVideo = isContainVideo;
    nav -> _complete = [complete copy];
    
    [viewController presentViewController:nav animated:YES completion:nil];
    
    
//
//    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    
    
}

@end
