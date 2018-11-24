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
    self.options = [[IJKFFOptions alloc]init];
    self.playerController = [[IJKFFMoviePlayerController alloc]initWithContentURLString:self.videoUrl withOptions:self.options];
    self.playerController.view.frame = CGRectMake(0, 0,ScreenWidth , 300);
    self.playerController.shouldAutoplay = true;
    [self.view addSubview:self.playerController.view];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.playerController prepareToPlay];
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
