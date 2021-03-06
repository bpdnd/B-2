//
//  PlayViewController.h
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "PlayOneCollectionViewCell.h"
#import "PlayTwoCollectionViewCell.h"
#import "PlayListModel.h"
#import "PlayViewController.h"

@interface PlayListViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) NSMutableArray *dataSource;
@end
