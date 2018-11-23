//
//  zhSidebarView.m
//  zhPopupControllerDemo
//
//  Created by zhanghao on 2016/12/27.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "zhSidebarView.h"

@interface zhSidebarView ()

@property (nonatomic, strong) zhImageButton *settingItem;
@property (nonatomic, strong) zhImageButton *nightItem;

@end

@implementation zhSidebarView

- (instancetype)init {
    if (self = [super init]) {
        
        _settingItem = [self itemWithText:@"设置" imageNamed:@"icon_set"];
        _settingItem.tag = 100;
        [_settingItem addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_settingItem];
        
        _nightItem = [self itemWithText:@"退出" imageNamed:@"icon_unLogin"];
        _nightItem.tag = 101;
        [_nightItem addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_nightItem];
        self.waveView.nameLabel.textColor = [UIColor colorWithRed:90/255.0 green:171/255.0 blue:90/255.0 alpha:1];
        self.tableView.backgroundColor = [UIColor clearColor];
    }
    return self;
}
- (zhImageButton *)itemWithText:(NSString *)text imageNamed:(NSString *)imageNamed {
    zhImageButton *item = [zhImageButton buttonWithType:UIButtonTypeCustom];
    item.userInteractionEnabled = YES;
    item.exclusiveTouch = YES;
    item.titleLabel.font = [UIFont systemFontOfSize:13];
    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    item.size = CGSizeMake(60, 60);
    //[item setBackgroundColor:[UIColor whiteColor]];
    item.bottom = [UIScreen height] - 20 - zh_safeAreaHeight();
    item.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [item setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    [item setTitle:text forState:UIControlStateNormal];
    [item imagePosition:zhImageButtonPositionTop spacing:10 imageViewResize:CGSizeMake(30, 30)];
    return item;
}
#pragma 头视图
//-(zhuSidebarHeadView *)headView{
//    if (!_headView) {
//        _headView = [[zhuSidebarHeadView alloc]init];
//        _headView.delegate = self;
//        [self addSubview:_headView];
//        [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.mas_left).offset(0);
//            make.top.equalTo(self.mas_top).offset(40);
//            make.right.equalTo(self.mas_right).offset(0);
//            make.height.mas_equalTo(150);
//        }];
//    }
//    return _headView;
//}
-(GLWaveView *)waveView{
        if (!_waveView) {
            _waveView = [[GLWaveView alloc]initWithFrame:CGRectMake(0, 20, [UIScreen width] - 100, 150)];
            _waveView.backgroundColor = [UIColor colorWithRed:255/255.0 green:153/255.0  blue:51/255.0 alpha:0.5];
            _waveView.delegate = self;
            /*
            GLWave *waveA = [GLWave defaultWave];
            waveA.zPosition = -1;
            waveA.offsetX = 100;
            waveA.offsetY = 140;
            waveA.height  = 10;
            waveA.width   = 550;
            waveA.speedX  = 6;
            waveA.fillColor = [UIColor colorWithRed:255/255.0 green:153/255.0  blue:51/255.0 alpha:0.5].CGColor;
            
            GLWave *waveB = [GLWave defaultWave];
            waveB.zPosition = -1;
            waveB.offsetX = 300;
            waveB.offsetY = 145;
            waveB.height  = 5;
            waveB.width   = 750;
            waveB.speedX  = 9;
            waveB.fillColor = [UIColor colorWithRed:255/255.0 green:242/255.0 blue:225/255.0 alpha:1].CGColor;
            
            [_waveView addWave:waveB];
            [_waveView addWave:waveA];
             */
            [self addSubview:_waveView];
        }
        return _waveView;
}




#pragma tableView 懒加载
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.top.equalTo(self.mas_top).offset(190);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(-90);
        }];
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.models.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *sideCellId = @"sideCellId";
    zhuSidebarCell *cell = [tableView dequeueReusableCellWithIdentifier:sideCellId];
    if (cell==nil) {
        cell = [[zhuSidebarCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sideCellId];
    }
    cell.backgroundColor = [UIColor clearColor];
    if (self.models.count != 0) {
        cell.cuLabel.text = [[[NSString stringWithFormat:@"%@",[self.models objectAtIndex:indexPath.row]] componentsSeparatedByString:@"_"] firstObject];
        //cell.cuImageView.image = [UIImage imageNamed:[[[NSString stringWithFormat:@"%@",[self.models objectAtIndex:indexPath.row]] componentsSeparatedByString:@"_"] objectAtIndex:2]];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.waveView stopWaveAnimate];
    self.didClickItems([self.models objectAtIndex:indexPath.row], indexPath.row);
}
-(void)GLWaveViewDidSelect{
    [self.waveView stopWaveAnimate];
    self.didClickItems(@"头视图",0);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _settingItem.x =  50;
    _nightItem.right = self.width - 50;
}
/*
- (void)setModels:(NSArray<NSString *> *)models {
    _items = @[].mutableCopy;
    CGFloat _gap = 15;
    [models enumerateObjectsUsingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        
        zhImageButton *item = [zhImageButton buttonWithType:UIButtonTypeCustom];
        item.userInteractionEnabled = YES;
        item.exclusiveTouch = YES;
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.imageView.contentMode = UIViewContentModeCenter;
        [item setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        item.imageView.contentMode = UIViewContentModeScaleAspectFit;
        NSString *imageNamed;
        if ([text containsString:@"_"]) {
            NSArray *textArr = [text componentsSeparatedByString:@"_"];
            imageNamed = [NSString stringWithFormat:@"sidebar_%@",[textArr firstObject]];
        }else{
            imageNamed = [NSString stringWithFormat:@"sidebar_%@", text];
        }
        [item setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
        [item setTitle:text forState:UIControlStateNormal];
        item.size = CGSizeMake(150, 40);
        [item setBackgroundColor:[UIColor blueColor]];
        item.y = (_gap + item.height) * idx + 50;
        item.centerX = self.width / 2;
        [item imagePosition:zhImageButtonPositionLeft spacing:25 imageViewResize:CGSizeMake(25, 25)];
        [self addSubview:item];
        [self->_items addObject:item];
        item.tag = idx;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }];
}
*/
- (void)itemClicked:(zhImageButton *)sender {
    if (nil != self.didClickItems) {
        self.didClickItems(nil, sender.tag);
    }
}

@end
