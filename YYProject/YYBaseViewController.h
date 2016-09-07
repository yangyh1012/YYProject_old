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

- (void)testDelegateHandle:(id)object;

@optional

@end

typedef NS_ENUM(NSInteger, YYBaseViewControllerTestType) {
    
    YYBaseViewControllerTestType1 = 0,
    YYBaseViewControllerTestType2,
};

@interface YYBaseViewController : UIViewController<YYCommunicationDelegate>


@property (nonatomic, weak) id <YYBaseViewControllerTestDelegate> testDelegate;

@property (nonatomic, assign) YYBaseViewControllerTestType baseViewControllerTestType;

@property (nonatomic, assign) NSInteger pageNum;



/**
 *  按钮设置网络背景图(默认 UIViewContentModeScaleAspectFit)
 *
 *  @param button 按钮
 *  @param urlStr 网址字符串
 */
- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr;

- (void)btnSettingBackgroundImageViewForBtn:(UIButton *)button urlStr:(NSString *)urlStr contentModeFlag:(BOOL)flag;



/**
 *  富文本
 *
 *  @param allStr   需要处理的整个字符串
 *  @param rangeStr 需要处理的部分字符串
 *  @param flag     是否需要下划线
 *
 *  @return 处理后的富文本
 */
- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr underLineFlag:(BOOL)flag;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font;

- (NSMutableAttributedString *)attributedStringSetting:(NSString *)allStr rangeStr:(NSString *)rangeStr textColor:(UIColor *)color fontSize:(UIFont *)font underLineFlag:(BOOL)flag;




- (void)requestResult:(id)responseObject URLString:(NSString *)URLString otherParams:(id)otherParams;

- (void)requestFailure:(NSString *)URLString error:(NSError *)error otherParams:(id)otherParams;




- (CGFloat)multiplesForPhone;

- (NSString *)nullStrSetting:(NSString *)str;


/**
 *  当没有数据时，显示提示框
 *
 *  @param tip 提示的文字
 *  @param y   提示框的纵坐标
 */
- (void)showDataEmptyTip:(NSString *)tip positionY:(CGFloat)y;

- (void)hideDataEmptyTip;


/**
 *  时差计算
 *
 *  @param anyDate 日期
 *
 *  @return 根据时差转换后的日期
 */
- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate;

/**
 *  根据子视图得到某个特定类型的父视图View
 *
 *  @param aClass 特定类型
 *  @param sender 子视图
 *
 *  @return 某个特定类型的View
 */
- (id)isCorrectViewWithClass:(Class)aClass subView:(id)sender;

/**
 *  显示加载提示框
 *
 *  @param text     提示文字
 *  @param mode     提示框样式（MBProgressHUDModeIndeterminate，MBProgressHUDModeText）
 *  @param yOffset  提示框的纵坐标
 *  @param fontSize 提示框的文字大小
 */
- (void)showHUDWithText:(NSString *)text mode:(MBProgressHUDMode)mode yOffset:(CGFloat)yOffset font:(CGFloat)fontSize;

- (void)hide:(BOOL)animated;

- (void)hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (CGFloat)HUDOffsetY;


@end
