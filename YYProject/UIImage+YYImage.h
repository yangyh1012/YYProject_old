//
//  UIImage+YYImage.h
//  YYProject
//
//  Created by 杨毅辉 on 16/4/2.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YYImage)

/**
 *  重构图片尺寸
 *
 *  @param image          图片
 *  @param maxScaleLength 图片尺寸
 *
 *  @return 处理后的图片
 */
+ (UIImage *)image:(UIImage *)image withMaxScaleLength:(CGFloat)maxScaleLength;


/**
 *  修改图片颜色（如何使用：[[UIImage imageNamed:@"image"] imageWithTintColor:[UIColor orangeColor]]; ）
 *
 *  @param tintColor 指定颜色
 *
 *  @return 图片
 */
- (UIImage *)imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)imageWithGradientTintColor:(UIColor *)tintColor;

@end
