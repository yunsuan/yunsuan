//
//  MyShopHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "MyShopHeader.h"

#import "AddTagViewCollCell.h"
#import "MyShopAddressL.h"

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
    _addressArr = [@[] mutableCopy];
}

- (void)setDataDic:(NSDictionary *)dataDic{
    
    _attentionL.text = [NSString stringWithFormat:@"%@",dataDic[@"focus_num"]];
    _seeL.text = [NSString stringWithFormat:@"%@",dataDic[@"browse_num"]];
    _scoreL.text = [NSString stringWithFormat:@"%@",dataDic[@"grade"]];
    
    _addressL.text = [NSString stringWithFormat:@"服务区域："];
}

- (void)setTagArr:(NSArray *)tagArr{
    
    _tagArr = [NSMutableArray arrayWithArray:tagArr];
    [_propertyColl reloadData];
    [self reloadInputViews];
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height);
    }];
}

- (void)setAddressArr:(NSArray *)addressArr{
    
    _addressArr = [NSMutableArray arrayWithArray:addressArr];
    [_addressColl reloadData];
    [self reloadInputViews];
    [_addressColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_addressColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE);
    }];
}

- (void)ActionAddBtn:(UIButton *)btn{
    
    if (self.myShopHeaderAddBlock) {
        
        self.myShopHeaderAddBlock();
    }
}

- (void)ActionAddressBtn:(UIButton *)btn{
    
    if (self.myShopHeaderAddressBtnBlock) {
        
        self.myShopHeaderAddressBtnBlock();
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView == _addressColl) {
        
        return _addressArr.count;
    }else{
        
        return _tagArr.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView == _addressColl) {
        
        AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
            
        cell.tag = indexPath.item;
        cell.cancelBtn.hidden = NO;
            
        [cell setstylebytype:@"0" andsetlab:_addressArr[(NSUInteger) indexPath.item]];
        cell.displayLabel.adjustsFontSizeToFitWidth = YES;
        cell.deleteBtnBlock = ^(NSUInteger index) {
            
            if (self.myShopHeaderAddressEditBlock) {
                    
                self.myShopHeaderAddressEditBlock(index);
            }
        };
        return cell;
    }else{
        
        AddTagViewCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AddTagViewCollCell" forIndexPath:indexPath];
        
        cell.tag = indexPath.item;
        cell.cancelBtn.hidden = NO;
        
        cell.displayLabel.adjustsFontSizeToFitWidth = YES;
        [cell setstylebytype:@"0" andsetlab:_tagArr[(NSUInteger) indexPath.item]];
        
        cell.deleteBtnBlock = ^(NSUInteger index) {
        
            if (self.myShopHeaderDeleteBlock) {
                
                self.myShopHeaderDeleteBlock(index);
            }
        };
        
        return cell;
    }
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
            label1.frame = CGRectMake(60 *SIZE, 30 *SIZE, 80 *SIZE, 15 *SIZE);
            _attentionL = label1;
        }else if (i == 1){
            
            label.frame = CGRectMake(140 *SIZE, 50 *SIZE, 80 *SIZE, 15 *SIZE);
            label1.frame = CGRectMake(140 *SIZE, 30 *SIZE, 80 *SIZE, 15 *SIZE);
            _seeL = label1;
        }else{
            
            label.frame = CGRectMake(220 *SIZE, 50 *SIZE, 80 *SIZE, 15 *SIZE);
            label1.frame = CGRectMake(220 *SIZE, 30 *SIZE, 80 *SIZE, 15 *SIZE);
            _scoreL = label1;
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
    
//    _contentTF = [[BorderTF alloc] initWithFrame:CGRectMake(0, 0, 258 *SIZE, 33 *SIZE)];
//    _contentTF.textfield.textColor = YJContentLabColor;
//    _contentTF.textfield.font = [UIFont systemFontOfSize:13 *SIZE];
//    _contentTF.textfield.placeholder = @"我的标签";
//    [self.contentView addSubview:_contentTF];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(100 *SIZE, 37*SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 340 *SIZE, 37 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _addressLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _addressLayout.itemSize = CGSizeMake(100 *SIZE, 37*SIZE);
//    _addressLayout.itemSize = CGSizeMake(280 *SIZE, 20*SIZE);
    
    _addressColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 0, 280 *SIZE, 20 *SIZE) collectionViewLayout:_addressLayout];
    _addressColl.backgroundColor = [UIColor whiteColor];
    _addressColl.delegate = self;
    _addressColl.dataSource = self;
    [_addressColl registerClass:[AddTagViewCollCell class] forCellWithReuseIdentifier:@"AddTagViewCollCell"];
    [self.contentView addSubview:_addressColl];
    
    _addressL = [[UILabel alloc] init];
    _addressL.font = [UIFont systemFontOfSize:11 *SIZE];
    _addressL.textColor = YJContentLabColor;
    [self.contentView addSubview:_addressL];
    
    _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addBtn addTarget:self action:@selector(ActionAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addBtn];
    
    _addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addressBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_addressBtn addTarget:self action:@selector(ActionAddressBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_addressBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
//    [_contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(70 *SIZE);
//        make.top.equalTo(self.contentView).offset(78 *SIZE);
//        make.width.mas_equalTo(200 *SIZE);
//        make.height.mas_equalTo(33 *SIZE);
//    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(70 *SIZE);
        make.top.equalTo(self.contentView).offset(75 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
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
        
        make.left.equalTo(self.contentView).offset(70 *SIZE);
        make.top.equalTo(self->_propertyColl.mas_bottom).offset(0 *SIZE);
        make.width.height.mas_equalTo(40 *SIZE);
    }];
    
    [_addressColl mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self->_addressL.mas_bottom).offset(5 *SIZE);
        make.width.mas_equalTo(340 *SIZE);
        make.height.mas_equalTo(_addressColl.collectionViewLayout.collectionViewContentSize.height + 15 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
}

@end
