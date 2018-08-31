//
//  WBBluetoothManager.m
//  WBBluetoothManager
//
//  Created by ifly on 2018/7/2.
//  Copyright © 2018年 WB. All rights reserved.
//

#import "WBBluetoothManager.h"

//#define KOTASERVICEUUID @"00001530-1212-EFDE-1523-785FEABCD123"
//#define KOTAWIRTEUUID @"00001532-1212-EFDE-1523-785FEABCD123"

// 服务
#define KSERVICEUUID @"6E400001-B5A3-F393-E0A9-E50E24DCCA9E"
// 写入的特性
#define KWIRTEUUID @"6E400002-B5A3-F393-E0A9-E50E24DCCA9E"


@implementation WBBluetoothInfoModel : NSObject

@end

// 当前连接的设备信息
@implementation WBBluetoothconnectInfoModel : NSObject

@end


@interface WBBluetoothManager()<CBCentralManagerDelegate,CBPeripheralDelegate>

//@property (nonatomic, strong) CBPeripheral     *peripheral;//连接的设备信息
@property (nonatomic, strong) CBService *service;//当前服务
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation WBBluetoothManager
static WBBluetoothManager *_manager = nil;

+ (instancetype)shareBLEManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[WBBluetoothManager alloc] init];
        
        NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES],CBCentralManagerOptionShowPowerAlertKey,nil];
        
        _manager.centralManager = [[CBCentralManager alloc] initWithDelegate:_manager queue:dispatch_get_main_queue() options:options];
        _manager.connectModel = [[WBBluetoothconnectInfoModel alloc] init];
        _manager.timeOut = 15;
        
    });
    return _manager;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(next) userInfo:nil repeats:YES];
    }
    return _timer;
}

/**
 *  蓝牙状态改变 的时候会调用这个方法 判断当前的蓝牙状态
 */
- (void)centralManagerDidUpdateState:(nonnull CBCentralManager *)central {
    NSLog(@"Central Update State");
    switch (central.state) {
        case CBManagerStatePoweredOn:
            NSLog(@"CBManagerStatePoweredOn");
            self.status = PoweredOn;
            break;
        case CBManagerStatePoweredOff:
            NSLog(@"CBManagerStatePoweredOff");
            self.status = PoweredOff;
            break;
        case CBManagerStateUnsupported:
            NSLog(@"CBManagerStateUnsupported");
            self.status = Unsupported;
            
            break;
        case CBManagerStateResetting:
            NSLog(@"CBManagerStateResetting");
            self.status = Resetting;
            
            break;
        case CBManagerStateUnauthorized:
            NSLog(@"CBManagerStateUnauthorized");
            self.status = Unsupported;
            break;
        case CBManagerStateUnknown:
            NSLog(@"CBManagerStateUnknown");
            self.status = Unknown;
            break;
            
        default:
            break;
    }
}

- (void)showOFF{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:LocalizableText(@"firend_tips") message:LocalizableText(@"blueth_tips") preferredStyle:(UIAlertControllerStyleAlert)];
    
    // 是否跳转到蓝牙界面
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:LocalizableText(@"shezhi") style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"App-Prefs:root=Bluetooth"]];
    }];
    // 创建按钮
    // 注意取消按钮只能添加一个
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:LocalizableText(@"cancle") style:(UIAlertActionStyleCancel) handler:nil];
    
    // 添加按钮 将按钮添加到UIAlertController对象上
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    // 将UIAlertController模态出来 相当于UIAlertView show 的方法
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
    
}

/**
 扫描搜索正在发送广播的peripheral
 在调用方法后，CBCentralManager对象在每次发现设备时会调用代理对象的centralManager:didDiscoverPeripheral:advertisementData:RSSI:方法。
 */
- (void)scanForPeripherals{
    if (self.status == PoweredOn) {
    
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
        _manager.mPeripherals = [[NSMutableArray alloc]init];//搜索到的设备集合
        NSDictionary *option = @{CBCentralManagerScanOptionAllowDuplicatesKey : [NSNumber numberWithBool:NO]};
        [_manager.centralManager scanForPeripheralsWithServices:nil options:option];
    }else{
        [self showOFF];
    }
    
}

- (void)next{
    NSLog(@"%ld",self.timeOut);
    self.timeOut -= 1;
    if (self.timeOut <= 0) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [GSKAlertViewController dismissSVprogress];
            [self stopScan];
            if (self.timer) {
                [self stopTimer];
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(notFoundDevice)]) {
                [self.delegate notFoundDevice];
            }
            [GSKAlertViewController showErrorText:LocalizableText(@"no_devices")];
        });
    }
}

- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
    self.timeOut = 15;
    
}


- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    
    NSLog(@"%@",advertisementData);
    NSLog(@"  RSSI: %s\n", [[RSSI stringValue] cStringUsingEncoding: NSUTF8StringEncoding]);
    if ([advertisementData[@"kCBAdvDataLocalName"] isEqualToString:@"TK-BC2"] || [advertisementData[@"kCBAdvDataLocalName"] isEqualToString:@"TK-BC1"]) {
        WBBluetoothInfoModel *model = [[WBBluetoothInfoModel alloc] init];
        model.RSSI = [NSString stringWithFormat:@"%@",RSSI];
        model.name = advertisementData[@"kCBAdvDataLocalName"];
        model.UUID = advertisementData[@"kCBAdvDataServiceUUIDs"];
        model.peripheral = peripheral;
        NSLog(@"%@",advertisementData[@"kCBAdvDataManufacturerData"]);
        model.mac = [self formatMacStringWithAdvertisementData:advertisementData];
        if (![_manager.mPeripherals containsObject:model]) {
            [_manager.mPeripherals addObject:model];
            if (_manager.delegate && [_manager.delegate respondsToSelector:@selector(updateDevices:)]) {
                [_manager.delegate updateDevices:_manager.mPeripherals];
            }
        }
    }
    
}

// 当我们查找到Peripheral端时，我们可以停止查找其它设备，以节省电量
- (void)stopScan{
    [_manager.centralManager stopScan];
    [self stopTimer];
    //    NSLog(@"Scanning stop");
}


/**
 *  连接设备
 */
- (void)connectDeviceWithCBPeripheral:(CBPeripheral *)peripheral{
//    [self cancelPeripheralConnection:self.peripheral];
    [self stopScan];
    [_manager.centralManager connectPeripheral:peripheral options:nil];
}




/**
 连接成功回调
 */
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@"Peripheral Connected");
    _manager.peripheral = peripheral;
    
    _manager.peripheral.delegate = _manager;
    
    [_manager.peripheral discoverServices:nil];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didConnectPeripheral:)]) {
        [self.delegate didConnectPeripheral:peripheral];
    }
}




/**
 * 发现服务
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error{
    
    if (error) {
        
        return;
    }
    //            _manager.service = service;
    for (CBService *service in peripheral.services) {
        NSLog(@"service-%@",service.UUID.UUIDString);
        if ([service.UUID.UUIDString isEqual:KSERVICEUUID]){
            _manager.service = service;
            dispatch_async(dispatch_get_main_queue(), ^{
                [peripheral discoverCharacteristics:nil forService:_manager.service];
            });
        }
        //  Battery
        if ([service.UUID.UUIDString isEqual:@"180F"]) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //
                [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"2A19"]] forService:service];
            });
        }
        // Device Information
        if ([service.UUID.UUIDString isEqual:@"180A"]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [peripheral discoverCharacteristics:@[[CBUUID UUIDWithString:@"2A27"]] forService:service];
            });
            
        }
    }
}
/**
 * 发现特征
 */
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error{
    
    if (error) {
        
        return;
    }
    
    for (CBCharacteristic *c in service.characteristics)
    {
        [peripheral setNotifyValue:YES forCharacteristic:c];
        [peripheral readValueForCharacteristic:c];
        NSLog(@"Characteristic-%@",c.UUID.UUIDString);
        //连接的设备特征（通道）输出
        if ([c.UUID.UUIDString isEqual:KWIRTEUUID]){
            _outPutcharacteristic = c;
            if (self.delegate && [self.delegate respondsToSelector:@selector(findcharacteristic)]) {
                [self.delegate findcharacteristic];
            }
        }
    }
}

/**
 *  发送消息
 *
 *  @param msg  消息
 */
- (void)sendMsg:(NSString* )msg withCBCharacteristic:(CBCharacteristic *)c withWriteSuccess:(WriteWithOutRespondSuccess)writeSuccessBlock withRespodSuccessBlock:(RespondSuccessBlock)respondSuccessBlock{
    self.writeSuccessBlock = writeSuccessBlock;
    self.respondSuccessBlock = respondSuccessBlock;
    if (self.status == PoweredOn) {
        if (msg) {
            NSData *data =  [BluetoothDataManager hexToBytes:msg];
            
                [_manager.peripheral writeValue:data forCharacteristic:c type:CBCharacteristicWriteWithoutResponse];
        }
    }else{
        [self showOFF];
    }
    
}


/**
 * 接收数据
 */
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error{
    
    if ([characteristic.UUID.UUIDString isEqual:@"2A27"]) {
        NSString *HardwareRevisionString = [[NSString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
        NSLog(@"%@",HardwareRevisionString);
        _manager.connectModel.hardwareVersion = HardwareRevisionString;
        
        // 电量
    }else if ([characteristic.UUID.UUIDString isEqual:@"2A19"]){
        NSString *batteryLevel  = [BluetoothDataManager convertDataToHexStr:characteristic.value];
        batteryLevel =  [BluetoothDataManager numberHexString:batteryLevel];
        NSLog(@"电量%@%@",batteryLevel,@"%");
        _manager.connectModel.batteryLevel = batteryLevel;
    }else if ([characteristic.UUID.UUIDString isEqual:@"2A23"]){
        
        
    }
    
    NSLog(@"接收到的数据：%@",[BluetoothDataManager convertDataToHexStr:characteristic.value]);
    
    if (_manager.delegate && [_manager.delegate respondsToSelector:@selector(revicedMessage:WithCBCharacteristic:)]) {
        [_manager.delegate revicedMessage:[[BluetoothDataManager convertDataToHexStr:characteristic.value] lowercaseString] WithCBCharacteristic:characteristic];
    }
    if (self.respondSuccessBlock) {
        self.respondSuccessBlock([[BluetoothDataManager convertDataToHexStr:characteristic.value] lowercaseString]);
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didUpdateNotificationStateForCharacteristic:(CBCharacteristic *)characteristic
             error:(NSError *)error {
    if (error) {
        
        return;
    }
    [peripheral readValueForCharacteristic:characteristic];
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    
    
}

// MARK: - WriteWithoutResponse写入成功回调
- (void)peripheralIsReadyToSendWriteWithoutResponse:(CBPeripheral *)peripheral{
   
    if (self.writeSuccessBlock) {
        self.writeSuccessBlock();
    }
}

-(void)peripheral:(CBPeripheral *)peripheral didUpdateValueForDescriptor:(CBDescriptor *)descriptor error:(NSError *)error{
    
}

//断开设备连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    if (peripheral) {
//        [_manager.mPeripherals removeAllObjects];
//        _manager.peripheral = nil;
//        [self stopScan];
        [self.centralManager cancelPeripheralConnection:peripheral];
    }
}


// MARK: - 格式化广播包里的数据得到mac地址
- (NSString *)formatMacStringWithAdvertisementData:(NSDictionary *)advertisementData{
    NSData *data = advertisementData[@"kCBAdvDataManufacturerData"];
    NSData *data1 =  [data subdataWithRange:NSMakeRange(0, 2)];
    NSData *data2 =  [data subdataWithRange:NSMakeRange(2, 2)];
    NSData *data3 =  [data subdataWithRange:NSMakeRange(4, 2)];
    NSString *aStr =  [BluetoothDataManager convertDataToHexStr:data1];
    NSString *bStr =  [BluetoothDataManager hexStringToReverseOrderNewhexString:[BluetoothDataManager convertDataToHexStr:data2]];
    NSString *cStr =  [BluetoothDataManager hexStringToReverseOrderNewhexString:[BluetoothDataManager convertDataToHexStr:data3]];

    NSString *macString = [NSString stringWithFormat:@"%@%@%@",cStr,bStr,aStr];
    NSMutableString *mac = [[NSMutableString alloc] initWithString:@""];
    NSArray *arrs =   [BluetoothDataManager subStringwithstring:macString Withlength:2];
    for (NSString *temp in arrs) {
        [mac appendFormat:@"%@:",temp];
    }
    if (mac.length) {
        NSInteger lenth = mac.length -1;
        macString = [mac substringWithRange:NSMakeRange(0, lenth)];
        macString = [macString uppercaseString];
    }
    return macString;

}



@end
