//
//  PlayViewController.m
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBackBtn];
    self.view.backgroundColor = backVCColor;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.dataSource = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        Model *model = [[Model alloc]init];
        model.isOne = NO;
        if (i==0) {
            model.isOne = YES;
        }
        [self.dataSource addObject:model];
    }
    [self.collectionView reloadData];

}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        [_collectionView registerClass:[PlayOneCollectionViewCell class] forCellWithReuseIdentifier:@"oneCell"];
        [_collectionView registerClass:[PlayTwoCollectionViewCell class] forCellWithReuseIdentifier:@"twoCell"];
        [self.view addSubview:_collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.top.equalTo(self.view.mas_top).offset(0);
            make.right.equalTo(self.view.mas_right).offset(0);
            make.bottom.equalTo(self.view.mas_bottom).offset(0);
        }];
    }
    return _collectionView;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Model *model = [self.dataSource objectAtIndex:indexPath.row];
    if (model.isOne) {
        PlayOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oneCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        PlayTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twoCell" forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    Model *model = [self.dataSource objectAtIndex:indexPath.row];
    if (model.isOne) {
        return CGSizeMake(ScreenWidth-20, 200);
    }
    return CGSizeMake((ScreenWidth-30)/2, 200);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
