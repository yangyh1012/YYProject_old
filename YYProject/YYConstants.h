//
//  YYConstants.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define Scale_To_iPhone6 375 / 320.0f
#define Scale_To_iPhone6P 414 / 320.0f

//***************************数据名称定义 start***************************************//

extern NSString *const YYProjectSid;
extern NSString *const YYProjectStatusFailed;
extern NSString *const YYProjectStatusSuccess;
extern NSString *const YYProjectStatusLoginFirst;

//***************************数据名称定义 end***************************************//

//***************************界面定义 start***************************************//

extern NSInteger const YYProjectStartPage;

extern CGFloat const YYProjectHUDLoadTextFont;
extern CGFloat const YYProjectHUDTipTextFont;
extern CGFloat const YYProjectHUDTipTime;
extern NSString *const YYProjectHUDRequestTipText;
extern NSString *const YYProjectHUDLoadTipText;

//***************************界面定义 end***************************************//



//***************************http请求通知名称定义 start***************************************//

extern NSString *const YYNotificationKey;

extern NSString *const YYNotificationLoginFirst;

extern NSString *const YYNotificationPageLoad;

extern NSString *const YYTestNotification;

//***************************http请求通知名称定义 end***************************************//

@interface YYConstants : NSObject

+ (instancetype)sharedManager;

- (UIImage *)YYProjectDefaultImage;

- (UIColor *)YYProjectDefaultColor;

- (UIColor *)YYProjectLightColor;

@end
