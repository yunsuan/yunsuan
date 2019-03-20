//
//  RentingAllRoomOfficeCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/12/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingAllRoomOfficeCell.h"

@interface RentingAllRoomOfficeCell ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

{
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation RentingAllRoomOfficeCell

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
    _tagArr = [@[] mutableCopy];
}

- (void)setModel:(RentingAllRoomOfficeModel *)model{
    
    _propertyArr = [NSMutableArray arrayWithArray:model.project_tags];
    _tagArr = [NSMutableArray arrayWithArray:model.house_tags];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    _transferL.text = [NSString stringWithFormat:@"转让费：%@元",model.transfer_money];
    _depositL.text = [NSString stringWithFormat:@"押金：%@元",model.deposit];
    _roomLevelL.text = [NSString stringWithFormat:@"房源等级：%@",model.level];
    _rentTypeL.text = [NSString stringWithFormat:@"租赁类型：%@",model.rent_type];
//    _payWayL.text = [NSString stringWithFormat:@"收款方式：%@",[model.receive_way componentsJoinedByString:@","]];
    _payWayL.text = @"收款方式：";
    _minPeriodL.text = [NSString stringWithFormat:@"最短租期：%@",model.rent_min_comment];
    _maxPeriodL.text = [NSString stringWithFormat:@"最长租期：%@",model.rent_max_comment];
    if ([model.check_in_time containsString:@"0000"]) {
        
        _inTimeL.text = @"可入住时间：随时入住";
    }else{
        
        _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@",model.check_in_time];
    }
    _inTimeL.text = [NSString stringWithFormat:@"可入住时间：%@",@""];
    _seeL.text = [NSString stringWithFormat:@"看房方式：%@",model.check_way];
    _rentFreeL.text = [NSString stringWithFormat:@"免租期：%@",model.rent_free_month];
    _accommodateL.text = [NSString stringWithFormat:@"工位：%@",model.work_station_hold];
    _intentL.text = [NSString stringWithFormat:@"出租意愿度：%@",model.intent];
    _urgentL.text = [NSString stringWithFormat:@"出租急迫度：%@",model.urgency];
    _markL.text = [NSString stringWithFormat:@"%@",model.comment];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    if (_propertyArr.count && _tagArr.count) {
        
        return 2;
    }else if (!_propertyArr.count && !_tagArr.count){
        
        return 0;
    }else{
        
        return 1;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 3 *SIZE);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 1) {
        
        return _tagArr.count;
    }else{
        
        if (_propertyArr.count) {
            
            return _propertyArr.count;
        }else{
            
            return _tagArr.count;
        }
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
        
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"1" lab:_propertyArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        }
    }
    
    return cell;
}

- (void)initUI{
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 15 *SIZE, 340 *SIZE, 50 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _markView = [[UIView alloc] init];
    _markView.backgroundColor = COLOR(244, 244, 244, 1);
    [self.contentView addSubview:_markView];
    
    for (int i = 0; i < 15; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YJ86Color;
//        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:13 *SIZE];
        
        switch (i) {
                
            case 0:{
                
                _transferL = label;
                [self.contentView addSubview:_transferL];
                break;
            }
            case 1:{
                
                _depositL = label;
                [self.contentView addSubview:_depositL];
                break;
            }
            case 2:{
                
                _roomLevelL = label;
                [self.contentView addSubview:_roomLevelL];
                break;
            }
            case 3:{
                
                _rentTypeL = label;
                [self.contentView addSubview:_rentTypeL];
                break;
            }
            case 4:{
                
                _payWayL = label;
                [self.contentView addSubview:_payWayL];
                break;
            }
            case 5:{
                
                _minPeriodL = label;
                [self.contentView addSubview:_minPeriodL];
                break;
            }
            case 6:{
                
                _maxPeriodL = label;
                [self.contentView addSubview:_maxPeriodL];
                break;
            }
            case 7:{
                
                _floorL = label;
                [self.contentView addSubview:_floorL];
                break;
            }
            case 8:{
                
                _inTimeL = label;
                [self.contentView addSubview:_inTimeL];
                break;
            }
            case 9:{
                
                _seeL = label;
                [self.contentView addSubview:_seeL];
                break;
            }
            case 10:{
                
                _rentFreeL = label;
                [self.contentView addSubview:_rentFreeL];
                break;
            }
            case 11:{
                
                _accommodateL = label;
                [self.contentView addSubview:_accommodateL];
                break;
            }
            case 12:{
                
                _intentL = label;
                [self.contentView addSubview:_intentL];
                break;
            }
            case 13:{
                
                _urgentL = label;
                [self.contentView addSubview:_urgentL];
                break;
            }
            case 14:{
                
                _markL = label;
                [_markView addSubview:_markL];
                break;
            }
            default:
                break;
        }
    }
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_transferL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(14 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_depositL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(14 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_roomLevelL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_transferL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentTypeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_depositL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_payWayL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_roomLevelL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(340 *SIZE));
    }];
    
    [_minPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_maxPeriodL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_payWayL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_minPeriodL.mas_bottom).offset(19 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_inTimeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_minPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_seeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_maxPeriodL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_rentFreeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_inTimeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_accommodateL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_seeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_intentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(200 *SIZE);
        make.top.equalTo(_rentFreeL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_urgentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_accommodateL.mas_bottom).offset(15 *SIZE);
        make.width.equalTo(@(150 *SIZE));
    }];
    
    [_markView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_urgentL.mas_bottom).offset(16 *SIZE);
        make.width.equalTo(@(340 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
    }];
    
    [_markL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_markView).offset(4 *SIZE);
        make.top.equalTo(_markView).offset(15 *SIZE);
        make.width.equalTo(@(330 *SIZE));
        make.bottom.equalTo(_markView).offset(-15 *SIZE);
    }];
    
}

@end
