//
//  CompanyCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CompanyCell.h"

@interface CompanyCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation CompanyCell

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

-(void)SetTitle:(NSString *)title image:(NSString *)imagename contentlab:(NSString *)content statu:(NSString *)statu
{
    if (imagename.length>0) {
        
        [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imagename]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
              _imageview.image= [UIImage imageNamed:@"default_1"];
            }
        }];
    }
    else{
        
        _imageview.image= [UIImage imageNamed:@"default_1"];
    }
   
    _titlelab.text = title;
    _statulab.text = statu;
    _contentlab.text = content;

}


-(void)settagviewWithdata:(NSArray *)data
{
//    [_wuyeview setData:data[0]];
//    [_tagview setData:data[1]];
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
    
    _imageview = [[UIImageView alloc]init];//WithFrame:CGRectMake(11.7*SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    [self.contentView addSubview:_imageview];
    
    _titlelab = [[UILabel alloc]init];//WithFrame:CGRectMake(123.3*SIZE, 16*SIZE, 200*SIZE, 14*SIZE)];
    _titlelab.textColor = YJTitleLabColor;
    _titlelab.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self.contentView addSubview:_titlelab];
    
    _contentlab = [[UILabel alloc] init];//WithFrame:CGRectMake(124.3*SIZE, 37*SIZE, 200*SIZE, 11*SIZE)];
    _contentlab.textColor = YJContentLabColor;
    _contentlab.font =[UIFont systemFontOfSize:10.7*SIZE];
    [self.contentView addSubview:_contentlab];
    
    _statulab = [[UILabel alloc] init];//WithFrame:CGRectMake(327.7*SIZE, 15.7*SIZE, 30*SIZE, 13*SIZE)];
    _statulab.textColor = COLOR(27, 152, 255, 1);
    _statulab.font = [UIFont systemFontOfSize:12*SIZE];
    //        [self.contentView addSubview:_statulab];
    
    _statusImg = [[UIImageView alloc] initWithFrame:CGRectMake(333 *SIZE, 11 *SIZE, 17 *SIZE, 17 *SIZE)];
    _statusImg.image = [UIImage imageNamed:@"tui"];
    [self.contentView addSubview:_statusImg];
    
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
    
    [_titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(327 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(17 *SIZE);
    }];
    
    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titlelab.mas_bottom).offset(7 *SIZE);
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_titlelab.mas_bottom).offset(26 *SIZE);
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
