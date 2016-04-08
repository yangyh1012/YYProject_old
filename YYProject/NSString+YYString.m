//
//  NSString+YYString.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "NSString+YYString.h"

@implementation NSString (YYString)

+ (NSString *)stringByTrim:(NSString *)string {
    
    return string == nil ? nil : [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isStringEmpty:(NSString *)string {
    
    return string == nil ? YES : [NSString stringByTrim:string].length < 1 ? YES : NO;
}

+ (NSString *)getCurrentTimeString {
    
    NSDateFormatter *dateformat=[[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyyMMddHHmmss"];
    
    return [dateformat stringFromDate:[NSDate date]];
}

+ (NSString *)codeDescription:(NSInteger)code {
    
    NSString *errorDescription = nil;
    switch (code) {
            
        case -998:
        {
            errorDescription = @"未知网络错误";//kCFURLErrorUnknown
        }
            break;
        case -999:
        {
            errorDescription = @"未知网络错误";//kCFURLErrorCancelled
        }
            break;
        case -1000:
        {
            errorDescription = @"主域名错误";//kCFURLErrorBadURL
        }
            break;
        case -1001:
        {
            errorDescription = @"网络连接超时";//kCFURLErrorTimedOut
        }
            break;
        case -1002:
        {
            errorDescription = @"不支持网址错误";//kCFURLErrorUnsupportedURL
        }
            break;
        case -1003:
        {
            errorDescription = @"未找到主机";//kCFURLErrorCannotFindHost
        }
            break;
        case -1004:
        {
            errorDescription = @"无法连接到主机";//kCFURLErrorCannotConnectToHost
        }
            break;
        case -1005:
        {
            errorDescription = @"连接丢失";//kCFURLErrorNetworkConnectionLost
        }
            break;
        case -1006:
        {
            errorDescription = @"DNS搜寻失败";//kCFURLErrorDNSLookupFailed
        }
            break;
        case -1007:
        {
            errorDescription = @"多重定向失败";//kCFURLErrorHTTPTooManyRedirects
        }
            break;
        case -1008:
        {
            errorDescription = @"资源不可用";//kCFURLErrorResourceUnavailable
        }
            break;
        case -1009:
        {
            errorDescription = @"网络连接失败";//kCFURLErrorNotConnectedToInternet
        }
            break;
        case -1010:
        {
            errorDescription = @"重定向失败";//kCFURLErrorRedirectToNonExistentLocation
        }
            break;
        case -1011:
        {
            errorDescription = @"服务器响应失败";//kCFURLErrorBadServerResponse
        }
            break;
        case -1012:
        {
            errorDescription = @"用户取消认证失败";//kCFURLErrorUserCancelledAuthentication
        }
            break;
        case -1013:
        {
            errorDescription = @"用户请求认证失败";//kCFURLErrorUserAuthenticationRequired
        }
            break;
        case -1014:
        {
            errorDescription = @"服务器无资源";//kCFURLErrorZeroByteResource
        }
            break;
        case -1015:
        {
            errorDescription = @"数据解码失败";//kCFURLErrorCannotDecodeRawData
        }
            break;
        case -1016:
        {
            errorDescription = @"数据解码失败";//kCFURLErrorCannotDecodeContentData
        }
            break;
        case -1017:
        {
            errorDescription = @"无法解析响应数据";//kCFURLErrorCannotParseResponse
        }
            break;
        case -1018:
        {
            errorDescription = @"网络漫游错误";//kCFURLErrorInternationalRoamingOff
        }
            break;
        case -1019:
        {
            errorDescription = @"当前请求不活跃";//kCFURLErrorCallIsActive
        }
            break;
        case -1020:
        {
            errorDescription = @"数据不被允许";//kCFURLErrorDataNotAllowed
        }
            break;
        case -1021:
        {
            errorDescription = @"请求包被清空";//kCFURLErrorRequestBodyStreamExhausted
        }
            break;
        case -1100:
        {
            errorDescription = @"文件不存在";//kCFURLErrorFileDoesNotExist
        }
            break;
        case -1101:
        {
            errorDescription = @"文件目录不存在";//kCFURLErrorFileIsDirectory
        }
            break;
        case -1102:
        {
            errorDescription = @"没有读取文件的权限";//kCFURLErrorNoPermissionsToReadFile
        }
            break;
        case -1103:
        {
            errorDescription = @"数据包长度超过限制";//kCFURLErrorDataLengthExceedsMaximum
        }
            break;
        default:
        {
            errorDescription = @"未知错误 错误码解析失败";
        }
            break;
    }
    
    return errorDescription;
}

@end
