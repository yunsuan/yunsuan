//
//  CompleteSurveyStoreCollView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompleteSurveyStoreCollView.h"

#import "StoreViewCollCell.h"

@interface CompleteSurveyStoreCollView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation CompleteSurveyStoreCollView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.dataArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    StoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[StoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 72 *SIZE, 60 *SIZE)];
    }
    cell.typeImg.image = [UIImage imageNamed:@"commission_2"];
    cell.titleL.text = @"上下水";
    
    return cell;
}

- (void)initUI{
    
    _titleView = [[BlueTitleMoreHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _titleView.titleL.text = @"配套设施";
    [_titleView.moreBtn setTitle:@"" forState:UIControlStateNormal];
    [_titleView.moreBtn setImage:[UIImage imageNamed:@"add_40"] forState:UIControlStateNormal];
    [self addSubview:_titleView];
    
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.estimatedItemSize = CGSizeMake(72 *SIZE, 60 *SIZE);
    _layout.minimumLineSpacing = 20 *SIZE;
    _layout.minimumInteritemSpacing = 0;
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 100 *SIZE) collectionViewLayout:_layout];
    _coll.backgroundColor = CH_COLOR_white;
    _coll.allowsMultipleSelection = YES;
    _coll.delegate = self;
    _coll.dataSource = self;
    [_coll registerClass:[StoreViewCollCell class] forCellWithReuseIdentifier:@"StoreViewCollCell"];
    [self addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(0 *SIZE);
        make.top.equalTo(self).offset(40 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
        make.bottom.equalTo(self.mas_bottom).offset(0 *SIZE);
    }];

}

@end
