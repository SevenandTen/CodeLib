//
//  ED_LocationManager.m
//  CodeLib
//
//  Created by zw on 2018/10/30.
//  Copyright © 2018 seventeen. All rights reserved.
//

#import "ED_LocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface ED_LocationManager ()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLLocationManager *locationManager;

@property (nonatomic , copy) void(^result)(BOOL isSuccess , NSError *error);


@end

@implementation ED_LocationManager

+ (instancetype)shareInstance {
    static ED_LocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_LocationManager alloc] init];
    });
    return manager;
}

#pragma mark - Public

- (void)startLocation {
    self.result = nil;
    [self.locationManager startUpdatingLocation];
}


- (void)startLocationWithResult:(void (^)(BOOL, NSError *))resulut {
    self.result = resulut;
    [self.locationManager startUpdatingLocation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    if (locations.count != 0) {
        CLLocation *location = locations.firstObject;
        _latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        _longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
        [clGeoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            if (placemarks.count != 0) {
                CLPlacemark * placeMark = placemarks.firstObject;
                self.cityName = placeMark.locality;
                if (self.result) {
                    self.result(YES, nil);
                    self.result = nil;
                }
            }
        }];
    }
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@",error.domain);
    if (self.result) {
        self.result(NO, error);
        self.result = nil;
    }
}


#pragma mark - Getter

- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
    }
    return _locationManager;
}

@end
