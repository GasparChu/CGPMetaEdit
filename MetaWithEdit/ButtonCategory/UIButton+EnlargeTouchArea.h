//
//  UIButton+EnlargeTouchArea.h
//  SuperIntegration
//
//  Created by PP－mac001 on 16/3/24.
//  Copyright © 2016年 PP－mac001. All rights reserved.
//


/**
 *  扩大button的实际点击范围
 */

#import <UIKit/UIKit.h>

@interface UIButton (EnlargeTouchArea)

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left;

@end
