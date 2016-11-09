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

#define RGB_C(rgb) [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:1.0]
#define RGB_CA(rgb,a) [UIColor colorWithRed:rgb/255.0 green:rgb/255.0 blue:rgb/255.0 alpha:a]
#define RGB_Color(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGB_ColorA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define Swizzle_Flag NO

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

extern NSString *const YYNotificationLoginFirst;

extern NSString *const YYNotificationPageLoad;

extern NSString *const YYTestNotification;


extern NSString *const YYNotificationKey;

extern NSString *const YYLocationNotification;

//***************************http请求通知名称定义 end***************************************//

@interface YYConstants : NSObject

+ (instancetype)sharedManager;

- (UIImage *)YYProjectDefaultImage;

- (UIColor *)YYProjectDefaultColor;

- (UIColor *)YYProjectLightColor;

- (UIColor *)YYProjectLightLightColor;

- (UIColor *)YYProjectButtonColor;

@end
