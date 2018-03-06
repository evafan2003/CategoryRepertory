//
//  UIDatePicker+CustomPicker.m
//  iCarCustomer
//
//  Created by hefei on 2017/8/21.
//  Copyright © 2017年 dycd. All rights reserved.
//

#import "UIDatePicker+CustomPicker.h"

@implementation UIDatePicker (CustomPicker)

- (void)clearSpearatorLine
{
    for (UIView *subView in self.subviews)
    {
        if ([subView isKindOfClass:[UIPickerView class]])//取出UIPickerView
        {
            for(UIView *tmpView in subView.subviews)
            {
                if (tmpView.frame.size.height < 1)//取出分割线view
                {
                    tmpView.hidden = YES;//隐藏分割线
                }
            }
        }
    }
}


@end
