//
//  NSArray+WB_array.m
//  WBKIT
//
//  Created by 张文博 on 16/7/26.
//  Copyright © 2016年 张文博. All rights reserved.
//

#import "NSArray+WB_array.h"

@implementation NSArray (WB_array)

- (id)wb_objectAtIndex:(NSUInteger)index {
    NSUInteger count = [self count];
    if (count >0 && index<count) {
        return [self objectAtIndex:index];
    }else {
        
        return nil;
    }
}

- (BOOL)wb_isContainsString:(NSString *)str {
    for (NSString *element in self) {
        if ([element isKindOfClass:[NSString class]] && [element isEqualToString:str]) {
            return true;
        }
    }
    return false;
}

- (NSArray *)wb_reverseArray{
    
    NSMutableArray *arrayTemp = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator) {
        [arrayTemp addObject:element];
    }
    return arrayTemp;
}


@end
