//
//  YYDataHandle.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYDataHandle : NSObject

+ (instancetype)sharedManager;

- (void)setUserDefaultStringValue:(id)obj WithKey:(NSString *)key;

- (NSString *)userDefaultStringValueWithKey:(NSString *)key;

@end
