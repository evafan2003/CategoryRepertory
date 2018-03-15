//
//  MBProgressHUD+Add.m
//
//

#define HUDFont [UIFont systemFontOfSize:15]
#define ErrorImage @""
#define SuccessImage @""

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabel.text = text;
    hud.detailsLabel.font = HUDFont;
    // 设置图片
//    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1.2秒之后消失
    [hud hideAnimated:YES afterDelay:1.2];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view andCompletionBlock:(void(^)(void))completionBlock
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:view];
    hud.label.text = success;
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    [view addSubview: hud];
    [hud showAnimated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (1.2* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud removeFromSuperview];
        completionBlock();
    });
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    
    [self show:error icon:ErrorImage view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
   [self show:success icon:SuccessImage view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
//    hud.dimBackground = NO;
    
    return hud;
}

@end
