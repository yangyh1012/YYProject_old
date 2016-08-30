//
//  YYConstants.m
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "YYConstants.h"

//***************************数据名称定义 start***************************************//

NSString *const YYProjectSid = @"YYProjectSid_YYProject";

NSString *const YYProjectStatusFailed = @"0";
NSString *const YYProjectStatusSuccess = @"1";
NSString *const YYProjectStatusLoginFirst = @"2";

//***************************数据名称定义 end***************************************//




//***************************界面定义 start***************************************//

NSInteger const YYProjectStartPage = 1;

CGFloat const YYProjectHUDLoadTextFont = 20.0f;
CGFloat const YYProjectHUDTipTextFont = 15.0f;
CGFloat const YYProjectHUDTipTime = 1.5f;
NSString *const YYProjectHUDRequestTipText = @"正在请求数据";
NSString *const YYProjectHUDLoadTipText = @"正在加载数据";

//***************************界面定义 end***************************************//





//***************************http请求通知名称定义 start***************************************//
NSString *const YYTestNotification = @"YYTestNotification_YYProject";

NSString *const YYNotificationLoginFirst = @"YYTestNotification_YYNotificationLoginFirst";

NSString *const YYNotificationPageLoad = @"YYTestNotification_YYNotificationPageLoad";


NSString *const YYNotificationKey = @"YYNotification_YYNotificationKey";

NSString *const YYLocationNotification = @"YYLocationNotification";

//***************************http请求通知名称定义 end***************************************//


@implementation YYConstants

static YYConstants *sharedManager = nil;

+ (instancetype)sharedManager {
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (UIImage *)YYProjectDefaultImage {
    
    return [UIImage imageNamed:@"defaultImage"];
}

- (UIColor *)YYProjectDefaultColor {
    
    return RGB_Color(166, 137, 45);
}

- (UIColor *)YYProjectLightColor {
    
    return RGB_Color(230, 230, 230);
}

- (UIColor *)YYProjectLightLightColor {
 
    return RGB_Color(245, 245, 245);
}


@end
