//
//  YYDataHandle.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYDataHandle.h"

@implementation YYDataHandle

static YYDataHandle *sharedManager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (void)setUserDefaultStringValue:(id)obj WithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    
    //BUG FIX:防止当应用突然退出时，数据没有保存
    [defaults synchronize];
}

- (NSString *)userDefaultStringValueWithKey:(NSString *)key {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
}

@end
