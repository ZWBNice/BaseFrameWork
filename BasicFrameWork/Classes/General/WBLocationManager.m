//
//  WBLocationManager.m
//  ipad_sound
//
//  Created by ifly on 2018/5/21.
//  Copyright © 2018年 ifly. All rights reserved.
//


#import "WBLocationManager.h"

@interface WBLocationManager()<CLLocationManagerDelegate,UIAlertViewDelegate>
@property(nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *geoC;
@property (nonatomic, assign)BOOL isBeingUpdateLocation;

@end

@implementation WBLocationManager

+ (instancetype)shareLocationManager{
    static WBLocationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WBLocationManager alloc] init];
    });
    return manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.distanceFilter =  kCLDistanceFilterNone;
        self.geoC = [[CLGeocoder alloc] init];
    }
    return self;
}

/**
 检测定位服务是否可用

 @return 检测结果
 */
- (BOOL)checkLocationServices{
    BOOL enable = [CLLocationManager locationServicesEnabled];
    return enable;
}

- (BOOL)prepare{
    if ([self checkLocationServices]) {
     CLAuthorizationStatus authorizationStatus =  [self checkAuthorizationStatus];
        if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse) {
            return true;
        }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"您的应用的没有定位权限，请先前往系统设置中开启本应用的定位权限"
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                                  otherButtonTitles:@"确定",nil];
            alert.tag = 1001;
            [alert show];
#pragma clang diagnostic pop
            return false;
        }
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"定位服务处于关闭状态，请先前往系统设置中开启定位服务"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 1000;
        [alert show];
#pragma clang diagnostic pop
        return false;
    }
}

/**
 检测定位的权限

 @return 定位权限枚举
 */
- (CLAuthorizationStatus)checkAuthorizationStatus{
    // 是否具有定位权限
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    return authorizationStatus;
}

- (void)TipsAuthorizationStatus{
    CLAuthorizationStatus authorizationStatus =  [self checkAuthorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }else if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"您的应用的没有定位权限，请先前往系统设置中开启本应用的定位权限"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定",nil];
        alert.tag = 1001;
        [alert show];
#pragma clang diagnostic pop
    }else if (authorizationStatus == kCLAuthorizationStatusAuthorizedAlways || authorizationStatus == kCLAuthorizationStatusAuthorizedWhenInUse){
        [self startLocation];
    }
    
}

- (BOOL)startLocation{
    
   BOOL isPrepare = [self prepare];
    if (isPrepare) {
        self.isBeingUpdateLocation = true;
        [self.locationManager startUpdatingLocation];
        return true;
    }else{
        NSLog(@"%s","定位服务没有准备好");
        return false;
    }
}

- (void)stopLocation{
    self.isBeingUpdateLocation = false;
    [self.locationManager stopUpdatingLocation];
}

// MARK: - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    if (status == kCLAuthorizationStatusAuthorizedAlways || status == kCLAuthorizationStatusAuthorizedWhenInUse){
        if (!_isBeingUpdateLocation){
            [self startLocation];
        }
    }
}

#pragma mark -- 更新地理位置
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationWithCoordinate:)]) {
        [self.delegate locationWithCoordinate:coordinate];
        [self stopLocation];
    }

}
/**
 *  定位失误时触发
 *
 *  @param manager CLLocationManager
 *  @param error   error
 */
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    NSLog(@"%@",error);
    if (self.delegate && [self.delegate respondsToSelector:@selector(locationdidFailWithError:)]) {
        [self.delegate locationdidFailWithError:error];
    }
    [self stopLocation];
}

// MARK: - 反地理编码
- (void)reverseGeoCoderWithCoordinate:(CLLocationCoordinate2D)coordinate withComplete:(GeoCoderBlock)complete{
    CLLocation *location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            if (complete) {
                complete(firstPlacemark);
            }
            NSLog(@"%@",firstPlacemark.name);
            NSString * country = firstPlacemark.country;
            NSString * administrativeArea = firstPlacemark.administrativeArea;
            NSString * locality = firstPlacemark.locality;
            NSString * subLocality = firstPlacemark.subLocality;
            NSString * thoroughfare = firstPlacemark.thoroughfare;
            NSLog(@"当前位置:%@%@%@%@%@",country,administrativeArea,locality,subLocality,thoroughfare);
        }else
        {
            NSLog(@"反地理编码错误");
        }
    }];
}
// MARK: - 地理编码
- (void)geoCoderWithAddress:(NSString *)address withComplete:(GeoCoderBlock)complete{
    [self.geoC geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            // CLPlacemark : 地标
            // location : 位置对象
            // addressDictionary : 地址字典
            // name : 地址详情
            // locality : 城市
            CLPlacemark *firstPlacemark = [placemarks firstObject];
            if (complete) {
                complete(firstPlacemark);
            }
        }else
        {
            NSLog(@"错误");
        }
    }];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 1001){
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
            if (alertView.cancelButtonIndex != buttonIndex){
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }
    }
}
#pragma clang diagnostic pop


@end
