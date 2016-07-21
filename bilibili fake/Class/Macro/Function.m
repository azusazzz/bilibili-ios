//
//  Function.m
//  bilibili fake
//
//  Created by 翟泉 on 2016/7/21.
//  Copyright © 2016年 云之彼端. All rights reserved.
//

#import "Function.h"
#import "UIViewController+GetViewController.h"

MBProgressHUD * HUDSuccess(NSString *message) {
    return HUDSuccessInView(message, UIViewController.currentViewController.view);
}

MBProgressHUD * HUDSuccessInView(NSString *message, UIView *inView) {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:inView];
    HUD.labelText = message;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUDSuccess"]];
    HUD.mode = MBProgressHUDModeCustomView;
    [inView addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    
    return HUD;
}


MBProgressHUD * HUDFailure(NSString *message) {
    return HUDFailureInView(message, UIViewController.currentViewController.view);
}

MBProgressHUD * HUDFailureInView(NSString *message, UIView *inView) {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:inView];
    HUD.detailsLabelText = message;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.mode = MBProgressHUDModeText;
    [inView addSubview:HUD];
    [HUD show:YES];
    [HUD hide:YES afterDelay:1];
    return HUD;
}

MBProgressHUD * HUDLoading(NSString *message) {
    return HUDLoadingInView(message, UIViewController.currentViewController.view);
}


MBProgressHUD * HUDLoadingInView(NSString *message, UIView *inView) {
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:inView];
    HUD.labelText = message;
    HUD.removeFromSuperViewOnHide = YES;
    HUD.tag = 15787452;
    [inView addSubview:HUD];
    [HUD show:YES];
    return HUD;
}

void HUDLoadingHidden(void) {
    HUDLoadingHiddenInView(UIViewController.currentViewController.view);
}

void HUDLoadingHiddenInView(UIView *inView) {
    MBProgressHUD *HUD = [inView viewWithTag:15787452];
    [HUD hide:YES];
}
