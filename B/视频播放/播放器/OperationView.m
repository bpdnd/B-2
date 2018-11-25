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
        [self.stopButton setBackgroundColor:[UIColor redColor]];
        self.timeLabel.textColor = [UIColor whiteColor];
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
-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        [self addSubview:_timeLabel];
        [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.stopButton.mas_right).offset(10);
            make.top.equalTo(self.mas_top).offset(5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
        }];
    }
    return _timeLabel;
}
@end
