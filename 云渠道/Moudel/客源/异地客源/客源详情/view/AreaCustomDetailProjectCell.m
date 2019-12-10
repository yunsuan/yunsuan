//
//  AreaCustomDetailProjectCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/12/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "AreaCustomDetailProjectCell.h"

@interface AreaCustomDetailProjectCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation AreaCustomDetailProjectCell

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
    
    _propertyArr = [@[] mutableCopy];
    _tagArr = [@[] mutableCopy];
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        if (error) {
            
          _imageview.image= [UIImage imageNamed:@"default_1"];
        }
    }];
      
    _titleL.text = dataDic[@"project_name"];
    _statuL.text = dataDic[@"current_state_name"];
    _recommendL.text = [dataDic[@"sale_state"] integerValue] == 1?@"在售":[dataDic[@"sale_state"] integerValue] == 2?@"待售":@"售完";
    _addressL.text = [NSString stringWithFormat:@"%@%@%@",dataDic[@"province_name"],dataDic[@"city_name"],dataDic[@"district_name"]];
}


-(void)settagviewWithdata:(NSArray *)data
{

    _propertyArr = [NSMutableArray arrayWithArray:data[0]];
    _tagArr = [NSMutableArray arrayWithArray:data[1]];
    [_propertyColl reloadData];
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
        
        return _tagArr.count > 3 ? 3:_tagArr.count;
    }else{
        
        if (_propertyArr.count) {
            
            return _propertyArr.count > 3 ? 3:_propertyArr.count;
        }else{
            
            return _tagArr.count > 3 ? 3:_tagArr.count;
        }
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TagCollCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TagCollCell" forIndexPath:indexPath];
    if (!cell) {
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 70 *SIZE, 20 *SIZE)];
    }
    
    if (indexPath.section == 1) {
        
        [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        
    }else{
        
        if (_propertyArr.count) {
            
            [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        }
    }
    
    return cell;
}

- (void)initUI{
    
    _imageview = [[UIImageView alloc]init];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    [self.contentView addSubview:_imageview];
    
    _titleL = [[UILabel alloc]init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self.contentView addSubview:_titleL];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = YJContentLabColor;
    _addressL.font =[UIFont systemFontOfSize:10.7*SIZE];
    [self.contentView addSubview:_addressL];
    
    _statuL = [[UILabel alloc] init];
    _statuL.textColor = COLOR(27, 152, 255, 1);
    _statuL.font = [UIFont systemFontOfSize:12*SIZE];
    _statuL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statuL];
    
    _recommendL = [[UILabel alloc] init];
    _recommendL.textColor = [UIColor redColor];
    _recommendL.font = [UIFont systemFontOfSize:12*SIZE];
    [self.contentView addSubview:_recommendL];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(125 *SIZE, 67 *SIZE, 250 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _line = [[UIView alloc] init];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_imageview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(12 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(88*SIZE);
    }];
    
    [_recommendL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self->_imageview).offset(0 *SIZE);
        make.bottom.equalTo(self->_imageview.mas_bottom).offset(0 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
        make.height.mas_equalTo(14 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(150 *SIZE);
    }];
    
    [_statuL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(277 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.height.mas_equalTo(17 *SIZE);
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titleL.mas_bottom).offset(7 *SIZE);
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_addressL.mas_bottom).offset(26 *SIZE);
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_imageview.mas_bottom).offset(15 *SIZE);
        make.left.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(SIZE);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
