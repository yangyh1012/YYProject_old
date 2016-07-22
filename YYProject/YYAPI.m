//
//  YYAPI.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYAPI.h"

//***************************http请求定义 start***************************************//

NSString *const YYProjectBaseUrl = @"unknowName";

NSString *const YYLocationUrl = @"http://7xpso2.com1.z0.glb.clouddn.com/cities.txt";

//***************************http请求定义 end***************************************//

@implementation YYAPI

static YYAPI *sharedManager = nil;

- (id)init {
    
    if(self = [super init]) {
        
        
    }
    
    return self;
}

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}



@end
