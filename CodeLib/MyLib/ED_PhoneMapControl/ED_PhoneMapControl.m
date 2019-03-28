//
//  ED_PhoneMapControl.m
//  CodeLib
//
//  Created by zw on 2019/3/5.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_PhoneMapControl.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@implementation ED_PhoneMapControl


+ (void)openOtherMapAppToDestinationLatitude:(double)latitude longitude:(double)longitude adressTip:(NSString *)adressTip locationType:(ED_LocationType)loactionType appName:(NSString *)appName appScheme:(NSString *)appScheme viewController:(UIViewController *)viewController {
    //1.坐标转化
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocation *marLocation = nil;
    CLLocation *baiduLocation = nil;
    if (loactionType == ED_LocationSystem) {
        marLocation = [self locationMarsFromEarth:location];
        baiduLocation = [self locationBaiduFromMars:marLocation];
        
    }else if (loactionType == ED_LocationFromBaidu){
        baiduLocation = location;
        marLocation = [self locationMarsFromBaidu:location];
        
    }else if (loactionType == ED_LocationFromGaode) {
        marLocation = location;
        baiduLocation = [self locationBaiduFromMars:location];
    }
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:@"选择地图" preferredStyle:UIAlertControllerStyleActionSheet];
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        UIAlertAction *baiduAction  = [UIAlertAction actionWithTitle:@"用百度地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openBaiduMapWithLocation:baiduLocation adress:adressTip];
        }];
        [alertVC addAction:baiduAction];
    }
    
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        UIAlertAction *gaodeAction  = [UIAlertAction actionWithTitle:@"用高德地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self openGaodeMapWithLocation:marLocation appName:appName appScheme:appScheme];
        }];
        [alertVC addAction:gaodeAction];
    }
    
    UIAlertAction *systemMapAction = [UIAlertAction actionWithTitle:@"用苹果地图导航" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self openSystemMapWithLocation:marLocation];
    }];
    
    [alertVC addAction:systemMapAction];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:cancelAction];
    
    if (!viewController) {
        viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
        while (viewController.presentedViewController) {
            viewController = viewController.presentedViewController;
        }
    }
    
    [viewController presentViewController:alertVC animated:YES completion:nil];
    
    
    
    
    
    
}


#pragma mark - Private

+ (void)openSystemMapWithLocation:(CLLocation *)location {
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKPlacemark *mark = [[MKPlacemark alloc] initWithCoordinate:location.coordinate addressDictionary:nil];
    
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:mark];
    
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}



+ (void)openBaiduMapWithLocation:(CLLocation *)location adress:(NSString *)adress {
    if (adress.length == 0) {
        adress = @"未知位置";
    }
    NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving",location.coordinate.latitude,location.coordinate.longitude ,adress] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}


+ (void)openGaodeMapWithLocation:(CLLocation *)location appName:(NSString *)appName appScheme:(NSString *)appScheme {
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appScheme,appScheme,location.coordinate.latitude,location.coordinate.longitude ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
}




@end


void transform_earth_from_mars_phoneMap(double lat, double lng, double* tarLat, double* tarLng);
void transform_mars_from_baidu_phoneMap(double lat, double lng, double* tarLat, double* tarLng);
void transform_baidu_from_mars_phoneMap(double lat, double lng, double* tarLat, double* tarLng);


@implementation ED_PhoneMapControl (YCLocation)



+ (CLLocation*)locationMarsFromEarth:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_earth_from_mars_phoneMap(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}



+ (CLLocation*)locationBaiduFromMars:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_mars_from_baidu_phoneMap(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}

+ (CLLocation*)locationMarsFromBaidu:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_baidu_from_mars_phoneMap(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}


@end






// --- transform_earth_from_mars ---
// 参考来源：https://on4wp7.codeplex.com/SourceControl/changeset/view/21483#353936
// Krasovsky 1940
//
// a = 6378245.0, 1/f = 298.3
// b = a * (1 - f)
// ee = (a^2 - b^2) / a^2;



const double a_phoneMap = 6378245.0;
const double ee_phoneMap = 0.00669342162296594323;

bool transform_sino_out_china_phoneMap(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double transform_earth_from_mars_lat_phoneMap(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double transform_earth_from_mars_lng_phoneMap(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

void transform_earth_from_mars_phoneMap(double lat, double lng, double* tarLat, double* tarLng)
{
    if (transform_sino_out_china_phoneMap(lat, lng))
    {
        *tarLat = lat;
        *tarLng = lng;
        return;
    }
    double dLat = transform_earth_from_mars_lat_phoneMap(lng - 105.0, lat - 35.0);
    double dLon = transform_earth_from_mars_lng_phoneMap(lng - 105.0, lat - 35.0);
    double radLat = lat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee_phoneMap * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a_phoneMap * (1 - ee_phoneMap)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a_phoneMap / sqrtMagic * cos(radLat) * M_PI);
    *tarLat = lat + dLat;
    *tarLng = lng + dLon;
}

// --- transform_earth_from_mars end ---
// --- transform_mars_vs_bear_paw ---
// 参考来源：http://blog.woodbunny.com/post-68.html
const double x_pi_phoneMap = M_PI * 3000.0 / 180.0;

void transform_mars_from_baidu_phoneMap(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi_phoneMap);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi_phoneMap);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

void transform_baidu_from_mars_phoneMap(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi_phoneMap);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi_phoneMap);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}


