//
//  ED_ContinueLocationManager.h
//  CodeLib
//
//  Created by zw on 2019/2/27.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const ED_LocationLongitudeKey;


UIKIT_EXTERN NSString *const ED_LocationLatitudeKey;


UIKIT_EXTERN NSString *const ED_LocationDateKey;

@class ED_ContinueLocationManager;
@protocol  ED_ContinueLocationManagerDelegate<NSObject>

@optional

- (void)locationManager:(ED_ContinueLocationManager *)manager didReceviceLoactionInfo:(NSDictionary *)info;




@end



@interface ED_ContinueLocationManager : NSObject

@property (nonatomic , weak) id<ED_ContinueLocationManagerDelegate>delegate;



//@property (nonatomic , weak)

/**
 初始化方法

 @return 该对象
 */
+ (instancetype)shareInstance;

/**
 app 杀死的时候定位
 */
- (void)startLocationIfAppKilled;


/**
 在app内调用
 */
- (void)startLocationInApp;


/**
 在app处于后台没有杀死
 */
- (void)startLocationOutOfApp;



/**
 获取后台定位的坐标点

 @return 返回NSArray 的坐标点
 */
- (NSArray *)getLocationsFromLocal;



- (NSArray *)getLocationsFromLocalWithTimeSpace:(NSTimeInterval)second;


/**
 移除本地记录 的坐标点
 */
- (void)removeLocationsFromLocal;




/**
 开启后台任务
 */
- (void)beginBackGoundTask;


- (void)removeAllBackGoundTask;



@end



@interface ED_ContinueLocationManager (YCLocation)


//从地图坐标转化到火星坐标
- (CLLocation*)locationMarsFromEarth:(CLLocation *)location;

//从火星坐标转化到百度坐标
- (CLLocation*)locationBaiduFromMars:(CLLocation *)location;

//从百度坐标到火星坐标
- (CLLocation*)locationMarsFromBaidu:(CLLocation *)location;

@end
