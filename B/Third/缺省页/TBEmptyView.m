//
//  TBEmptyView.m
//  TBScrollViewEmpty
//
//  Created by hanchuangkeji on 2018/1/18.
//  Copyright © 2018年 hanchuangkeji. All rights reserved.
//

#import "TBEmptyView.h"

#define imageTopName @"icon_dateEmpty"

#define imageTopNetName @"tb_network"

#define titleString @"暂时无数据"

#define titleNetString @"无法访问网络"

#define detailString @"暂时找不到任何与此相关的数据哦，请稍后再试吧~"

#define detailNetDetailString @"请检查网络设置，并允许本App访问网络数据"

#define titleForBtn @"重试"

#define titleColor [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0]

#define detailColor [UIColor colorWithRed:153 / 255.0 green:153 / 255.0 blue:153 / 255.0 alpha:1.0]

#define btnBgColor [UIColor colorWithRed:249 / 255.0 green:213 / 255.0 blue:72 / 255.0 alpha:1.0]

#define btnTitleColor [UIColor colorWithRed:53 / 255.0 green:126 / 255.0 blue:222 / 255.0 alpha:1.0]

#define titleFont [UIFont systemFontOfSize:14.0]

#define detailFont [UIFont systemFontOfSize:12.0]

#define btnTitleFont [UIFont systemFontOfSize:16.0]

@interface TBEmptyView()

@property (nonatomic, weak)UIImageView *imageViewTop; // 图片

@property (nonatomic, weak)UILabel *titleLB; // 标题

@property (nonatomic, weak)UILabel *detailLB; // 详情

@property (nonatomic, weak)UIButton *button; // 按钮

@property (nonatomic, assign)CGFloat totalHeight;

@property (nonatomic, assign)CGFloat padding; // 左边边距

@property (nonatomic, assign)CGFloat paddingTop; // 上下边距

@end

@implementation TBEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.padding = frame.size.width * 0.1;
        self.paddingTop = frame.size.width * 0.05;
        
        // 防止过大或者过小
        if (self.padding > 50 || self.padding < 5) {
            self.padding = 10;
        }
    }
    return self;
}

- (void)setTotalHeight:(CGFloat)totalHeight {
    _totalHeight = totalHeight;
    // 调整高度和Y
    CGRect frameTemp = self.frame;
    frameTemp.size.height = totalHeight;
    frameTemp.origin.y = (CGRectGetHeight(self.superview.frame) - totalHeight ) * 0.35;
    self.frame = frameTemp;
}

- (UIImageView *)imageViewTop {
    if (_imageViewTop == nil) {
        UIImageView *imageViewTop = [[UIImageView alloc] init];
        [self addSubview:imageViewTop];
        _imageViewTop = imageViewTop;
    }
    return _imageViewTop;
}

- (UILabel *)titleLB {
    if (_titleLB == nil) {
        UILabel *titleLB = [[UILabel alloc] init];
        titleLB.numberOfLines = 0;
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.font = titleFont;
        titleLB.textColor = titleColor;
        [self addSubview:titleLB];
        _titleLB = titleLB;
    }
    return _titleLB;
}

- (UILabel *)detailLB {
    if (_detailLB == nil) {
        UILabel *detailLB = [[UILabel alloc] init];
        detailLB.numberOfLines = 0;
        detailLB.textAlignment = NSTextAlignmentCenter;
        detailLB.font = detailFont;
        detailLB.textColor = detailColor;
        [self addSubview:detailLB];
        _detailLB = detailLB;
    }
    return _detailLB;
}

- (UIButton *)button {
    if (_button == nil) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.titleLabel.font = btnTitleFont;
        button.backgroundColor = btnBgColor;
        button.clipsToBounds = YES;
        [button setTitle:titleForBtn forState:UIControlStateNormal];
        [button setTitleColor:btnTitleColor forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        _button = button;
    }
    return _button;
}

- (void)btnClickEvent:(UIButton *)btn {
    
    // 转圈圈
    if (self.imageViewTop.image) {
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [loadingView startAnimating];
        loadingView.center = self.imageViewTop.center;
        self.imageViewTop.hidden = YES;
        [self addSubview:loadingView];
    }
    
    if ([self.delegate respondsToSelector:@selector(btnClick:)]) {
        [self.delegate btnClick:btn];
    }
}

- (void)setImageView:(UIImage *)image network:(TBNetworkStatus)status isShow:(BOOL)show {
    if (!show) return;
    
    self.imageViewTop.image = image? image : status == TBNetworkStatusNotReachable? [UIImage imageNamed:imageTopNetName] : [UIImage imageNamed:imageTopName];
    CGSize size = self.imageViewTop.image.size;
    CGFloat x = (self.frame.size.width - size.width) * 0.5;
    CGFloat y = 0;
    CGRect frame = CGRectMake(x, y, size.width, size.height);
    self.imageViewTop.frame = frame;
    
    // 更新总高度
    self.totalHeight = CGRectGetMaxY(frame);
}

- (void)setTitltString:(NSAttributedString *)attrString network:(TBNetworkStatus)status isShow:(BOOL)show {
    if (!show) return;
    
    NSAttributedString *tempString = attrString? attrString : status == TBNetworkStatusNotReachable? [[NSMutableAttributedString alloc] initWithString:titleNetString attributes:@{NSFontAttributeName : titleFont}] : [[NSMutableAttributedString alloc] initWithString:titleString attributes:@{NSFontAttributeName : titleFont}];
    self.titleLB.attributedText = tempString;
    NSRange range = NSMakeRange(0, tempString.string.length);
    NSDictionary *dic = [tempString attributesAtIndex:0 effectiveRange:&range];
    // 计算文字的高度
    CGFloat maxWidth = CGRectGetWidth(self.frame) - 2 * self.padding;
    CGFloat stringHeight = [tempString.string boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height + 0.5;
    
    CGRect frame = CGRectMake(self.padding, self.totalHeight + self.paddingTop, maxWidth, stringHeight);
    self.titleLB.frame = frame;
    
    // 更新总高度
    self.totalHeight = CGRectGetMaxY(frame);
}

- (void)setDetailString:(NSAttributedString *)attrString network:(TBNetworkStatus)status isShow:(BOOL)show {
    if (!show) return;
    
    NSAttributedString *stringTemp = attrString? attrString : status == TBNetworkStatusNotReachable? [[NSMutableAttributedString alloc] initWithString:detailNetDetailString attributes:@{NSFontAttributeName : detailFont}] : [[NSMutableAttributedString alloc] initWithString:detailString attributes:@{NSFontAttributeName : detailFont}];
    
    self.detailLB.attributedText = stringTemp;
    NSRange range = NSMakeRange(0, stringTemp.string.length);
    NSDictionary *dic = [stringTemp attributesAtIndex:0 effectiveRange:&range];
    // 计算文字的高度
    CGFloat maxWidth = CGRectGetWidth(self.frame) - 2 * self.padding;
    CGFloat stringHeight = [stringTemp.string boundingRectWithSize:CGSizeMake(maxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size.height + 0.5;
    
    CGRect frame = CGRectMake(self.padding, self.totalHeight + self.paddingTop, maxWidth, stringHeight);
    self.detailLB.frame = frame;
    
    // 更新总高度
    self.totalHeight = CGRectGetMaxY(frame);
}

- (void)setButonTitle:(NSAttributedString *)titleAttrString network:(TBNetworkStatus)status isShow:(BOOL)show {
    
    if (!show) return;
    
    if (titleAttrString) {
        [self.button setAttributedTitle:titleAttrString forState:UIControlStateNormal];
    }
    
    [self.button sizeToFit];
    self.button.frame = CGRectMake(0, 0, self.button.frame.size.width + 60, self.button.frame.size.height + 6.0);
    self.button.center = CGPointMake(CGRectGetMidX(self.frame), self.totalHeight + self.paddingTop * 2.0 + self.button.frame.size.height * 0.5);
    self.button.layer.cornerRadius = self.button.frame.size.height / 2.0;
    
    // 更新总高度
    self.totalHeight = CGRectGetMaxY(self.button.frame);
    self.totalHeight = CGRectGetMaxY(self.button.frame);
}

@end

