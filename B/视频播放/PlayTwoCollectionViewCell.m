//
//  PlayTwoCollectionViewCell.m
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayTwoCollectionViewCell.h"

@implementation PlayTwoCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        self.label.text = @"111111111";
    }
    return self;
}
-(UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]init];
        [self addSubview:_label];
        [_label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(0);
            make.size.mas_equalTo(CGSizeMake(100, 40));
        }];
    }
    return _label;
}
-(void)drawRect:(CGRect)rect{
    
}
@end
