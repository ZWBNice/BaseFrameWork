//
//  BaseModel.m
//
//  Created by 钩钩硬 on 15/10/19.
//  Copyright © 2015年 Mr.Yu. All rights reserved.
//

#import "BaseModel.h"

static NSMutableDictionary *modelsDescription = nil;

@implementation BaseModel

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        modelsDescription = [NSMutableDictionary dictionary];
    });
}
//- (NSDictionary *)mapPropertiesToDictionary
//{
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
//    Class cls = [self class];
//    uint ivarsCount = 0;
//    Ivar *ivars = class_copyIvarList(cls, &ivarsCount);
//    const Ivar *ivarsEnd = ivars + ivarsCount;
//    for (const Ivar *ivarsBegin = ivars; ivarsBegin < ivarsEnd; ivarsBegin++)
//    {
//        Ivar const ivar = *ivarsBegin;
//        NSString *key = [NSString stringWithUTF8String:ivar_getName(ivar)];
//        if ([key hasPrefix:@"_"]) key = [key substringFromIndex:1];
//        id value = [self valueForKey:key];
//        [dictionary setObject:value ? value : [NSNull null]
//                       forKey:key];
//    }
//    if (ivars)
//    {
//        free(ivars);
//    }
//    return dictionary;
//}
//
//- (NSString *)description
//{
//    NSMutableString *str = [NSMutableString stringWithFormat:@"------<%@>------\n", NSStringFromClass([self class])];
//    NSDictionary *dic = [self mapPropertiesToDictionary];
//    [dic enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
//        [str appendFormat:@"< %@ = %@ >\n", key, obj];
//    }];
//    [str appendString:@"------<End>------"];
//    return str;
//}
//


+ (NSMutableArray *)baseModelByArr:(NSArray *)arr {
    
    // 先初始化容器arr
    NSMutableArray *modelArr = [[NSMutableArray alloc] init];
    // 遍历数组
    for (NSDictionary *dic in arr) {
        @autoreleasepool {            // 写一个自动释放池
            
        // 通过便利构造器来创建对象
        id model = [[self class] baseModelWithDic:dic]; // 获取类型 调用下面的方法(多态)
        [modelArr addObject:model];
            
        }
    }
    return modelArr;
}

// 写一个便利构造器
+ (instancetype)baseModelWithDic:(NSDictionary *)dic {
    // 通过多态创建对象
    id model = [[[self class] alloc] initWithDic:dic] ;
    return model;
}

- (instancetype)initWithDic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        // 进行KVC的赋值
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

// 补上一个纠错方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}



@end
