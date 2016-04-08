//
//  YYNetManage.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface YYNetManage : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
