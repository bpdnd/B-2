//
//  PlayViewController.h
//  B
//
//  Created by Admin on 2018/11/24.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import <IJKMediaFramework/IJKMediaFramework.h>
#import "PlayListModel.h"  //自定义slider
@interface PlayViewController : UIViewController<UINavigationControllerDelegate>
@property(nonatomic,strong) IJKFFMoviePlayerController *playerController;
@property(nonatomic,strong) IJKFFOptions *options;
@property(nonatomic,strong) PlayListModel *model;
@property(nonatomic,strong) UIImageView *pauseImage; //播放/暂停 图片
@property(nonatomic,strong) UISlider *slider;  
@end
