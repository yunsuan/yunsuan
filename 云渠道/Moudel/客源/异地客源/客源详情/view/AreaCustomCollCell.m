//
//  AreaCustomCollCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/8.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomCollCell.h"

#import "AreaCustomCollHeader.h"
#import "AreaCustomColl.h"

@interface AreaCustomCollCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_imgArr;
}

@end

@implementation AreaCustomCollCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _dataArr = [@[] mutableCopy];
}

- (void)setDataArr:(NSArray *)dataArr{
    
    _imgArr = [@[] mutableCopy];
    NSInteger num = dataArr.count;
    for (int i = 0; i < 3; i++) {
        
        [_imgArr addObject:@{@"title":[dataArr[num - 3 + i] componentsSeparatedByString:@","][0],@"param":[dataArr[num - 3 + i] componentsSeparatedByString:@","][1]}];
    }
    [_imgColl reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//
//    return CGSizeMake(160 *SIZE, 30 *SIZE);
//}

//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//
//    AreaCustomCollHeader *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AreaCustomCollHeader" forIndexPath:indexPath];
//    if (!header) {
//
//        header = [[AreaCustomCollHeader alloc] initWithFrame:CGRectMake(0, 0, 160 *SIZE, 30 *SIZE)];
//    }
//
//    header.titleL.text = _imgArr[indexPath.section][@"title"];
//
//    return header;
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    AreaCustomColl *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AreaCustomColl" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[AreaCustomColl alloc] initWithFrame:CGRectMake(0, 0, 150 *SIZE, 130 *SIZE)];
    }
    
    cell.titleL.text = _imgArr[indexPath.item][@"title"];
    
    [cell.bigImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_imgArr[indexPath.item][@"param"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
       
        cell.bigImg.image = [UIImage imageNamed:@"banner_default_2"];
    }];
    
    return cell;
}

- (void)initUI{
    
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:0 *SIZE];
//    _propertyFlowLayout.headerReferenceSize = CGSizeMake(160 *SIZE, 30 *SIZE);
    _propertyFlowLayout.itemSize = CGSizeMake(150 *SIZE, 130 *SIZE);
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0 *SIZE, 67 *SIZE, 340 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _imgColl.backgroundColor = [UIColor whiteColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    [_imgColl registerClass:[AreaCustomColl class] forCellWithReuseIdentifier:@"AreaCustomColl"];
//    [_imgColl registerClass:[AreaCustomCollHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AreaCustomCollHeader"];
    [self.contentView addSubview:_imgColl];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_imgColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView).offset(0 *SIZE);
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(_imgColl.collectionViewLayout.collectionViewContentSize.height + 10 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}
@end
