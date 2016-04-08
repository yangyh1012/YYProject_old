//
//  MJExtensionConfig.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "MJExtensionConfig.h"
#import "YYTestData.h"

@implementation MJExtensionConfig

+ (void)load {
    
    [YYTestData mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{
                 @"idd" : @"id"
                 };
    }];
}

@end
