//
//  NSString+YYString.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YYString)

/**
 *  去除头尾空格
 *
 *  @param string  需要处理的字符串
 *
 *  @return 处理后的字符串
 */
+ (NSString *)stringByTrim:(NSString *)string;

/**
 *  检测字符串是否为空
 *
 *  @param string 需要检测的字符串
 *
 *  @return Yes为空，NO为非空
 */
+ (BOOL)isStringEmpty:(NSString *)string;

/**
 *  生成当前时间字符串
 *
 *  @return 当前时间字符串
 */
+ (NSString *)getCurrentTimeString;

/**
 *  状态码错误详细说明
 *
 *  @param code 状态码
 *
 *  @return 状态码错误详细说明
 */
+ (NSString *)codeDescription:(NSInteger)code;

@end
