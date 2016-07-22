//
//  YYAPI.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

//***************************http请求定义 start***************************************//

extern NSString *const YYProjectBaseUrl;

extern NSString *const YYLocationUrl;

//***************************http请求定义 end***************************************//

@interface YYAPI : NSObject

+ (instancetype)sharedManager;

@end
