//
//  PlayViewController.m
//  B
//
//  Created by Admin on 2018/11/23.
//  Copyright © 2018年 Admin. All rights reserved.
//

#import "PlayListViewController.h"

@interface PlayListViewController ()

@end

@implementation PlayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changeBackBtn];
    self.view.backgroundColor = backVCColor;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.dataSource = [NSMutableArray array];
    
    //http://39.106.46.224:8085/HE/1.mp4
    for (int i=0; i<5; i++) {
        PlayListModel *model = [[PlayListModel alloc]init];
        model.isScroll = NO;
        model.videoUrl = @"http://39.106.46.224:8085/HE/1.mp4";
        model.videoSecondForImage = @"5";
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
    
    PlayListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (model.isScroll) {
        PlayOneCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"oneCell" forIndexPath:indexPath];
        
        return cell;
    }else{
        PlayTwoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"twoCell" forIndexPath:indexPath];
        cell.listModel = model;
        return cell;
    }
    
    return nil;
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    PlayListModel *model = [self.dataSource objectAtIndex:indexPath.row];
    if (model.isScroll) {
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row <=self.dataSource.count-1) {
        PlayListModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        PlayViewController *playVC = [[PlayViewController alloc] init];
        playVC.videoUrl = model.videoUrl;
        [self.navigationController pushViewController:playVC animated:YES];
    }
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
