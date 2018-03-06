//
//  UIColor+UIColor+BGHexColor.h
//  AIFCore
//
//  Created by yintengxiang on 14-1-27.
//  Copyright (c) 2014年 Anjuke Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BGHexColor)

+ (UIColor *)colorWithHex:(uint)hex alpha:(CGFloat)alpha;

/**
 *  十六进制字符串转颜色
 */
+ (UIColor *)colorWithHexString:(NSString *)HexString;

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withBrighnessDelta:(CGFloat)delta;

+ (UIColor*) colorRGBonvertToHSB:(UIColor*)color withAlphaDelta:(CGFloat)delta;

+ (UIColor*) colorWithHex:(NSInteger)hexValue;

@end


#import <QuartzCore/QuartzCore.h>

@interface CALayer (LayerColor)
//给xib用的 可牛逼了
- (void)setBorderColorFromUIColor:(UIColor *)color;

@end
