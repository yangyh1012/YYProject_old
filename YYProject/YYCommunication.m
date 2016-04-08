//
//  YYCommunication.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYCommunication.h"
#import "YYNetManage.h"

@interface YYCommunication ()

@property (nonatomic, strong) NSMutableDictionary *requestDic;

@end

@implementation YYCommunication

static YYCommunication *sharedManager = nil;

- (id)init {
    
    if(self = [super init]) {
        
        self.requestDic = [[NSMutableDictionary alloc] init];
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

- (void)httpRequest:(NSString *)URLString parameters:(id)parameters otherParams:(id)otherParams mode:(YYCommunicationMode)mode {
    
    [self httpRequest:URLString parameters:parameters otherParams:otherParams mode:mode uidAndTokenFlag:NO];
}

- (void)httpRequest:(NSString *)URLString parameters:(id)parameters otherParams:(id)otherParams mode:(YYCommunicationMode)mode uidAndTokenFlag:(BOOL)uidAndTokenFlag {
    
    [self httpRequest:URLString parameters:parameters otherParams:otherParams mode:mode uidAndTokenFlag:uidAndTokenFlag imageData:nil imageParamName:nil];
}

- (void)httpRequest:(NSString *)URLString parameters:(id)parameters otherParams:(id)otherParams mode:(YYCommunicationMode)mode uidAndTokenFlag:(BOOL)uidAndTokenFlag imageData:(NSData *)data imageParamName:(NSString *)imageParamName {
    
    NSDictionary *parametersDic = nil;
    if (!parameters) {
        
        parameters = [NSMutableDictionary dictionary];
    }
    
    if (uidAndTokenFlag) {
        
        NSString *sid = [[YYDataHandle sharedManager] userDefaultStringValueWithKey:YYProjectSid];
        
        if ([NSString isStringEmpty:sid]) {
            
            sid = @"";
        }
        
        [parameters setObject:sid forKey:YYProjectSid];
        parametersDic = [parameters copy];
    } else {
        
        parametersDic = parameters;
    }
    
    DLog(@"====================================================================================================");
    DLog(@"请求的地址为：%@",URLString);
    DLog(@"参数列表为：%@",parametersDic);
    DLog(@"请求方式为：%@",@(mode));
    DLog(@"通知名称为：%@",[otherParams objectForKey:YYNotificationKey]);
    
    if (!data) {
        
        if (mode == 0) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"get请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [self.delegate requestResult:responseObject otherParams:otherParams URLString:URLString];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"get请求失败，请求地址为：%@",URLString);
                DLog(@"get请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [self.delegate requestFailure:URLString error:error otherParams:otherParams];
            }];
            
            [self.requestDic setObject:dataTask forKey:[otherParams objectForKey:YYNotificationKey]];
            
        } else if (mode == 1) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"post请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [self.delegate requestResult:responseObject otherParams:otherParams URLString:URLString];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"post请求失败，请求地址为：%@",URLString);
                DLog(@"post请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [self.delegate requestFailure:URLString error:error otherParams:otherParams];
            }];
            
            [self.requestDic setObject:dataTask forKey:[otherParams objectForKey:YYNotificationKey]];
        }
    } else {
        
        if (mode == 1) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                // 上传文件
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [NSString getCurrentTimeString]];
                
                //BUG FIX:name为图片上传的参数
                [formData appendPartWithFileData:data name:imageParamName fileName:fileName mimeType:@"image/png"];
                
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"post请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [self.delegate requestResult:responseObject otherParams:otherParams URLString:URLString];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"post请求失败，请求地址为：%@",URLString);
                DLog(@"post请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [self.delegate requestFailure:URLString error:error otherParams:otherParams];
            }];
            [self.requestDic setObject:dataTask forKey:[otherParams objectForKey:YYNotificationKey]];
        } else {
            
            //TODO:填充图片请求的get方法
        }
    }
}











- (void)httpRequest:(NSString *)URLString parameters:(id)parameters mode:(YYCommunicationMode)mode notificationName:(NSString *)notificationName {
    
    [self httpRequest:URLString parameters:parameters mode:mode notificationName:notificationName uidAndTokenFlag:NO];
}

- (void)httpRequest:(NSString *)URLString parameters:(id)parameters mode:(YYCommunicationMode)mode notificationName:(NSString *)notificationName uidAndTokenFlag:(BOOL)uidAndTokenFlag {
    
    [self httpRequest:URLString parameters:parameters mode:mode notificationName:notificationName uidAndTokenFlag:uidAndTokenFlag imageData:nil imageParamName:nil];
}

- (void)httpRequest:(NSString *)URLString parameters:(id)parameters mode:(YYCommunicationMode)mode notificationName:(NSString *)notificationName uidAndTokenFlag:(BOOL)uidAndTokenFlag imageData:(NSData *)data imageParamName:(NSString *)imageParamName {
    
    NSDictionary *parametersDic = nil;
    if (!parameters) {
        
        parameters = [NSMutableDictionary dictionary];
    }
    
    if (uidAndTokenFlag) {
        
        NSString *sid = [[YYDataHandle sharedManager] userDefaultStringValueWithKey:YYProjectSid];
        
        if ([NSString isStringEmpty:sid]) {
            
            sid = @"";
        }
        
        [parameters setObject:sid forKey:YYProjectSid];
        parametersDic = [parameters copy];
    } else {
        
        parametersDic = parameters;
    }
    
    DLog(@"====================================================================================================");
    DLog(@"请求的地址为：%@",URLString);
    DLog(@"参数列表为：%@",parametersDic);
    DLog(@"请求方式为：%@",@(mode));
    DLog(@"通知名称为：%@",notificationName);
    
    if (!data) {
        
        if (mode == 0) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] GET:URLString parameters:parametersDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"get请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"get请求失败，请求地址为：%@",URLString);
                DLog(@"get请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:error];
            }];
            [self.requestDic setObject:dataTask forKey:notificationName];
            
        } else if (mode == 1) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:parametersDic progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"post请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:responseObject];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"post请求失败，请求地址为：%@",URLString);
                DLog(@"post请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:error];
            }];
            [self.requestDic setObject:dataTask forKey:notificationName];
        }
    } else {
        
        if (mode == 1) {
            
            NSURLSessionDataTask *dataTask = [[YYNetManage sharedManager] POST:URLString parameters:parametersDic constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                // 上传文件
                NSString *fileName = [NSString stringWithFormat:@"%@.jpg", [NSString getCurrentTimeString]];
                
                //BUG FIX:name为图片上传的参数
                [formData appendPartWithFileData:data name:imageParamName fileName:fileName mimeType:@"image/png"];
                
            } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                DLog(@"post请求成功，请求地址为：%@",URLString);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:responseObject];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                DLog(@"post请求失败，请求地址为：%@",URLString);
                DLog(@"post请求失败，错误原因：%@",[NSString codeDescription:[error code]]);
                DLog(@"====================================================================================================");
                
                [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:error];
            }];
            [self.requestDic setObject:dataTask forKey:notificationName];
        } else {
            
            //TODO:填充图片请求的get方法
        }
    }
}

- (void)cancleRequestByNotificationName:(NSString *)notificationName {
    
    DLog(@"notificationName：%@请求被取消",notificationName);
    NSURLSessionDataTask *dataTask = [self.requestDic objectForKey:notificationName];
    if (dataTask) {
        
        [dataTask cancel];
        [self.requestDic removeObjectForKey:notificationName];
    }
}

@end
