//
//  OperationView.m
//  B
//
//  Created by Admin on 2018/11/25.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "OperationView.h"

@implementation OperationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 */
- (void)drawRect:(CGRect)rect {
    
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        //设置渐变颜色
        CAGradientLayer *gradientLayer =  [CAGradientLayer layer];
        gradientLayer.frame = CGRectMake(0, 0, ScreenWidth, 30);
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:1 alpha:0.3] CGColor],(id)[UIColorHex(#D3D3D3) CGColor],(id)[UIColorHex(#A9A9A9)  CGColor], nil]];
        [self.layer addSublayer:gradientLayer];
        [self.stopButton setImage:[UIImage imageNamed:@"icon_playPause"] forState:UIControlStateNormal];
        [self.changButton setBackgroundColor:[UIColor redColor]];
        
        self.timeLabel.textColor = [UIColor whiteColor];
        
        self.slider.continuous = YES;
    }
    return self;
}
-(UIButton *)stopButton{
    if (!_stopButton) {
        _stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_stopButton];
        [_stopButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.mas_equalTo(30);
        }];
    }
    return _stopButton;
}

-(UIButton *)changButton{
    if (!_changButton) {
        _changButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:_changButton];
        [_changButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-10);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.mas_equalTo(25);
        }];
    }
    return _changButton;
}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.changButton.mas_left).offset(-10);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.width.mas_equalTo(45);
        }];
    }
    return _timeLabel;
}
-(UISlider *)slider{
    if (!_slider) {
        _slider = [[UISlider alloc]initWithFrame:CGRectMake(40, 0, 200, 30)];
        [self addSubview:_slider];
//        [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.stopButton.mas_right).offset(10);
//            make.centerY.equalTo(self.mas_centerY).offset(0);
//            make.right.equalTo(self.timeLabel.mas_left).offset(-10);
//            make.height.mas_equalTo(30);
//        }];
    }
    return _slider;
}
-(void)changeStopImageWithBOOL:(BOOL)isPlay{
    if (isPlay) {
        [self.stopButton setImage:[UIImage imageNamed:@"icon_playPause"] forState:UIControlStateNormal];
    }else{
        [self.stopButton setImage:[UIImage imageNamed:@"icon_playPlay"] forState:UIControlStateNormal];
    }
}
-(void)changeSlider:(float)currentTime withDurationTime:(float)duration{
    //设置滑动条
    self.slider.minimumValue = 0;
    self.slider.maximumValue = duration;
    self.slider.value = currentTime;
    
}
@end
