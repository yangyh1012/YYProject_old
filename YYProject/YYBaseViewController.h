//
//  YYBaseViewController.h
//  YYProject
//
//  Created by 杨毅辉 on 16/3/12.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNetManage.h"

@protocol YYBaseViewControllerTestDelegate <NSObject>

@required

- (void)testDelegateHandle:(id _Nullable)object;

@optional

@end

typedef NS_ENUM(NSInteger, YYBaseViewControllerTestType) {
    
    YYBaseViewControllerTestType1 = 0,
    YYBaseViewControllerTestType2,
};

@interface YYBaseViewController : UIViewController


@property (nullable, nonatomic, weak) id <YYBaseViewControllerTestDelegate> testDelegate;

@property (nonatomic, assign) YYBaseViewControllerTestType baseViewControllerTestType;



@property (nonatomic, assign) NSInteger pageNum;

/**
 *  按钮设置网络背景图(默认 UIViewContentModeScaleAspectFit)
 *
 *  @param button 按钮
 *  @param urlStr 网址字符串
 */
- (void)btnSettingBackgroundImageViewForBtn:(nullable UIButton *)button urlStr:(nullable NSString *)urlStr;

/**
 *  按钮设置网络背景图
 *
 *  @param button 按钮
 *  @param urlStr 网址字符串
 *  @param flag   YES 设置 UIViewContentModeScaleAspectFit
 */
- (void)btnSettingBackgroundImageViewForBtn:(nullable UIButton *)button urlStr:(nullable NSString *)urlStr contentModeFlag:(BOOL)flag;

/**
 *  富文本
 *
 *  @param allStr   需要处理的整个字符串
 *  @param rangeStr 需要处理的部分字符串
 *
 *  @return 处理后的富文本（默认 redColor）
 */
- (nullable NSMutableAttributedString *)attributedStringSetting:(nullable NSString *)allStr rangeStr:(nullable NSString *)rangeStr;

/**
 *  富文本
 *
 *  @param allStr   需要处理的整个字符串
 *  @param rangeStr 需要处理的部分字符串
 *  @param color    文字颜色
 *
 *  @return 处理后的富文本
 */
- (nullable NSMutableAttributedString *)attributedStringSetting:(nullable NSString *)allStr rangeStr:(nullable NSString *)rangeStr textColor:(nullable UIColor *)color;


- (void)requestResult:(nullable id)responseObject otherParams:(nullable id)otherParams URLString:(nullable NSString *)URLString;

- (void)requestFailure:(nullable NSString *)URLString error:(nullable NSError *)error otherParams:(nullable id)otherParams;




- (CGFloat)multiplesForPhone;

- (nullable NSString *)nullStrSetting:(nullable NSString *)str;





- (void)showHUDWithText:(nullable NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize;

- (void)hide:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (CGFloat)HUDOffsetY;

@end
