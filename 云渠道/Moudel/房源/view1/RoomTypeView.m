//
//  RoomTypeView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/10/9.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomTypeView.h"

#import "RoomTypeViewCollCell.h"
#import "RoomTypeCollHeader.h"

@interface RoomTypeView ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_selectArr;
}

@end

@implementation RoomTypeView

- (instancetype)initWithFrame:(CGRect)frame data:(nonnull NSArray *)data
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _selectArr = [NSMutableArray arrayWithArray:data];
        [self initUI];
    }
    return self;
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.roomTypeViewDoneBlock) {
        
        [[UserModel defaultModel].tagSelectArr removeAllObjects];
        for (NSArray *arr in _selectArr) {
            
            [[UserModel defaultModel].tagSelectArr addObject:[arr mutableCopy]];
        }
        [UserModelArchiver archive];
        self.roomTypeViewDoneBlock(_selectArr);
    }
    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

#pragma mark -- Collectionview

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return [self.dataArr[section][@"list"] count];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 40 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    RoomTypeCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomTypeCollHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[RoomTypeCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    }
    header.titleL.text = self.dataArr[indexPath.section][@"name"];
    
    return header;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    NSString *str = self.dataArr[indexPath.section][@"list"][indexPath.item][@"tag"];
    CGFloat width;
    if (12 *SIZE * str.length < 40 *SIZE) {

        width = 40 *SIZE;
    }else{

        width = 12 *SIZE * str.length;
    }
    return CGSizeMake(width + 10 *SIZE, 40 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    RoomTypeViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RoomTypeViewCollCell" forIndexPath:indexPath];
    if (!cell) {

        cell = [[RoomTypeViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 80 *SIZE, 40 *SIZE)];
    }
    cell.contentView.backgroundColor = YJBackColor;
    
    cell.titleL.text = self.dataArr[indexPath.section][@"list"][indexPath.item][@"tag"];
    if ([_selectArr[indexPath.section][indexPath.item] integerValue] == 1) {
        
        cell.titleL.textColor = YJBlueBtnColor;
//        cell.titleL.font = [UIFont systemFontOfSize:14 *SIZE];

    }else{
        
        cell.titleL.textColor = YJ86Color;
//        cell.titleL.font = [UIFont systemFontOfSize:12 *SIZE];

    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *tempArr = _selectArr[indexPath.section];
    if ([_selectArr[indexPath.section][indexPath.item] integerValue] == 1) {
        
        [tempArr replaceObjectAtIndex:indexPath.item withObject:@0];
    }else{
        
        [tempArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [_selectArr replaceObjectAtIndex:indexPath.section withObject:tempArr];
    [self.coll reloadData];
}

- (void)initUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake(10 *SIZE, 20 *SIZE + STATUS_BAR_HEIGHT, 31 *SIZE, 31 *SIZE);
    [_cancelBtn setImage:[UIImage imageNamed:@"delete_3"] forState:UIControlStateNormal];
    [_cancelBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_cancelBtn];
    
    _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _doneBtn.frame = CGRectMake(273 *SIZE, 15 *SIZE + STATUS_BAR_HEIGHT, 77 *SIZE, 30 *SIZE);
    _doneBtn.layer.cornerRadius = 2 *SIZE;
    _doneBtn.clipsToBounds = YES;
    _doneBtn.titleLabel.font = [UIFont systemFontOfSize:13 *SIZE];
    [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_doneBtn setBackgroundColor:YJBlueBtnColor];
    [_doneBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_doneBtn];
    
    self.flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.flowLayout.minimumInteritemSpacing = 5 *SIZE;
//    self.flowLayout.estimatedItemSize = CGSizeMake(80 *SIZE, 40 *SIZE);
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10 *SIZE, 10 *SIZE, 10 *SIZE, 10 *SIZE);
    
    self.coll = [[UICollectionView alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT + 55 *SIZE, SCREEN_Width, self.bounds.size.height - 55 *SIZE - STATUS_BAR_HEIGHT - TAB_BAR_MORE) collectionViewLayout:self.flowLayout];
    self.coll.backgroundColor = [UIColor whiteColor];
    self.coll.delegate = self;
    self.coll.dataSource = self;
    [self.coll registerClass:[RoomTypeViewCollCell class] forCellWithReuseIdentifier:@"RoomTypeViewCollCell"];
    [self.coll registerClass:[RoomTypeCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RoomTypeCollHeader"];
    [self addSubview:self.coll];
    
}

@end
