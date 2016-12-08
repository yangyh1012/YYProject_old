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

- (void)requestSuccess:(nullable id)responseObject URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams;

- (void)requestFailure:(nullable NSError *)error URLString:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters otherParams:(nullable NSDictionary *)otherParams;

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


- (void)httpRequest:(nullable NSString *)URLString;

- (void)httpRequestWithAllPara:(nullable NSDictionary *)allPara;

- (void)cancleRequestByNotificationName:(nullable NSString *)notificationName;

- (void)cancleAllRequest;

@end



