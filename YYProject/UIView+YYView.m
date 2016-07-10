//
//  UIView+YYView.m
//  YYProject
//
//  Created by 杨毅辉 on 16/7/10.
//  Copyright © 2016年 yangyh. All rights reserved.
//

#import "UIView+YYView.h"

@implementation UIView (YYView)

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    
    [self borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:YES];
}

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor masksToBounds:(BOOL)masksToBounds {
    
    [self borderWidth:borderWidth borderColor:borderColor cornerRadius:0 masksToBounds:masksToBounds];
}

- (void)borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor cornerRadius:(CGFloat)cornerRadius masksToBounds:(BOOL)masksToBounds {
    
    UIView *view = self;
    
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor.CGColor;
    
    if (cornerRadius != 0) {
        
        view.layer.cornerRadius = cornerRadius;
    }
    
    view.layer.masksToBounds = masksToBounds;
}

@end
