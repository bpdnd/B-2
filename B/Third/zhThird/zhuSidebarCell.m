//
//  zhuSidebarCell.m
//  Gao
//
//  Created by Admin on 2018/10/25.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "zhuSidebarCell.h"

@implementation zhuSidebarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cuImageView.backgroundColor = [UIColor clearColor];
        self.cuLabel.textColor = [UIColor colorWithRed:90/255.0 green:171/255.0 blue:90/255.0 alpha:1];
    }
    return self;
}
-(UIImageView *)cuImageView{
    if(!_cuImageView){
        _cuImageView = [[UIImageView alloc]init];
        _cuImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:_cuImageView];
        [_cuImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.centerY.equalTo(self.mas_centerY).offset(0);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _cuImageView;
}
-(UILabel *)cuLabel{
    if (!_cuLabel) {
        _cuLabel = [[UILabel alloc] init];
        [self addSubview:_cuLabel];
        [_cuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.cuImageView.mas_right).offset(20);
            make.top.equalTo(self.mas_top).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
        }];
    }
    return _cuLabel;
}

@end
