//
//  zhSidebarView.h
//  zhPopupControllerDemo
//
//  Created by zhanghao on 2016/12/27.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "zhPopupController-Prefix.pch"
#import "zhuSidebarCell.h"
#import "UIImageView+WebCache.h"


//波浪
#import "GLWave.h"
#import "GLWaveView.h"

@interface zhSidebarView : UIView <UITableViewDelegate,UITableViewDataSource,GLWaveViewDelegate>

@property (nonatomic, strong) NSArray<NSString *> *models;

@property (nonatomic, strong) GLWaveView *waveView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong, readonly) NSMutableArray<zhImageButton *> *items;
@property (nonatomic, copy) void (^didClickItems)(NSString *textStr, NSInteger index);

@end
