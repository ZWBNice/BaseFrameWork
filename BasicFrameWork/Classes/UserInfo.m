//
//  UserInfo.m
//  ProjectFramework
//
//  Created by RC025 on 17/3/24.
//  Copyright © 2017年 WB. All rights reserved.
//

#import "UserInfo.h"

NSString *const KEY_USERPHONE = @"COM.userPhone";
NSString *const KEY_USERPASSWORD = @"COM.userPassword";
NSString *const KEY_USERID = @"COM.userId";
NSString *const KEY_USERTYPE = @"COM.userType";

@implementation UserInfo

+ (UserInfo *)sharedInstance{
    static UserInfo *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UserInfo alloc] init];
    });
    return _instance;
}

- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

#pragma mark -- getter and setter

- (void)setUserPhone:(NSString *)userPhone{
    if (!userPhone) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_USERPHONE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    NSString *localUserPhone = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERPHONE];
    if ([localUserPhone isEqualToString:userPhone]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:userPhone forKey:KEY_USERPHONE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userPhone{
    // 注册默认设置为空
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{KEY_USERPHONE:@""}];
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERPHONE];
}

- (void)setUserPassword:(NSString *)userPassword{
    if (!userPassword) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_USERPASSWORD];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    NSString *localUserPassword = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERPASSWORD];
    if ([localUserPassword isEqualToString:userPassword]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:userPassword forKey:KEY_USERPASSWORD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userPassword{
    
    return  [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERPASSWORD];

}

- (NSString*)userKey{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{KEY_USERPASSWORD:@""}];
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERPASSWORD];
}


//用户ID
- (void) setUserID:(NSString *)userID{
    if (!userID) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:KEY_USERID];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return;
    }
    
    NSString *localUserID = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERID];
    if ([localUserID isEqualToString:userID]) {
        return;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:KEY_USERID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)userID{
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{KEY_USERID:@""}];
    return [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERID];
}


//用户登录状态

- (void)setUserType:(KUserType)userType {
    if (userType == KUserTypeLogin) {
        [[NSUserDefaults standardUserDefaults] setObject:@"isLogIn" forKey:KEY_USERTYPE];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"isLogOut" forKey:KEY_USERTYPE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    }
}

- (KUserType)userType{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERTYPE] isEqualToString:@"isLogIn"]) {
        return KUserTypeLogin;
    }else {
        return KUserTypeNotLogin;
    }
}

@end
