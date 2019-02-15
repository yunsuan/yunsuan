//
//  ContractDetailMainContractVC.m
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ContractDetailMainContractVC.h"

#import "MainContractCell.h"

@interface ContractDetailMainContractVC ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_dataArr;
}

@property (nonatomic, strong) UICollectionView *coll;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation ContractDetailMainContractVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _dataArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MainContractCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainContractCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MainContractCell alloc] initWithFrame:CGRectMake(0, 0, 110 *SIZE, 100 *SIZE)];
    }
    
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)initUI{
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(110 *SIZE, 100 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NAVIGATION_BAR_HEIGHT, SCREEN_Width, SCREEN_Height - NAVIGATION_BAR_HEIGHT - 40 *SIZE - TAB_BAR_MORE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = YJBackColor;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[MainContractCell class] forCellWithReuseIdentifier:@"MainContractCell"];
    [self.view addSubview:_coll];
}

@end
