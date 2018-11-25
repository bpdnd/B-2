//
//  PlayViewController.m
//  B
//
//  Created by Admin on 2018/11/24.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self changeBackBtn];
    [self createUI];
   
}
-(void)createUI{
    self.options = [[IJKFFOptions alloc]init];
    self.playerController = [[IJKFFMoviePlayerController alloc]initWithContentURLString:self.videoUrl withOptions:self.options];
    self.playerController.view.frame = CGRectMake(0, 0,ScreenWidth , 300);
    self.playerController.shouldAutoplay = true;
    [self.view addSubview:self.playerController.view];
    self.operationView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.operationView.hidden = YES;
    });
}
#pragma 操作界面
-(OperationView *)operationView{
    if (!_operationView) {
        _operationView = [[OperationView alloc]init];
        [self.playerController.view addSubview:_operationView];
        [_operationView mas_makeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(self.playerController.view.mas_left).offset(0);
             make.right.equalTo(self.playerController.view.mas_right).offset(0);
             make.bottom.equalTo(self.playerController.view.mas_bottom).offset(0);
             make.height.mas_equalTo(30);
        }];
    }
    return _operationView;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerController prepareToPlay];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.playerController stop];
}
#pragma 添加通知
-(void)addObserver{
    //1. 添加用户改变播放状态改变时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:self.playerController];
    //2.  当网络加载状态发生变化时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playLoadStateDidChange:) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.playerController];
}
//播放状态改变时
- (void) playbackStateDidChange:(NSNotification *) notification {
    switch (self.playerController.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"停止");
            break;
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
            break;
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"打断");
            break;
        case IJKMPMoviePlaybackStateSeekingForward:
            NSLog(@"快进");
            break;
        case IJKMPMoviePlaybackStateSeekingBackward:
            NSLog(@"快退");
            break;
        default:
            break;
    }
}
-(void)playLoadStateDidChange:(NSNotification *)notification{
    switch (self.playerController.loadState) {
        case IJKMPMovieLoadStateUnknown:{
            NSLog(@"未知状态");
        }
            break;
        case IJKMPMovieLoadStatePlayable:{
            NSLog(@"状态==>IJKMPMovieLoadStatePlayable");
        }   break;
        case IJKMPMovieLoadStatePlaythroughOK:{
            NSLog(@"状态==>IJKMPMovieLoadStatePlaythroughOK"); //// 当shouldAutoPlay 为Yes时，将开始在这种状态
        }   break;
        case IJKMPMovieLoadStateStalled:{
            NSLog(@"状态==>IJKMPMovieLoadStateStalled"); //播放后，自动设定为该方法
        }   break;
        default:
            break;
    }
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
