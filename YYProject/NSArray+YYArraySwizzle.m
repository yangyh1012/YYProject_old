//
//  NSArray+YYArraySwizzle.m
//  YYProject
//
//  Created by yangyihui on 16/9/1.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "NSArray+YYArraySwizzle.h"

@implementation NSArray (YYArraySwizzle)

+ (void)load {
    
    Method fromMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method toMethod = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(save_array_objectAtIndex:));
    method_exchangeImplementations(fromMethod, toMethod);
}

- (id)save_array_objectAtIndex:(NSUInteger)idx {
    
    if (self.count - 1 < idx) {
        
        // 这里做一下异常处理，不然都不知道出错了。
        @try {
            
            return [self save_array_objectAtIndex:idx];
            
        } @catch (NSException *exception) {
            // 在崩溃后会打印崩溃信息，方便我们调试。
            DLog(@"---------- %s Crash Because Method %s  ----------\n", class_getName(self.class), __func__);
            DLog(@"%@", [exception callStackSymbols]);
            return nil;
        } @finally {
            
        }
    } else {
        
        return [self save_array_objectAtIndex:idx];
    }
}

@end
