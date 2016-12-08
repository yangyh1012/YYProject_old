//
//  UIView+YYView.h
//  YYProject
//
//  Created by 杨毅辉 on 16/7/10.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YYView)

/**
 *  添加视图边框
 *
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

- (void)cornerRadius:(CGFloat)cornerRadius;

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds;

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds;

@end
