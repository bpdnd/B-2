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
    self.navigationController.delegate = self;
    [self changeBackBtn];
    [self createUI];
}
#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
}
#pragma 创建视图
-(void)createUI{
    self.options = [[IJKFFOptions alloc]init];
    self.options.showHudView = YES;
    // 自动转屏开关
    [self.options setFormatOptionIntValue:0 forKey:@"auto_convert"];
    self.playerController = [[IJKFFMoviePlayerController alloc]initWithContentURLString:self.model.videoUrl withOptions:self.options];
    self.playerController.view.frame = self.view.bounds;
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
    
    self.slider.minimumValue = 0;
    self.slider.maximumValue = 1;
    
}
#pragma playerControllerTapEvent 播放界面手势 点击事件
-(void)playerControllerTapEvent{
    
    if (self.playerController.isPlaying) {
        [self isShowPauseImageView:YES withState:1];
        [self.playerController pause];
    }else{
        [self isShowPauseImageView:NO withState:0];
        [self.playerController play];
    }
}
#pragma 播放/暂停 图片
-(UIImageView *)pauseImage{
    if (!_pauseImage) {
        _pauseImage = [[UIImageView alloc]init];
        [self.playerController.view addSubview:_pauseImage];
        [_pauseImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.playerController.view.mas_centerX).offset(0);
            make.centerY.equalTo(self.playerController.view.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    return _pauseImage;
}
//根据状态显示图片 0:没有 1:播放图片 2:暂停图片 3:重播图片
-(void)isShowPauseImageView:(BOOL)isShow withState:(NSInteger)stateCode{
    if (isShow) {
        self.pauseImage.hidden = NO;
        if (stateCode == 1) {
            self.pauseImage.image = [UIImage imageNamed:@"icon_playPlay"];
        }else if(stateCode == 2){
            self.pauseImage.image = [UIImage imageNamed:@"icon_playPause"];
        }
    }else{
        self.pauseImage.hidden = YES;
    }
}
#pragma 进度条
-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]init];
        [self.playerController.view addSubview:_slider];
        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.playerController.view.mas_left).offset(0);
            make.right.equalTo(self.playerController.view.mas_right).offset(0);
            make.bottom.equalTo(self.playerController.view.mas_bottom).offset(-50);
            make.height.mas_equalTo(1);
        }];
    }
    return _slider;
}
#pragma 控制器 viewWillAppear
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerController prepareToPlay]; //自动播放
    [self createTime];
    [self addObserver];
}
#pragma 控制器 viewDidDisappear
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.navigationController.delegate = nil;
    [self.playerController stop];
    [self.playerController shutdown];
    [self removeObserver];
    [self deallocTimer];
}
#pragma 添加通知
-(void)addObserver{
    //1. 添加用户改变播放状态改变时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackStateDidChange:) name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:self.playerController];
    //2.  当网络加载状态发生变化时
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playLoadStateDidChange:) name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.playerController];
}
-(void)removeObserver{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerPlaybackStateDidChangeNotification object:self.playerController];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:IJKMPMoviePlayerLoadStateDidChangeNotification object:self.playerController];
}
//播放状态改变时
- (void) playbackStateDidChange:(NSNotification *) notification {
    switch (self.playerController.playbackState) {
        case IJKMPMoviePlaybackStateStopped:
            NSLog(@"停止");
            [self isShowPauseImageView:YES withState:3];
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
//    AVPlayer
//    //对于1分钟以内的视频就每1/30秒刷新一次页面，大于1分钟的每秒一次就行
//    CMTime interval = self.model.duration > 60 ? CMTimeMake(1, 1) : CMTimeMake(1, 30);
//    //这个方法就是每隔多久调用一次block，函数返回的id类型的对象在不使用时用-removeTimeObserver:释放，官方api是这样说的
//    _playerObserve = [self.playerController addPeriodicTimeObserverForInterval:interval queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
//        if(!weakSelf.isSliding){
//            CGFloat currentTime = CMTimeGetSeconds(time);
//            NSString *timeText = [NSString stringWithFormat:@"%@/%@", [weakSelf convert:currentTime], [weakSelf convert:weakSelf.duration]];
//            weakSelf.bottomView.timeLabel.text = timeText;
//
//            weakSelf.bottomView.slider.value = currentTime / weakSelf.duration;
//        }
//    }];
    
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
        //设置滑动条
        weakSelf.slider.value = weakSelf.playerController.currentPlaybackTime/weakSelf.playerController.duration;
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
-(void)deallocTimer{
    if(_timer){
        dispatch_source_cancel(_timer);
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
