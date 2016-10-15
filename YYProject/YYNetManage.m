//
//  YYNetManage.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYNetManage.h"

@implementation YYNetManage

+ (instancetype)sharedManager {
    
    static YYNetManage *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _sharedClient = [[YYNetManage alloc] initWithBaseURL:[NSURL URLWithString:YYProjectBaseUrl]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.responseSerializer.acceptableContentTypes =[NSSet setWithObjects:@"text/plain", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"application/xml", @"application/json", @"application/json;charset=UTF-8", nil];
    });
    
    return _sharedClient;
}

@end
