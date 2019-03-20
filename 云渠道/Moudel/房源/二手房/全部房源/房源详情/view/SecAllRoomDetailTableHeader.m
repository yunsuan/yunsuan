//
//  SecAllRoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomDetailTableHeader.h"

#import "BuildingAlbumCollCell.h"

@interface SecAllRoomDetailTableHeader()<UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
{
    
    NSInteger _num;
    NSInteger _nowNum;
    NSMutableArray *_allArr;
    NSInteger _total;
//    NSInteger _current;
}


@end

@implementation SecAllRoomDetailTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        _num = 1;
        _allArr = [@[] mutableCopy];
        [self initUI];
    }
    return self;
}


#pragma mark -- 赋值 --
- (void)setModel:(SecAllRoomProjectModel *)model{
    
    _titleL.text = model.title;
    
    _propertyL.text = model.property_type;
    
    _priceL.text = [NSString stringWithFormat:@"￥%@万",model.price];
    
    _typeL.text = model.house_type;
    
    _areaL.text = [NSString stringWithFormat:@"%@㎡",model.build_area];
    _areaTL.text = @"面积";
    
    if ([model.price_change integerValue] == 0) {
        
        _statusImg.image = [UIImage imageNamed:@""];
    }else if ([model.price_change integerValue] == 1){
        
        _statusImg.image = [UIImage imageNamed:@"rising"];
    }else{
        
        _statusImg.image = [UIImage imageNamed:@"falling"];
    }
}

- (void)setStoreModel:(SecAllRoomStoreModel *)storeModel{
    
    _titleL.text = storeModel.title;
    
    if ([storeModel.property_type containsString:@"参数"]) {
        
        _propertyL.text = [storeModel.property_type substringWithRange:NSMakeRange(0, storeModel.property_type.length -2)];
    }else{
        
        _propertyL.text = storeModel.property_type;
    }
//    _propertyL.text = storeModel.property_type;
    
    _priceL.text = [NSString stringWithFormat:@"￥%@元/㎡",storeModel.price];
//    _priceTL.text = @"租金";
    
    _typeL.text = storeModel.shop_type;
    _typeTL.text = @"商铺类型";
    
    _areaL.text = [NSString stringWithFormat:@"%@㎡",storeModel.build_area];
    
    if ([storeModel.price_change integerValue] == 0) {
        
        _statusImg.image = [UIImage imageNamed:@""];
    }else if ([storeModel.price_change integerValue] == 1){
        
        _statusImg.image = [UIImage imageNamed:@"rising"];
    }else{
        
        _statusImg.image = [UIImage imageNamed:@"falling"];
    }
}

- (void)setOfficeModel:(SecAllRoomOfficeModel *)officeModel{
    
    _titleL.text = officeModel.title;
    
    if ([officeModel.property_type containsString:@"参数"]) {
        
        _propertyL.text = [officeModel.property_type substringWithRange:NSMakeRange(0, officeModel.property_type.length -2)];
    }else{
        
        _propertyL.text = officeModel.property_type;
    }
    
    
    _priceL.text = [NSString stringWithFormat:@"￥%@万元",officeModel.price];
    
    _typeL.text = officeModel.grade;
    _typeTL.text = @"级别";
    
    _areaL.text = [NSString stringWithFormat:@"%@㎡",officeModel.build_area];
    _areaTL.text = @"面积";
    if ([officeModel.price_change integerValue] == 0) {
        
        _statusImg.image = [UIImage imageNamed:@""];
    }else if ([officeModel.price_change integerValue] == 1){
        
        _statusImg.image = [UIImage imageNamed:@"rising"];
    }else{
        
        _statusImg.image = [UIImage imageNamed:@"falling"];
    }
}

#pragma  mark -- 点击事件 --
- (void)ActionAttentBtn:(UIButton *)btn{
    
    //    if (self.attentBtnBlock) {
    //
    //        self.attentBtnBlock();
    //    }
}

- (void)ActionImgBtn{
    
        if (self.secAllRoomDetailTableHeaderImgBlock) {
    
            if (_imgArr.count) {
    
                self.secAllRoomDetailTableHeaderImgBlock(_nowNum, _imgArr);
    
            }
        }
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _total = 0;
    [_allArr removeAllObjects];
    if (!imgArr.count) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:_imgScroll.frame];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.image = [UIImage imageNamed:@"default_3"];
        img.clipsToBounds = YES;
        
        [_imgScroll setContentSize:CGSizeMake(SCREEN_Width, _imgScroll.frame.size.height)];
        [_imgScroll addSubview:img];
        _numL.text = @"0/0";
//        [self.contentView addSubview:img];
    }else{
        
        for (UIView *view in _imgScroll.subviews) {
            
            [view removeFromSuperview];
        }
        _imgArr = [NSMutableArray arrayWithArray:imgArr];
        for ( int i = 0; i < imgArr.count; i++) {
            
            if ([imgArr[i] isKindOfClass:[NSDictionary class]]) {
                
                NSMutableDictionary *tempDic = [[NSMutableDictionary alloc] initWithDictionary:imgArr[i]];
                
                if ([tempDic[@"list"] count]) {
                    for (int j = 0; j < [tempDic[@"list"] count]; j++) {
                        
                        _total = _total + 1;
                        [_allArr addObject:tempDic[@"list"][j]];
                    }
                }else{
                    
                    _total += 1;
                    [_allArr addObject:@{@"img_url":@"default_3"}];
                }
            }
        }
        [_imgScroll setContentSize:CGSizeMake(SCREEN_Width * _total, _imgScroll.frame.size.height)];
        
        for (int i = 0; i < _total; i++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, _imgScroll.frame.size.height)];
            img.backgroundColor = [UIColor whiteColor];
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
            [img addGestureRecognizer:tap];
            img.userInteractionEnabled = YES;
            [_imgScroll addSubview:img];
            if ([_allArr[i][@"img_url"] isEqualToString:@"default_3"]) {
                
                img.image = [UIImage imageNamed:@"default_3"];
            }else{
                
                NSString *imgurl =_allArr[i][@"img_url"];
                if (imgurl.length>0) {
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,_allArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        img.image = [UIImage imageNamed:@"default_3"];
                    }
                }];
                }
                else{
                     img.image = [UIImage imageNamed:@"default_3"];
                }
            }
            
        }
        _numL.text = [NSString stringWithFormat:@"1/%ld",_total];
        [_imgColl reloadData];
        [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] animated:NO scrollPosition:0];
    }
}

- (void)setType:(NSInteger)type{
    
    if (type == 1) {
        
//        NSArray *titleArr = @[@"售价",@"房型",@"产权面积"];
    }else if (type == 2){
        
        
    }else{
        
        
    }
}

#pragma mark -- ScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _num = (scrollView.contentOffset.x / SCREEN_Width) + 1;
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        
        if ([_imgArr[i][@"list"] count]) {
            
            if (([_imgArr[i][@"list"] count]  + count)< _num) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }else{
            
            if ((1  + count)< _num) {
                
                count = count + 1;
            }else{
                
                [_imgColl selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:NO scrollPosition:0];
                break;
            }
        }
    }
    _numL.text = [NSString stringWithFormat:@"%ld/%ld",_num,_total];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _imgArr.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    NSInteger numberOfItems = [collectionView numberOfItemsInSection:0];
    
    CGFloat combinedItemWidth = (numberOfItems * _flowLayout.itemSize.width) + ((numberOfItems - 1) * _flowLayout.minimumInteritemSpacing);
    
    CGFloat padding = (collectionView.frame.size.width - combinedItemWidth) / 2;
    
    padding = padding > 0 ? padding :0 ;
    
    return UIEdgeInsetsMake(0, padding + 5 *SIZE,0, padding - 5 *SIZE);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BuildingAlbumCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BuildingAlbumCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[BuildingAlbumCollCell alloc] initWithFrame:CGRectMake(0, 0, 50 *SIZE, 27 *SIZE)];
    }
    
    cell.contentL.text = _imgArr[indexPath.item][@"type"];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger count = 0;
    for (int i = 0; i < _imgArr.count; i++) {
        
        if (i < indexPath.item) {
            
            if ([_imgArr[i][@"list"] count]) {
                
                count = count + [_imgArr[i][@"list"] count];
            }else{
                
                count = count + 1;
            }
        }
    }
    [_imgScroll setContentOffset:CGPointMake(count * SCREEN_Width, 0) animated:NO];
}


- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
//    _imgScroll.backgroundColor = [UIColor blackColor];
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    _alphaView = [[UIView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE, SCREEN_Width, 40 *SIZE)];
    _alphaView.backgroundColor = [UIColor blackColor];
    _alphaView.alpha = 0.2;
    [self.contentView addSubview:_alphaView];
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(50 *SIZE, 27 *SIZE);
    _flowLayout.minimumInteritemSpacing = 17 *SIZE;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    _imgColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 162.5 *SIZE , SCREEN_Width, 40 *SIZE) collectionViewLayout:_flowLayout];
    _imgColl.backgroundColor = [UIColor clearColor];
    _imgColl.delegate = self;
    _imgColl.dataSource = self;
    
    [_imgColl registerClass:[BuildingAlbumCollCell class] forCellWithReuseIdentifier:@"BuildingAlbumCollCell"];
    [self.contentView addSubview:_imgColl];
    
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 144 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = YJTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = [UIColor blackColor];
    _titleL.font = [UIFont boldSystemFontOfSize:15 *SIZE];
    [self.contentView addSubview:_titleL];

    _propertyL = [[UILabel alloc] init];
    _propertyL.textColor = COLOR(64, 169, 255, 1);
    _propertyL.font = [UIFont systemFontOfSize:10 *SIZE];
    _propertyL.textAlignment = NSTextAlignmentCenter;
    _propertyL.backgroundColor = COLOR(213, 242, 255, 1);
    [self.contentView addSubview:_propertyL];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:10 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];

    
    _moreView = [[UIView alloc] initWithFrame:CGRectMake(0, 249 *SIZE, SCREEN_Width, 67 *SIZE)];
    _moreView.backgroundColor = [UIColor whiteColor];
//    NSArray *titleArr = @[@"售价",@"房型",@"产权面积"];
    NSArray *titleArr = @[@"售价",@"户型",@"产权面积"];
    for (int i = 0; i < 3; i++) {
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 17 *SIZE, SIZE, 36 *SIZE)];
        line.backgroundColor = YJBackColor;
        if (i != 0) {
            
            [_moreView addSubview:line];
        }
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 19 *SIZE, SCREEN_Width / 3, 13 *SIZE)];
        label.textColor = YJBlueBtnColor;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        
        switch (i) {
            case 0:
            {
                _priceL = label;
                [_moreView addSubview:_priceL];
                break;
            }
            case 1:
            {
                _typeL = label;
                [_moreView addSubview:_typeL];
                break;
            }
            case 2:
            {
                _areaL = label;
                [_moreView addSubview:_areaL];
                break;
            }
            default:
                break;
        }
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 3 * i, 41 *SIZE, SCREEN_Width / 3, 11 *SIZE)];
        label1.textColor = YJ86Color;
        label1.font = [UIFont systemFontOfSize:12 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.text = titleArr[i];
        switch (i) {
            case 0:
            {
                _priceTL = label1;
                [_moreView addSubview:_priceTL];
                break;
            }
            case 1:
            {
                _typeTL = label1;
                [_moreView addSubview:_typeTL];
                break;
            }
            case 2:
            {
                _areaTL = label1;
                [_moreView addSubview:_areaTL];
                break;
            }
            default:
                break;
        }
//        [_moreView addSubview:label1];
    }
    _statusImg = [[UIImageView alloc] initWithFrame:CGRectMake(76 *SIZE, 42 *SIZE, 10 *SIZE, 10 *SIZE)];
//    _statusImg.image = [UIImage imageNamed:@"rising"];
    [_moreView addSubview:_statusImg];
    
    [self.contentView addSubview:_moreView];

    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(216.5 *SIZE);
        make.right.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-11 *SIZE);
        make.top.equalTo(self.contentView).offset(213.5 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(8 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
//        make.width.mas_equalTo(_attentL.mj_textWith + 6 *SIZE);
    }];
    
    [_moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_attentL.mas_bottom).offset(6 *SIZE);
        make.width.equalTo(@(SCREEN_Width));
        make.height.equalTo(@(67 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
