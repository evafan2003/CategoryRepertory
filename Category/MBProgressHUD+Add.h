//
//  MBProgressHUD+Add.h
//
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Add)

+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view andCompletionBlock:(void(^)(void))completionBlock;
+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view;


@end
