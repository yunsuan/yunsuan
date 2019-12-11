//
//  StoreAuthCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "StoreAuthCollCell.h"

#import "CompleteSurveyCollCell.h"

@interface StoreAuthCollCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_selectArr;
    NSMutableArray *_roleArr;
}
@end

@implementation StoreAuthCollCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _roleArr = [[NSMutableArray alloc] initWithArray:dataArr[0]];
    _selectArr = [[NSMutableArray alloc] initWithArray:dataArr[1]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _roleArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CompleteSurveyCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CompleteSurveyCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[CompleteSurveyCollCell alloc] initWithFrame:CGRectMake(0, 0, 120 *SIZE, 30 *SIZE)];
    }
    
    [cell setIsSelect:[_selectArr[indexPath.item] integerValue]];
    cell.titleL.text = _roleArr[indexPath.row][@"param"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_selectArr[indexPath.item] integerValue]) {
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [_selectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
}

- (void)initUI{
    
    _roleTL = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE , 18 *SIZE, 70 *SIZE, 12 *SIZE)];
    _roleTL.textColor = YJTitleLabColor;
    _roleTL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roleTL.text = @"申请权限";
    [self.contentView addSubview:_roleTL];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 20 *SIZE;
    _flowLayout.minimumInteritemSpacing = 0 *SIZE;
    _flowLayout.itemSize = CGSizeMake(110 *SIZE, 30 *SIZE);
    
    _roleColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 20 *SIZE, 280 *SIZE, 70 *SIZE) collectionViewLayout:_flowLayout];
    _roleColl.backgroundColor = [UIColor whiteColor];
    _roleColl.delegate = self;
    _roleColl.dataSource = self;
    
    [_roleColl registerClass:[CompleteSurveyCollCell class] forCellWithReuseIdentifier:@"CompleteSurveyCollCell"];
    [self.contentView addSubview:_roleColl];
    
    [_roleColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(80 *SIZE);
        make.top.equalTo(self.contentView).offset(20 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
        make.height.mas_equalTo(_roleColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-20 *SIZE);
    }];
}

@end
