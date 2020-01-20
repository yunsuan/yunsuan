//
//  MaintainRoomInfoCell2.m
//  云渠道
//
//  Created by 谷治墙 on 2018/7/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MaintainRoomInfoCell2.h"

@interface MaintainRoomInfoCell2 ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_selfArr;;
    NSMutableArray *_tagArr;
}

@end

@implementation MaintainRoomInfoCell2

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
    
    _propertyArr = [@[] mutableCopy];
    _selfArr = [@[] mutableCopy];
    _tagArr = [@[] mutableCopy];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 2;
//    if (_tagArr.count) {
//
//        return 2;
//    }else if (!_propertyArr.count && !_tagArr.count){
//
//        return 0;
//    }else{
//
//        return 1;
//    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return _tagArr.count > 4 ? 4:_tagArr.count;
    }else{
        
        return _selfArr.count + _propertyArr.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 65 *SIZE, 17 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        
    }else{
        
        if (indexPath.item < _propertyArr.count + _selfArr.count) {
            
            if (indexPath.item < _propertyArr.count) {
                
                [cell setStyleByType:@"1" lab:_propertyArr[indexPath.item]];
            }else{
                
                [cell setStyleByType:@"1" lab:_selfArr[indexPath.item - _propertyArr.count]];
            }
        }
    }
    
    return cell;
}

- (void)SetData:(NSArray *)data{
    
    _propertyArr = [NSMutableArray arrayWithArray:data];
//    _tagArr = [NSMutableArray arrayWithArray:model.house_tags];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
}

- (void)SetSelfArr:(NSArray *)data{
    
    _selfArr = [NSMutableArray arrayWithArray:data];
    
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
}

- (void)initUI{
    
//    _tagView = [[TagView alloc] initWithFrame:CGRectMake(28 *SIZE, 17 *SIZE, SCREEN_Width - 28 *SIZE, 30 *SIZE) type:@"1"];
//    [self.contentView addSubview:_tagView];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 90 *SIZE, 340 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(18 *SIZE);
        make.width.mas_equalTo(SCREEN_Width - 28 *SIZE);
        //        make.height.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-31 *SIZE);
    }];
    
//    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(28 *SIZE);
//        make.top.equalTo(self.contentView).offset(18 *SIZE);
//        make.width.mas_equalTo(SCREEN_Width - 28 *SIZE);
//        make.height.mas_equalTo(30 *SIZE);
//        make.bottom.equalTo(self.contentView).offset(-31 *SIZE);
//    }];
}



@end
