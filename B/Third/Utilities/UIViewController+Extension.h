//
//  UIViewController+Extension.h
//  Gao
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "zhAlertView.h"
#import "zhOverflyView.h"
#import "zhCurtainView.h"
#import "zhSidebarView.h"
#import "zhFullView.h"
@interface UIViewController (Extension)
- (zhAlertView *)alertView1WithTitle:(NSString *)title WithMessage:(NSString *)message;
- (zhAlertView *)alertView2WithTitle:(NSString *)title Message:(NSString *)message;
- (zhOverflyView *)overflyViewWithTitle:(NSString *)titleStr Message:(NSString *)message;
- (zhCurtainView *)curtainView;
- (zhSidebarView *)sidebarView;
- (zhFullView *)fullView;
/**
 修改返回按钮
 */
-(void)changeBackBtn;
@end
