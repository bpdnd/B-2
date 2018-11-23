//
//  PlayOneCollectionViewCell.m
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayOneCollectionViewCell.h"

@implementation PlayOneCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:8];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.path = path.CGPath;
        layer.fillColor = [UIColor whiteColor].CGColor;
        layer.strokeColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:layer];
    }
    return self;
}
@end
