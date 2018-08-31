//
//  WBBluetoothManager.h
//  WBBluetoothManager
//
//  Created by ifly on 2018/7/2.
//  Copyright © 2018年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import "BluetoothDataManager.h"

typedef NS_ENUM(NSUInteger, BluethStatus) {
    Unknown = 0,
    Resetting,
    Unsupported,
    Unauthorized,
    PoweredOff,
    PoweredOn
};

@interface WBBluetoothInfoModel : NSObject
@property (nonatomic, copy) NSString *RSSI;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *UUID;
@property (nonatomic, copy) NSString *mac;
@property (nonatomic, strong) CBPeripheral     *peripheral;//设备

@end

// 当前连接的设备信息
@interface WBBluetoothconnectInfoModel : NSObject
@property (nonatomic, copy) NSString *batteryLevel;
@property (nonatomic, copy) NSString *hardwareVersion;

@end

@protocol WBBluetoothManagerDelegate <NSObject>

@optional

- (void)notFoundDevice;

- (void)updateDevices:(NSArray *)devices; //搜索到设备回调
- (void)revicedMessage:(NSString *)msg WithCBCharacteristic:(CBCharacteristic *)c;     //接受到数据回调
- (void)didConnectPeripheral:(CBPeripheral *)peripheral; // 连接成功回调
- (void)findcharacteristic; //发现特征

// 写入成功
- (void)writeWithRespondcharacteristic; //


@end

typedef void(^WriteWithOutRespondSuccess)(void);

typedef void(^RespondSuccessBlock)(NSString *msg);


@interface WBBluetoothManager : NSObject

@property(nonatomic, assign) BluethStatus status;
@property(nonatomic, assign) NSInteger timeOut; //超时时间
@property (nonatomic, strong) CBCharacteristic *inputCharacteristic;//连接的设备特征（通道）输入
@property (nonatomic, strong) CBCharacteristic *outPutcharacteristic;//连接的设备特征（通道）输出
@property (nonatomic, strong) CBPeripheral     *peripheral;//连接的设备信息
@property (nonatomic, strong) CBCentralManager *centralManager;//蓝牙管理
@property (nonatomic, strong) NSMutableArray   *mPeripherals;//找到的设备


@property (nonatomic, strong) CBCharacteristic *deviceInfo;

@property (nonatomic, strong) WBBluetoothconnectInfoModel *connectModel;
/**
 代理人
 */
@property(nonatomic, weak) id<WBBluetoothManagerDelegate> delegate;

@property (nonatomic, copy) WriteWithOutRespondSuccess writeSuccessBlock;

@property (nonatomic, copy) RespondSuccessBlock respondSuccessBlock;


+ (instancetype)shareBLEManager;

- (void)showOFF;
/**
 扫描周围的设备
 */
- (void)scanForPeripherals;

/**
 连接设备

 @param peripheral 要连接的设备
 */
- (void)connectDeviceWithCBPeripheral:(CBPeripheral *)peripheral;
/**
 *  发送消息
 *
 *  @param msg  消息
 */
- (void)sendMsg:(NSString* )msg withCBCharacteristic:(CBCharacteristic *)c withWriteSuccess:(WriteWithOutRespondSuccess)writeSuccessBlock withRespodSuccessBlock:(RespondSuccessBlock)respondSuccessBlock;


/**
 停止扫描
 */
- (void)stopScan;

//断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral;


@end
