//
//  GLWaveView.m
//  GLWaveView
//
//  Created by GrayLand on 17/3/7.
//  Copyright © 2017年 GrayLand. All rights reserved.
//

#import "GLWaveView.h"

@interface GLWaveView()

@property (nonatomic, strong) CADisplayLink *displayLink;

@end

@implementation GLWaveView

@synthesize waves = _waves;

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.backgroundColor = [UIColor clearColor];
        self.nameLabel.adjustsFontSizeToFitWidth = YES;
        //添加点击手势
        UITapGestureRecognizer *click = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickAction)];
        //点击几次后触发事件响应，默认为：1
        click.numberOfTapsRequired = 1;
        //需要几个手指点击时触发事件，默认：1
        click.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:click];
    }
    return self;
}
#pragma 手势
-(void)clickAction{
    [self.delegate GLWaveViewDidSelect];
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = 40;
        [self addSubview:_imageView];
        [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX).offset(0);
            make.centerY.equalTo(self.mas_centerY).offset(-20);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
    }
    return _imageView;
}
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel =[[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.imageView.mas_bottom).offset(10);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-10);
        }];
    }
    return _nameLabel;
}





#pragma mark - Getter

- (NSMutableArray <CAShapeLayer *> *)waves {
    
    if (!_waves) {
        _waves = [NSMutableArray array];
    }
    
    return _waves;
}

- (CADisplayLink *)displayLink {
    
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(onDisplayFrameUpadte:)];
    }
    
    return _displayLink;
}

#pragma mark - Public
- (void)startWaveAnimate {
    
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stopWaveAnimate {
    
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
}


/**
 *  添加波形
 *
 *  @param wave
 */
- (void)addWave:(GLWave *)wave {
    
    [self.waves addObject:wave];
    [self.layer addSublayer:wave];
}

- (void)removeAllWaves {
    
    [self.waves performSelector:@selector(removeFromSuperlayer)];
    [self.waves removeAllObjects];
}

#pragma mark - Private

- (void)drawWave:(GLWave *)wave {
    
    CGFloat width = self.bounds.size.width;
    CGFloat t     = M_PI * 2 / wave.width;
    CGFloat y     = 0;
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for (CGFloat x = 0; x < width; x++) {
        
        y = wave.height * sin(t * x + wave.offsetX * t) + wave.offsetY;
        
        if (x == 0) {
            CGPathMoveToPoint(path, NULL, x, y);
            continue;
        }
        
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    //CGPathAddLineToPoint(path, NULL, width, self.bounds.size.height);
    //CGPathAddLineToPoint(path, NULL, 0, self.bounds.size.height); 下方填充颜色
    
    CGPathAddLineToPoint(path, NULL, width, 0);
    CGPathAddLineToPoint(path, NULL, 0, 0); //上方填充颜色
    
    CGPathCloseSubpath(path);
    
    wave.path = path;
    
    CGPathRelease(path);
}

#pragma mark - onEvent

- (void)onDisplayFrameUpadte:(CADisplayLink *)sender {
    
    if (_willUpdateBlock) {
        _willUpdateBlock(self);
    }
    
    for (GLWave *wave in self.waves) {
        [self drawWave:wave];
        
        wave.offsetX += wave.speedX;
    }
    
    
}

@end
