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
@interface PlayViewController : UIViewController
@property(nonatomic,strong) IJKFFMoviePlayerController *playerController;
@property(nonatomic,strong) IJKFFOptions *options;
@property(nonatomic,copy) NSString *videoUrl;
@end
