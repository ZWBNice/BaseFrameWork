//
//  WBLocationManager.h
//  ipad_sound
//
//  Created by ifly on 2018/5/21.
//  Copyright © 2018年 ifly. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol WBLocationManagerDelegate <NSObject>

- (void)locationWithCoordinate:(CLLocationCoordinate2D)coordinate;

- (void)locationdidFailWithError:(NSError *)error;

@end

// MARK: - 编码结束block
typedef void(^GeoCoderBlock)(CLPlacemark *pl);


@interface WBLocationManager : NSObject

@property (nonatomic,weak) id<WBLocationManagerDelegate>delegate;

+ (instancetype)shareLocationManager;


/**
 开始定位
 */
- (BOOL)startLocation;

/**
 结束定位
 */
- (void)stopLocation;

/**
 检测定位服务是否可用
 
 @return 检测结果
 */
- (BOOL)checkLocationServices;

/**
 检测定位的权限
 
 @return 定位权限枚举
 */
- (CLAuthorizationStatus)checkAuthorizationStatus;



/**
 反地理编码

 @param coordinate 经纬度结构体
 @param complete 反编码结束block
 */
- (void)reverseGeoCoderWithCoordinate:(CLLocationCoordinate2D)coordinate withComplete:(GeoCoderBlock)complete;

/**
 地理编码

 @param address 地址字符串
 @param complete 地理编码完成block
 */
- (void)geoCoderWithAddress:(NSString *)address withComplete:(GeoCoderBlock)complete;


@end
