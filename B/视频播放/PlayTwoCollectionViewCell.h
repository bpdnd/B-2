//
//  PlayTwoCollectionViewCell.h
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "PlayListModel.h"
#import "UIImage+Color.h"
#import "NSString+zh_SafeAccess.h"
@interface PlayTwoCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *totalDurationLabel;
@property(nonatomic,strong) PlayListModel *listModel;
@end
