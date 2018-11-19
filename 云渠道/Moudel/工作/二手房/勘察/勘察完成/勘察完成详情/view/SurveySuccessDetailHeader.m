//
//  SurveySuccessDetailHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SurveySuccessDetailHeader.h"

#import "SurveySuccessDetailHeaderCollCell.h"

@interface SurveySuccessDetailHeader()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    
    NSArray *_titleArr;
}

@end

@implementation SurveySuccessDetailHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

#pragma mark -- CollDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SurveySuccessDetailHeaderCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SurveySuccessDetailHeaderCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[SurveySuccessDetailHeaderCollCell alloc] initWithFrame:CGRectMake(0, 0, 180 *SIZE, 47 *SIZE)];
    }
    cell.titleL.text = _titleArr[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (_delegate && [_delegate respondsToSelector:@selector(surveySuccessDetailHeaderCollectionView:didSelectItemAtIndexPath:)]) {
        
        [_delegate surveySuccessDetailHeaderCollectionView:_headerColl didSelectItemAtIndexPath:indexPath];
    }else{
        
        NSLog(@"没有代理人");
    }
}

- (void)initUI{
    
    _titleArr = @[@"基本信息",@"房源优势"];
    
    _baseHeader = [[BaseHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    _baseHeader.contentView.backgroundColor = YJBackColor;
    [self.contentView addSubview:_baseHeader];
    
    for (int i = 0; i < 10 ; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        switch (i) {
            case 0:
            {
                _titleL = label;
                [self.contentView addSubview:_titleL];
                break;
            }
            case 1:
            {
                _priceL = label;
                [self.contentView addSubview:_priceL];
                break;
            }
            case 2:
            {
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 3:
            {
                _propertyL = label;
                [self.contentView addSubview:_propertyL];
                break;
            }
            case 4:
            {
                _mortgageL = label;
                [self.contentView addSubview:_mortgageL];
                break;
            }
            case 5:
            {
                _yearL = label;
                [self.contentView addSubview:_yearL];
                break;
            }
            case 6:
            {
                _seeWayL = label;
                [self.contentView addSubview:_seeWayL];
                break;
            }
            case 7:
            {
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 8:
            {
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 9:
            {
                _reasonL = label;
                [self.contentView addSubview:_reasonL];
                break;
            }
            default:
                break;
        }
    }
    
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.itemSize = CGSizeMake(180 *SIZE, 47 *SIZE);
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    
    _headerColl = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 382 *SIZE, SCREEN_Width, 47 *SIZE) collectionViewLayout:_flowLayout];
    _headerColl.backgroundColor = YJBackColor;
    _headerColl.delegate = self;
    _headerColl.dataSource = self;
    
    [_headerColl registerClass:[SurveySuccessDetailHeaderCollCell class] forCellWithReuseIdentifier:@"SurveySuccessDetailHeaderCollCell"];
    [self.contentView addSubview:_headerColl];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(self.contentView).offset(53 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_propertyL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_mortgageL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_propertyL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_yearL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_mortgageL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_seeWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_yearL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_seeWayL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_intentL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
    }];
    
    [_reasonL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(28 *SIZE);
        make.top.equalTo(_urgentL.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(self.contentView).offset(28 *SIZE);
//        make.right.equalTo(self.contentView).offset(-22 *SIZE);
    }];
    
    [_headerColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_reasonL.mas_bottom).offset(22 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(47 *SIZE);
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);
    }];
}

@end
