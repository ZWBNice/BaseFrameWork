//
//  UserInfo.h
//  ProjectFramework
//
//  Created by RC025 on 17/3/24.
//  Copyright © 2017年 WB. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KUserType) {
    KUserTypeNotLogin = 0, // 未登录
    KUserTypeLogin, //已登录
    
};

@interface UserInfo : NSObject


@property (nonatomic, assign) KUserType userType;
/**
 *  用户手机号
 */
@property (nonatomic, copy) NSString *userPhone;
/**
 *  用户密码
 */
@property (nonatomic, copy) NSString *userPassword;
/**
 *  用户id 标记用户
 */
@property (nonatomic, copy) NSString *userId;

/**
 *  实例化
 *
 *  @return UserInfo对象
 */
+ (UserInfo *)sharedInstance;

@end
