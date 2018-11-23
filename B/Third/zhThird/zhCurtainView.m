//
//  zhCurtainView.m
//  zhPopupControllerDemo
//
//  Created by zhanghao on 2016/12/27.
//  Copyright © 2017年 zhanghao. All rights reserved.
//

#import "zhCurtainView.h"

#define row_count 3 // 每行显示3个

@implementation zhCurtainView

- (instancetype)init {
    return  [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.size = CGSizeMake(35, 35);
        _closeButton.right = [UIScreen width] - 15;
        _closeButton.y = 30;
        [_closeButton addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeButton];
    }
    return self;
}

- (void)setItemSize:(CGSize)itemSize {
    _itemSize = itemSize;
}

- (void)setModels:(NSArray<zhImageButtonModel *> *)models {
  
    if (CGSizeEqualToSize(CGSizeZero, _itemSize)) {
        _itemSize = CGSizeMake(60, 90);
    }
    CGFloat _gap = 35;
    CGFloat _space = (self.width - row_count * _itemSize.width) / (row_count + 1);
    
    _items = [NSMutableArray arrayWithCapacity:models.count];
    [models enumerateObjectsUsingBlock:^(zhImageButtonModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger l = idx % row_count;
        NSInteger v = idx / row_count;
        
        zhImageButton *item = [zhImageButton buttonWithType:UIButtonTypeCustom];
        item.userInteractionEnabled = YES;
        [self addSubview:item];
        [self->_items addObject:item];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        [item setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [item setTitle:model.text forState:UIControlStateNormal];
        [item setImage:model.icon forState:UIControlStateNormal];
        [item imagePosition:zhImageButtonPositionTop spacing:10 imageViewResize:CGSizeMake(50, 50)];
        item.tag = idx;
        [item addTarget:self action:@selector(itemClicked:) forControlEvents:UIControlEventTouchUpInside];
        item.size = CGSizeMake(self->_itemSize.width, self->_itemSize.height + 20);
        item.x = _space + (self->_itemSize.width  + _space) * l;
        item.y = _gap + (self->_itemSize.height + _gap) * v + 45;
        if (idx == models.count - 1) {
            self.height = item.bottom + 20;
        }
    }];
}

- (void)close:(UIButton *)sender {
    if (nil != self.closeClicked) {
        self.closeClicked(sender);
    }
}

- (void)itemClicked:(zhImageButton *)button {
    if (nil != self.didClickItems) {
        self.didClickItems(self, button.tag);
    }
}

@end
