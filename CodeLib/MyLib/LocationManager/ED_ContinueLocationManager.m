//
//  ED_ContinueLocationManager.m
//  CodeLib
//
//  Created by zw on 2019/2/27.
//  Copyright © 2019 seventeen. All rights reserved.
//

#import "ED_ContinueLocationManager.h"

#import "HttpRequest.h"




#define ED_TimerFrequency  10

#define ED_LocationsFileName @"ED_ContinueLocationManager"

#define ED_LocationsLastTimeKey @"ED_ContinueLocationsLastTimeKey"

NSString *const ED_LocationLongitudeKey = @"longitude";


NSString *const ED_LocationLatitudeKey = @"latitude";


NSString *const ED_LocationDateKey = @"date";



@interface ED_ContinueLocationManager ()<CLLocationManagerDelegate>

@property (nonatomic , strong) CLLocationManager *locationManager;

@property (nonatomic , strong) NSTimer *timer;

@property (nonatomic ,readonly) dispatch_queue_t queue;

@property (nonatomic , readonly) NSString *path;

@property (nonatomic , strong) NSTimer *backTimer;

@property (nonatomic , strong) NSMutableArray *taskArray;




@end

@implementation ED_ContinueLocationManager

@synthesize queue = _queue;


- (instancetype)init {
    if (self = [super init]) {
        _queue  = dispatch_queue_create("ED_ContinueLocationManager", DISPATCH_QUEUE_CONCURRENT);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidbecomeActive) name:UIApplicationDidBecomeActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackGround) name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
    return self;
}

- (void)appDidbecomeActive {
    [self removeAllBackGoundTask];
    [self startLocationInApp];
}


- (void)appDidEnterBackGround  {
    [self beginBackGoundTask];
    [self startLocationOutOfApp];
}





+ (instancetype)shareInstance {
    static ED_ContinueLocationManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ED_ContinueLocationManager alloc] init];
    });
    return manager;
}

#pragma mark - Public


- (void)startLocationInApp {

    self.timer = [NSTimer scheduledTimerWithTimeInterval:ED_TimerFrequency target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
}


- (void)startLocationOutOfApp  {
    [self.timer invalidate];
    self.timer = nil;
    [self startLocation];
    
}


- (void)startLocation {
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.pausesLocationUpdatesAutomatically = NO;
    if (@available(iOS 9.0, *)) {
        _locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];  //一直保持定位
    [self.locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}


- (void)startLocationIfAppKilled {
    UIApplicationState status = [UIApplication sharedApplication].applicationState;
    
    if (status == UIApplicationStateBackground) {
        [self startLocationOutOfApp];
    }
}


- (void)beginBackGoundTask {
    __block UIBackgroundTaskIdentifier  identfier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"===========================结束任务");
        [[UIApplication sharedApplication] endBackgroundTask:identfier];
        [self.taskArray removeObject:@(identfier)];
        identfier = UIBackgroundTaskInvalid;
        
    }];
    [self.taskArray addObject:@(identfier)];
    self.backTimer = [NSTimer scheduledTimerWithTimeInterval:120 target:self selector:@selector(backTimerClick) userInfo:nil repeats:NO];
    
       NSLog(@"==============开始任务 %lu",identfier);
    
}


- (void)removeAllBackGoundTask {
    for (NSNumber *num in self.taskArray) {
        [[UIApplication sharedApplication] endBackgroundTask:[num unsignedIntegerValue]];
    }
    [self.taskArray removeAllObjects];
     NSLog(@"===========================前台结束任务");
}




- (NSArray *)getLocationsFromLocal {
    __block  NSArray * array = nil;
    dispatch_sync(self.queue, ^{
        array = [NSArray arrayWithContentsOfFile:self.path];
    });
    return array;
    
}

- (NSArray *)getLocationsFromLocalWithTimeSpace:(NSTimeInterval)second {
    NSArray *array = [self getLocationsFromLocal];
    NSTimeInterval time = 0;
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    for (NSDictionary *dic in array) {
        NSDate *date = [formatter dateFromString:[dic objectForKey:ED_LocationDateKey]];
        NSTimeInterval current = [date timeIntervalSince1970];
        if (time == 0) {
            time = current;
            [newArray addObject:dic];
        }else {
            if (current - time >= second) {
                time = current;
                [newArray addObject:dic];
            }
        }
    }
    return newArray;

}

- (void)removeLocationsFromLocal {
    dispatch_barrier_async(self.queue, ^{
        [[NSFileManager defaultManager] removeItemAtPath:self.path error:nil];
    });
}

#pragma mark - Private


- (void)timerClick {
    [self startLocation];
}

- (void)backTimerClick {
    [self startLocationOutOfApp];
    [self.backTimer invalidate];
    self.backTimer = nil;
    [self beginBackGoundTask];
    NSLog(@"===========================维护任务");
}



#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    if (locations.count != 0) {
        UIApplicationState status = [UIApplication sharedApplication].applicationState;
        CLLocation *location = [self locationMarsFromEarth:locations.firstObject] ;
        NSString * latitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        NSString *longitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        NSMutableDictionary *dic  = [NSMutableDictionary dictionaryWithCapacity:3];
        [dic setObject:longitude forKey:@"longitude"];
        [dic setObject:latitude forKey:@"latitude"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
        NSDate *date = [NSDate date];
        NSString *dateString = [formatter stringFromDate:date];
        [dic setObject:dateString forKey:@"date"];
    
        if (status == UIApplicationStateBackground) {
            NSLog(@"%@............后台运行",dateString);
            formatter.dateFormat = @"YYYY-MM-dd HH:mm";
            
            NSString *thisTimeString = [formatter stringFromDate:date];
            
            NSString *lastTimeString = [[NSUserDefaults standardUserDefaults] objectForKey:ED_LocationsLastTimeKey];
            if ([lastTimeString isEqualToString:thisTimeString] && thisTimeString.length != 0) {
                return;
            }else {
                [[NSUserDefaults standardUserDefaults] setObject:thisTimeString forKey:ED_LocationsLastTimeKey];
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
            NSArray *array = self.getLocationsFromLocal;
            dispatch_barrier_async(self.queue, ^{
                NSMutableArray *mutArray = nil;
                if (array.count) {
                    mutArray = [NSMutableArray arrayWithArray:array];
                }else{
                    mutArray = [[NSMutableArray alloc] init];
                }
                [mutArray addObject:dic];
                [mutArray writeToFile:self.path atomically:YES];
                
            });
            
     
            
        }else{
        
            [self.locationManager stopUpdatingLocation];
            self.locationManager.delegate = nil;
            NSLog(@".................前台");
            NSLog(@"------------------%f",locations.firstObject.coordinate.latitude);
            NSLog(@"++++++++++++++++++%f",locations.firstObject.coordinate.longitude);
            if (self.delegate && [self.delegate respondsToSelector:@selector(locationManager:didReceviceLoactionInfo:)]) {
                [self.delegate locationManager:self didReceviceLoactionInfo:dic];
            }
        
            
        }
       
    }
    
    
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"%@",error.description);
    
    
}


    

#pragma mark - Getter



- (NSMutableArray *)taskArray {
    if (!_taskArray) {
        _taskArray = [[NSMutableArray alloc] init];
    }
    return _taskArray;
}

- (NSString *)path {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
     NSString *path = [paths objectAtIndex:0];
    return  [path stringByAppendingPathExtension:ED_LocationsFileName];
}


- (CLLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        if (@available(iOS 9.0, *)) {
            _locationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return _locationManager;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end






void transform_earth_from_mars_locationManager(double lat, double lng, double* tarLat, double* tarLng);
void transform_mars_from_baidu_locationManager(double lat, double lng, double* tarLat, double* tarLng);
void transform_baidu_from_mars_locationManager(double lat, double lng, double* tarLat, double* tarLng);



@implementation ED_ContinueLocationManager (YCLocation)



- (CLLocation*)locationMarsFromEarth:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_earth_from_mars_locationManager(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}



- (CLLocation*)locationBaiduFromMars:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_mars_from_baidu_locationManager(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
    return [[CLLocation alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lng)
                                         altitude:location.altitude
                               horizontalAccuracy:location.horizontalAccuracy
                                 verticalAccuracy:location.verticalAccuracy
                                           course:location.course
                                            speed:location.speed
                                        timestamp:location.timestamp];
}

- (CLLocation*)locationMarsFromBaidu:(CLLocation *)location
{
    double lat = 0.0;
    double lng = 0.0;
    transform_baidu_from_mars_locationManager(location.coordinate.latitude, location.coordinate.longitude, &lat, &lng);
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
const double a_locationManager = 6378245.0;
const double ee_locationManager = 0.00669342162296594323;

bool transform_sino_out_china_locationManager(double lat, double lon)
{
    if (lon < 72.004 || lon > 137.8347)
        return true;
    if (lat < 0.8293 || lat > 55.8271)
        return true;
    return false;
}

double transform_earth_from_mars_lat_locationManager(double x, double y)
{
    double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
    return ret;
}

double transform_earth_from_mars_lng_locationManager(double x, double y)
{
    double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
    ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
    ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
    ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
    return ret;
}

void transform_earth_from_mars_locationManager(double lat, double lng, double* tarLat, double* tarLng)
{
    if (transform_sino_out_china_locationManager(lat, lng))
    {
        *tarLat = lat;
        *tarLng = lng;
        return;
    }
    double dLat = transform_earth_from_mars_lat_locationManager(lng - 105.0, lat - 35.0);
    double dLon = transform_earth_from_mars_lng_locationManager(lng - 105.0, lat - 35.0);
    double radLat = lat / 180.0 * M_PI;
    double magic = sin(radLat);
    magic = 1 - ee_locationManager * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a_locationManager * (1 - ee_locationManager)) / (magic * sqrtMagic) * M_PI);
    dLon = (dLon * 180.0) / (a_locationManager / sqrtMagic * cos(radLat) * M_PI);
    *tarLat = lat + dLat;
    *tarLng = lng + dLon;
}

// --- transform_earth_from_mars end ---
// --- transform_mars_vs_bear_paw ---
// 参考来源：http://blog.woodbunny.com/post-68.html
const double x_pi_locationManager = M_PI * 3000.0 / 180.0;

void transform_mars_from_baidu_locationManager(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi_locationManager);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi_locationManager);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}

void transform_baidu_from_mars_locationManager(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon)
{
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi_locationManager);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi_locationManager);
    *gg_lon = z * cos(theta);
    *gg_lat = z * sin(theta);
}
