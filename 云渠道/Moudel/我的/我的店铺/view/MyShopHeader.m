//
//  MyShopHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopHeader.h"

@interface MyShopHeader ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_tagArr;
}
@end

@implementation MyShopHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initDataSource];
        [self initUI];
    }
    return self;
}

- (void)initDataSource{
    
    _tagArr = [@[] mutableCopy];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _tagArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 70 *SIZE, 20 *SIZE)];
    }
    
    [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
    
    return cell;
}

- (void)initUI{
    
    self.contentView.backgroundColor = CLWhiteColor;
    
    NSArray *titleArr = @[@"关注量",@"浏览量",@"评分"];
    
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11 *SIZE];
        label.text = titleArr[i];
        label.textColor = YJContentLabColor;
        label.textAlignment = NSTextAlignmentCenter;
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.font = [UIFont systemFontOfSize:13 *SIZE];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.textColor = YJTitleLabColor;
        if (i == 0) {
            
            label.frame = CGRectMake(60 *SIZE, 50 *SIZE, 80 *SIZE, 15 *SIZE);
            _attentionL = label;
        }else if (i == 1){
            
            label.frame = CGRectMake(140 *SIZE, 50 *SIZE, 80 *SIZE, 15 *SIZE);
            _seeL = label;
        }else{
            
            label.frame = CGRectMake(220 *SIZE, 50 *SIZE, 300 *SIZE, 15 *SIZE);
            _scoreL = label;
        }
        [self.contentView addSubview:label];
        [self.contentView addSubview:_attentionL];
        [self.contentView addSubview:_seeL];
        [self.contentView addSubview:_scoreL];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE, 90 *SIZE, 100 *SIZE, 15 *SIZE)];
    label.font = [UIFont systemFontOfSize:11 *SIZE];
    label.text = @"我的标签：";
    label.textColor = YJContentLabColor;
    [self.contentView addSubview:label];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 10 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _addressL = [[UILabel alloc] init];
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    _addressL.textColor = YJContentLabColor;
    [self.contentView addSubview:_addressL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:_addBtn];
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addressBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.contentView addSubview:_addressBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(120 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(15 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_addressL.mas_bottom).offset(10 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
}

@end
