//
//  MoreView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "MoreView.h"
#import "MoreViewCollCell.h"
#import "MoreViewCollHeader.h"

@interface MoreView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    
}

@property (nonatomic, strong) NSMutableArray *tagArr;

@property (nonatomic, strong) NSMutableArray *houseTypeArr;

@property (nonatomic, strong) NSMutableArray *statusArr;

@property (nonatomic, strong) NSString *tagId;

@property (nonatomic, strong) NSString *houseId;

@property (nonatomic, strong) NSString *statusId;

@end

@implementation MoreView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.numOfSec = 3;
        [self initUI];
    }
    return self;
}

- (NSMutableArray *)tagArr{
    
    if (!_tagArr) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",15]];
        _tagArr = [NSMutableArray arrayWithArray:dic[@"param"]];
    }
    return _tagArr;
}

- (NSMutableArray *)tagSelectArr{
    
    if (!_tagSelectArr) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",15]];
        _tagSelectArr = [NSMutableArray arrayWithArray:dic[@"param"]];
        [_tagSelectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [_tagSelectArr replaceObjectAtIndex:idx withObject:@0];
        }];
    }
    return _tagSelectArr;
}

- (NSMutableArray *)houseTypeArr{
    
    if (!_houseTypeArr) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",9]];
        _houseTypeArr = [NSMutableArray arrayWithArray:dic[@"param"]];
    }
    return _houseTypeArr;
}

- (NSMutableArray *)houseSelectArr{
    
    if (!_houseSelectArr) {
        
        NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
        NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",9]];
        _houseSelectArr = [NSMutableArray arrayWithArray:dic[@"param"]];
        
        [_houseSelectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [_houseSelectArr replaceObjectAtIndex:idx withObject:@0];
        }];
    }
    return _houseSelectArr;
}

- (NSMutableArray *)statusArr{
    
    if (!_statusArr) {
        
        _statusArr = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    }
    return _statusArr;
}

- (NSMutableArray *)statusSelectArr{
    
    if (!_statusSelectArr) {
        
        _statusSelectArr = [NSMutableArray arrayWithArray:@[@0,@0,@0]];
    }
    return _statusSelectArr;
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.moreBtnBlock) {

        __weak __typeof(&*self)weakSelf = self;
        [_tagArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([_tagSelectArr[idx] integerValue] == 1) {
                
                weakSelf.tagId = _tagArr[idx][@"id"];
            }
        }];
        
        [_houseTypeArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([_houseSelectArr[idx] integerValue] == 1) {
                
                weakSelf.houseId = _houseTypeArr[idx][@"id"];
            }
        }];
        
        [_statusArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([_statusSelectArr[idx] integerValue] == 1) {
                
                weakSelf.statusId = _statusArr[idx][@"id"];
            }
        }];
        
        self.moreBtnBlock(self.tagId, self.houseId, self.statusId);
    }
    [self removeFromSuperview];
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    if (self.moreViewClearBlock) {
        
        self.moreViewClearBlock();
    }
    [self removeFromSuperview];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.numOfSec;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return self.tagArr.count;
    }else if (section == 1){
        
        return self.houseTypeArr.count;
    }else{
        
        return 3;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 35 *SIZE);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    MoreViewCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreViewCollHeader" forIndexPath:indexPath];
    if (!header) {
        
        header = [[MoreViewCollHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 35 *SIZE)];
    }
    
    if (indexPath.section == 0) {
        
        header.titleL.text = @"特色";
    }else if (indexPath.section == 1){
        
        header.titleL.text = @"房型";
    }else{
        
        header.titleL.text = @"售卖状态";
    }
    
    return header;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MoreViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MoreViewCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[MoreViewCollCell alloc] initWithFrame:CGRectMake(0, 0, 77 *SIZE, 30 *SIZE)];
    }
    
    cell.titleL.textColor = YJ86Color;
    cell.contentView.backgroundColor = COLOR(238, 238, 238, 1);
    cell.layer.borderWidth = 0;
    
    if (indexPath.section == 0) {
        
        cell.titleL.text = self.tagArr[indexPath.item][@"param"];
        if ([self.tagSelectArr[indexPath.item] integerValue]) {
            
            cell.contentView.backgroundColor = COLOR(133, 200, 255, 1);
            cell.titleL.textColor = [UIColor whiteColor];
        }else{
            
            cell.titleL.textColor = YJ86Color;
            cell.contentView.backgroundColor = COLOR(238, 238, 238, 1);
        }
    }
    if (indexPath.section == 1) {
        
        cell.titleL.text = self.houseTypeArr[indexPath.item][@"param"];
        if ([self.houseSelectArr[indexPath.item] integerValue]) {
            
            cell.contentView.backgroundColor = [UIColor whiteColor];
            cell.titleL.textColor = COLOR(133, 200, 255, 1);
            cell.layer.borderWidth = 1;
        }else{
            
            cell.titleL.textColor = YJ86Color;
            cell.contentView.backgroundColor = COLOR(238, 238, 238, 1);
        }
    }
    if (indexPath.section == 2) {
        
        if (indexPath.row == 0) {
            
            cell.titleL.text = @"在售";
        }
        if (indexPath.row == 1) {
            
            cell.titleL.text = @"待售";
        }
        if (indexPath.row == 2) {
            
            cell.titleL.text = @"售罄";
        }
        if ([self.statusSelectArr[indexPath.item] integerValue]) {
            
            cell.contentView.backgroundColor = COLOR(133, 200, 255, 1);
            cell.titleL.textColor = [UIColor whiteColor];
        }else{
            
            cell.titleL.textColor = YJ86Color;
            cell.contentView.backgroundColor = COLOR(238, 238, 238, 1);
        }
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        [_tagSelectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [_tagSelectArr replaceObjectAtIndex:idx withObject:@0];
        }];
        
        [_tagSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    
    if (indexPath.section == 1) {
        
        [_houseSelectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [_houseSelectArr replaceObjectAtIndex:idx withObject:@0];
        }];
        
        [_houseSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    
    if (indexPath.section == 2) {
        
        [_statusSelectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [_statusSelectArr replaceObjectAtIndex:idx withObject:@0];
        }];
        
        [_statusSelectArr replaceObjectAtIndex:indexPath.item withObject:@1];
    }
    [collectionView reloadData];
}

- (void)initUI{

    
    UIView *alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height)];
    alphaView.backgroundColor = [UIColor whiteColor];
//    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _flowlayout = [[UICollectionViewFlowLayout alloc] init];
    _flowlayout.itemSize = CGSizeMake(77 *SIZE, 30 *SIZE);
    _flowlayout.minimumLineSpacing = 14 *SIZE;
    _flowlayout.minimumInteritemSpacing = 0 *SIZE;
    _flowlayout.sectionInset = UIEdgeInsetsMake(0, 10 *SIZE, 10 *SIZE, 10 *SIZE);

    _moreColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.bounds.size.height - 50 *SIZE) collectionViewLayout:_flowlayout];
    _moreColl.backgroundColor = [UIColor whiteColor];
    _moreColl.delegate = self;
    _moreColl.dataSource = self;
    
    [_moreColl registerClass:[MoreViewCollCell class] forCellWithReuseIdentifier:@"MoreViewCollCell"];
    [_moreColl registerClass:[MoreViewCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreViewCollHeader"];
    [self addSubview:_moreColl];
    
    _clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clearBtn.frame = CGRectMake(67 *SIZE, self.bounds.size.height - 47 *SIZE, 100 *SIZE, 33 *SIZE);
    _clearBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_clearBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_clearBtn setTitle:@"清空" forState:UIControlStateNormal];
    _clearBtn.layer.cornerRadius = 2 *SIZE;
    _clearBtn.clipsToBounds = YES;
    _clearBtn.layer.borderColor = COLOR(170, 170, 170, 1).CGColor;
    _clearBtn.layer.borderWidth = 1;
    [_clearBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [self addSubview:_clearBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.frame = CGRectMake(192 *SIZE, self.bounds.size.height - 47 *SIZE, 100 *SIZE, 33 *SIZE);
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_confirmBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:COLOR(27, 152, 255, 1)];
    _confirmBtn.layer.cornerRadius = 2 *SIZE;
    _confirmBtn.clipsToBounds = YES;
    [self addSubview:_confirmBtn];
}

@end
