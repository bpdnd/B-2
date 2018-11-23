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
        self.clipsToBounds = YES;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
        self.imageView.backgroundColor = [UIColor clearColor];
        self.totalDurationLabel.text = @"12:20";
        self.totalDurationLabel.textColor = [UIColor blackColor];
    }
    return self;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/3*2)];
        [_imageView sd_setImageWithURL: [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1542976518583&di=1666fff5fee7cae52efaad784fa90b24&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fimgad%2Fpic%2Fitem%2F32fa828ba61ea8d3d8d6c33f9c0a304e251f5810.jpg"]];
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        _imageView.layer.masksToBounds = YES;
        [_imageView.layer addSublayer:layer];
        [self addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)totalDurationLabel{
    if (!_totalDurationLabel) {
        _totalDurationLabel = [[UILabel alloc] init];
        _totalDurationLabel.textAlignment = NSTextAlignmentRight;
        _totalDurationLabel.font = [UIFont systemFontOfSize:13];
        [self.imageView addSubview:_totalDurationLabel];
        [_totalDurationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.imageView.mas_right).offset(-5);
            make.bottom.equalTo(self.imageView.mas_bottom).offset(-5);
            make.height.mas_equalTo(20);
            make.width.mas_equalTo(50);
        }];
    }
    return _totalDurationLabel;
}

@end
