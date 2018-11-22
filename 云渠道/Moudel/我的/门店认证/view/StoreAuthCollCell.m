//
//  StoreAuthCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "StoreAuthCollCell.h"

#import "CompleteSurveyCollCell.h"

@interface StoreAuthCollCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSMutableArray *_roleArr;
}

@end

@implementation StoreAuthCollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _roleArr = [@[] mutableCopy];
    self.selectArr = [@[] mutableCopy];
}

- (void)setDataArr:(NSMutableArray *)dataArr{
    
    _roleArr = dataArr;
    for (int i = 0; i < dataArr.count; i++) {
        
        [self.selectArr addObject:@(0)];
    }
    [_coll reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _roleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
    }
    
    [cell setIsSelect:[self.selectArr[indexPath.item] integerValue]];
    cell.titleL.text = _roleArr[indexPath.row][@"param"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.selectArr[indexPath.item] integerValue]) {
        
        [self.selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [self.selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 22 *SIZE, 80 *SIZE, 13 *SIZE)];
    label.textColor = YJTitleLabColor;
    label.font = [UIFont systemFontOfSize:13 *SIZE];
    label.text = @"申请权限：";
    [self.contentView addSubview:label];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.itemSize = CGSizeMake(110 *SIZE, 30 *SIZE);
    
    _coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 *SIZE, 280 *SIZE, 70 *SIZE) collectionViewLayout:_flowLayout];
    _coll.backgroundColor = [UIColor whiteColor];
    _coll.delegate = self;
    _coll.dataSource = self;
    
    [_coll registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [self.contentView addSubview:_coll];
    
    [_coll mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
        make.height.mas_equalTo(_coll.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
