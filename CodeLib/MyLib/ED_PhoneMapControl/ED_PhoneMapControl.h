//
//  ED_PhoneMapControl.h
//  CodeLib
//
//  Created by zw on 2019/3/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger ,ED_LocationType) {
    ED_LocationSystem ,   // iOS 系统定位坐标
    ED_LocationFromBaidu, //    百度地图定位
    ED_LocationFromGaode, // 火星坐标   高德地图坐标 ，苹果地图坐标，腾讯地图，以及其他不知名的很多垃圾地图厂商 要自己去看
};



@interface ED_PhoneMapControl : NSObject



+ (void)openOtherMapAppToDestinationLatitude:(double)latitude longitude:(double)longitude adressTip:(NSString *)adressTip locationType:(ED_LocationType)loactionType appName:(NSString *)appName appScheme:(NSString *)appScheme viewController:(UIViewController *)viewController;

@end



@class CLLocation;
@interface ED_PhoneMapControl (YCLocation)


//从地图坐标转化到火星坐标
+ (CLLocation*)locationMarsFromEarth:(CLLocation *)location;

//从火星坐标转化到百度坐标
+ (CLLocation*)locationBaiduFromMars:(CLLocation *)location;

//从百度坐标到火星坐标
+ (CLLocation*)locationMarsFromBaidu:(CLLocation *)location;

@end

