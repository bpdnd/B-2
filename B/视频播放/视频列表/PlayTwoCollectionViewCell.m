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
        self.totalDurationLabel.textColor = [UIColor blackColor];
        self.imageView.userInteractionEnabled = YES;
        
    }
    return self;
}
-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height/3*2)];
        //_imageView.contentMode = UIViewContentModeCenter;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:_imageView.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        UIView *maskView = [[UIView alloc]initWithFrame:_imageView.bounds];
        [maskView.layer addSublayer:layer];
        [_imageView addSubview:maskView];
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
-(void)setListModel:(PlayListModel *)listModel{
    if (listModel != nil) {
        
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                NSString *time = [NSString getVideoTime:listModel.videoUrl withisLocal:listModel.isLocal];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.totalDurationLabel.text = time;
                });
                
                //图片
                if (listModel.imageUrl.length != 0) {
                    [self.imageView sd_setImageWithURL: [NSURL URLWithString:listModel.imageUrl] placeholderImage:[UIImage imageNamed:@"icon_playListPL"]];
                }else{
                    UIImage *image = [UIImage getVideoPreViewImage:listModel.videoUrl withSecond:(listModel.videoSecondForImage.length==0? @"1": listModel.videoSecondForImage) withisLocal:listModel.isLocal];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.imageView.image = image;
                    });
                }
            });
        }
}

@end
