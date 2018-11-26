//
//  PlayViewController.m
//  B
//
//  Created by Admin on 2018/11/24.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController (){
    dispatch_source_t  _timer;
}
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
    self.options.showHudView = YES;
    // 自动转屏开关
    [self.options setFormatOptionIntValue:0 forKey:@"auto_convert"];
    self.playerController = [[IJKFFMoviePlayerController alloc]initWithContentURLString:self.videoUrl withOptions:self.options];
    self.playerController.view.frame = CGRectMake(0, 0,ScreenWidth , 300);
    self.playerController.shouldAutoplay = true;
    /*
     *IJKMPMovieScalingModeNone 不拉伸
     *IJKMPMovieScalingModeAspectFit  均匀拉伸直到一个尺寸合适
     *IJKMPMovieScalingModeAspectFill  均匀拉伸，直到电影填充可见边界。一个维度可能有被裁剪的内容
     *IJKMPMovieScalingModeFill 不均匀伸。渲染维度将完全匹配可见边界
     */
    [self.playerController setScalingMode:IJKMPMovieScalingModeAspectFit];

    
    
    [self.view addSubview:self.playerController.view];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [tap addTarget:self action:@selector(playerControllerTapEvent)];
    [self.playerController.view addGestureRecognizer:tap];
    //操作界面
    self.operationView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];

}
#pragma playerControllerTapEvent 播放界面点击事件
-(void)playerControllerTapEvent{
    if (self.operationView.isHidden) {
        self.operationView.hidden = NO;
    }else{
        self.operationView.hidden = YES;
    }
    
}
#pragma 操作界面
-(OperationView *)operationView{
    if (!_operationView) {
        _operationView = [[OperationView alloc]init];
        [_operationView.stopButton addTarget:self action:@selector(operationViewStopEvent) forControlEvents:UIControlEventTouchUpInside];
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
-(void)operationViewStopEvent{
        switch (self.playerController.playbackState) {
            case IJKMPMoviePlaybackStatePaused:
            case IJKMPMoviePlaybackStateStopped:
                
                [self.playerController play];
                [self.operationView changeStopImageWithBOOL:YES];
                break;
            case IJKMPMoviePlaybackStatePlaying:
                [self.playerController pause];
                [self.operationView changeStopImageWithBOOL:NO];
                break;
            default:
                break;
        }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerController prepareToPlay]; //自动播放
    [self createTime];
    [self addObserver];
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
            [self pauseTime];
            break;
        case IJKMPMoviePlaybackStatePlaying:
            NSLog(@"正在播放");
           
            break;
        case IJKMPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            [self pauseTime];
            break;
        case IJKMPMoviePlaybackStateInterrupted:
            NSLog(@"打断");
            [self pauseTime];
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
//当网络加载状态发生变化时
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
//创建定时器
-(void)createTime{
    __weak typeof(self) weakSelf = self;
    dispatch_queue_t queue = dispatch_get_main_queue();
    //创建定时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    //何时开始
    dispatch_time_t start = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0*NSEC_PER_SEC));
    //时间间隔
    uint64_t interval = (uint64_t)(1.0 * NSEC_PER_SEC);
    dispatch_source_set_timer(_timer, start, interval, 0);
    //设置回调
    dispatch_source_set_event_handler(_timer, ^{
        NSLog(@"%f/%f--%f--%ld",weakSelf.playerController.currentPlaybackTime,weakSelf.playerController.duration,weakSelf.playerController.playableDuration,(long)weakSelf.playerController.bufferingProgress);
        [weakSelf.operationView changeSlider:weakSelf.playerController.currentPlaybackTime withDurationTime:weakSelf.playerController.duration];
    });
    [self startTime];
}
//开启定时器
-(void)startTime{
    if (_timer) {
        dispatch_resume(_timer);
    }
}
//暂停定时器
-(void)pauseTime{
    if (_timer) {
        dispatch_suspend(_timer);
    }
}
//取消定时器
-(void) stopTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
        _timer = nil;
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
