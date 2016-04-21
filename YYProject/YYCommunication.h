//
//  YYCommunication.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYCommunicationDelegate <NSObject>

@required

- (void)requestResult:(nullable id)responseObject URLString:(nullable NSString *)URLString otherParams:(nullable id)otherParams;

- (void)requestFailure:(nullable NSString *)URLString error:(nullable NSError *)error otherParams:(nullable id)otherParams;

@end

/**
 *  请求方式
 */
typedef NS_ENUM(NSInteger, YYCommunicationMode) {
    /**
     *  get请求
     */
    YYCommunicationModeGet = 0,
    /**
     *  post请求
     */
    YYCommunicationModePost,
};

@interface YYCommunication : NSObject

@property (nullable, nonatomic, weak) id <YYCommunicationDelegate> delegate;

+ (nullable instancetype)sharedManager;


- (void)httpRequest:(nonnull NSString *)URLString parameters:(nullable id)parameters otherParams:(nullable id)otherParams mode:(YYCommunicationMode)mode;

- (void)httpRequest:(nonnull NSString *)URLString parameters:(nullable id)parameters otherParams:(nullable id)otherParams mode:(YYCommunicationMode)mode uidAndTokenFlag:(BOOL)uidAndTokenFlag;

- (void)httpRequest:(nonnull NSString *)URLString parameters:(nullable id)parameters otherParams:(nullable id)otherParams mode:(YYCommunicationMode)mode uidAndTokenFlag:(BOOL)uidAndTokenFlag imageData:(nullable NSData *)data imageParamName:(nullable NSString *)imageParamName;

- (void)cancleRequestByNotificationName:(nullable NSString *)notificationName;





/**
 *  废弃的网络请求
 *
 *  @param URLString        网址
 *  @param parameters       参数
 *  @param mode             post or get
 *  @param notificationName 通知名
 */
- (void)httpRequest:(nullable NSString *)URLString parameters:(nullable id)parameters mode:(YYCommunicationMode)mode notificationName:(nullable NSString *)notificationName __deprecated_msg("Method deprecated. Use `httpRequest:parameters:otherParams:mode:`");

/**
 *  废弃的网络请求
 *
 *  @param URLString        网址
 *  @param parameters       参数
 *  @param mode             post or get
 *  @param notificationName 通知名
 *  @param uidAndTokenFlag  是否传递token
 */
- (void)httpRequest:(nullable NSString *)URLString parameters:(nullable id)parameters mode:(YYCommunicationMode)mode notificationName:(nullable NSString *)notificationName uidAndTokenFlag:(BOOL)uidAndTokenFlag __deprecated_msg("Method deprecated. Use `httpRequest:parameters:otherParams:mode:uidAndTokenFlag:`");

/**
 *  废弃的网络请求
 *
 *  @param URLString        网址
 *  @param parameters       参数
 *  @param mode             post or get
 *  @param notificationName 通知名
 *  @param uidAndTokenFlag  是否传递token
 *  @param data             图片数据
 *  @param imageParamName   图片上传参数名
 */
- (void)httpRequest:(nullable NSString *)URLString parameters:(nullable id)parameters mode:(YYCommunicationMode)mode notificationName:(nullable NSString *)notificationName uidAndTokenFlag:(BOOL)uidAndTokenFlag imageData:(nullable NSData *)data imageParamName:(nullable NSString *)imageParamName __deprecated_msg("Method deprecated. Use `httpRequest:parameters:otherParams:mode:uidAndTokenFlag:imageData:imageParamName:`");

@end



