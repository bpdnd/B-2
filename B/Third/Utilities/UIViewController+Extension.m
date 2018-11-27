//
//  UIViewController+Extension.m
//  Gao
//
//  Created by Admin on 2018/10/17.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)

- (zhAlertView *)alertView1WithTitle:(NSString *)title WithMessage:(NSString *)message {
    zhAlertView *alertView = [[zhAlertView alloc] initWithTitle:title
                                                        message:message
                                                  constantWidth:290];
    return alertView;
}

- (zhAlertView *)alertView2WithTitle:(NSString *)title Message:(NSString *)message {
    zhAlertView *alertView = [[zhAlertView alloc] initWithTitle:title
                                                        message:message
                                                  constantWidth:250];
    alertView.titleLabel.textColor = [UIColor r:80 g:72 b:83];
    alertView.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    alertView.messageLabel.textColor = [UIColor blackColor];
    return alertView;
}

- (zhOverflyView *)overflyViewWithTitle:(NSString *)titleStr Message:(NSString *)message {
    
    NSString *title1 = @"通知";
    NSString *title2 = titleStr;
    NSString *text = [NSString stringWithFormat:@"%@\n%@", title1, title2];
    NSMutableAttributedString *attiTitle = [[NSMutableAttributedString alloc] initWithString:text];
    
    [attiTitle addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:[text rangeOfString:title1]];
    [attiTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:[text rangeOfString:title1]];
    
    [attiTitle addAttribute:NSForegroundColorAttributeName value:[UIColor r:236 g:78 b:39] range:[text rangeOfString:title2]];
    [attiTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:[text rangeOfString:title2]];
    
    [attiTitle addAttribute:NSKernAttributeName value:@1.2 range:[text rangeOfString:title2]];//字距调整
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:7];
    [attiTitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];//行距调整
    
    NSString *msg = message;
    NSMutableAttributedString *attiMessage = [[NSMutableAttributedString alloc] initWithString:msg];
    [attiMessage addAttribute:NSKernAttributeName value:@1.1 range:NSMakeRange(0, [msg length])];
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:7];
    [attiMessage addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [msg length])];
    [attiMessage addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, [msg length])];
    [attiMessage addAttribute:NSForegroundColorAttributeName value:[UIColor r:49 g:49 b:39      ] range:NSMakeRange(0, [msg length])];
    
    CGFloat fac = 475; // 已知透明区域高度
    UIImage *image = [UIImage imageNamed:@"fire_arrow"];
    
    zhOverflyView *overflyView = [[zhOverflyView alloc]
                                  initWithFlyImage:image
                                  highlyRatio:(fac / image.size.height)
                                  attributedTitle:attiTitle
                                  attributedMessage:attiMessage
                                  constantWidth:290];
    overflyView.layer.cornerRadius = 4;
    overflyView.messageEdgeInsets = UIEdgeInsetsMake(10, 22, 10, 22);
    overflyView.titleLabel.backgroundColor = [UIColor whiteColor];
    overflyView.titleLabel.textAlignment = NSTextAlignmentCenter;
    overflyView.splitLine.hidden = YES;
    [overflyView reloadAllComponents];
    return overflyView;
}

- (zhCurtainView *)curtainView {
    
    zhCurtainView *curtainView = [[zhCurtainView alloc] init];
    curtainView.width = [UIScreen width];
    [curtainView.closeButton setImage:[UIImage imageNamed:@"qzone_close"] forState:UIControlStateNormal];
    NSArray *imageNames = @[@"说说", @"照片", @"视频", @"签到", @"大头贴"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:imageNames.count];
    for (NSString *imageName in imageNames) {
        UIImage *image = [UIImage imageNamed:[@"qzone_" stringByAppendingString:imageName]];
        [models addObject:[zhImageButtonModel modelWithTitle:imageName image:image]];
    }
    curtainView.models = models;
    return curtainView;
}

- (zhSidebarView *)sidebarView {
    
    zhSidebarView *sidebarView = [zhSidebarView new];
    sidebarView.size = CGSizeMake([UIScreen width] - 90, [UIScreen height]);
    sidebarView.backgroundColor = [UIColor r:24 g:28 b:45 alphaComponent:0.8];
    return sidebarView;
}

- (zhFullView *)fullView {
    
    zhFullView *fullView = [[zhFullView alloc] initWithFrame:self.view.frame];
    NSArray *array = @[@"文字", @"照片视频", @"头条文章", @"红包", @"直播", @"点评", @"好友圈", @"更多", @"音乐", @"商品", @"签到", @"秒拍", @"头条文章", @"红包", @"直播", @"点评"];
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:array.count];
    for (NSString *string in array) {
        zhImageButtonModel *item = [zhImageButtonModel new];
        item.icon = [UIImage imageNamed:[NSString stringWithFormat:@"sina_%@", string]];
        item.text = string;
        [models addObject:item];
    }
    fullView.models = models;
    return fullView;
}



#define titleKey @"title"
#define imgNameKey @"imageName"
-(void)changeBackBtn{
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }else{
        self.navigationController.navigationBar.translucent = NO;
    }
    self.navigationItem.backBarButtonItem =[[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    // 导航栏左右按钮字体颜色
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
}

@end
