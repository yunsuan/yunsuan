//
//  PeopleCell.m
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "PeopleCell.h"

@interface PeopleCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation PeopleCell

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
    _statulab.text = [NSString stringWithFormat:@"%@",statu];
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
    
    return CGSizeMake(260 *SIZE, 3 *SIZE);
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
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 65 *SIZE, 17 *SIZE)];
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
    
    _imageview = [[UIImageView alloc] init];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    [self.contentView addSubview:_imageview];
    
    _titlelab = [[UILabel alloc]init];
    _titlelab.textColor = YJTitleLabColor;
    _titlelab.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self.contentView addSubview:_titlelab];
    
    _contentlab = [[UILabel alloc]init];
    _contentlab.textColor = YJContentLabColor;
    _contentlab.font =[UIFont systemFontOfSize:10.7*SIZE];
    [self.contentView addSubview:_contentlab];
    
    _rankView = [[RankView alloc] initWithFrame:CGRectMake(123 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    [self.contentView addSubview:_rankView];
    
    _getLevel = [[LevelView alloc] initWithFrame:CGRectMake(217 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    _getLevel.titleL.text = @"结佣";
    [self.contentView addSubview:_getLevel];
    
    _statulab = [[UILabel alloc] init];
    _statulab.textColor = COLOR(27, 152, 255, 1);
    _statulab.font = [UIFont systemFontOfSize:12*SIZE];
    //        [self.contentView addSubview:_statulab];
    
    _statusImg = [[UIImageView alloc] init];
    _statusImg.image = [UIImage imageNamed:@"tui"];
    [self.contentView addSubview:_statusImg];
    
    
    _surelab = [[UILabel alloc] init];
    _surelab.textColor = COLOR(255, 165, 29, 1);
    _surelab.font = [UIFont systemFontOfSize:10.7*SIZE];
    _surelab.text = @"保证结佣";
    [self.contentView addSubview:_surelab];

    
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
    
//    [_statulab mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.contentView).offset(333 *SIZE);
//        make.top.equalTo(self.contentView).offset(11 *SIZE);
//        make.width.height.mas_equalTo(17 *SIZE);
//    }];
    
    [_statusImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(327 *SIZE);
        make.top.equalTo(self.contentView).offset(16 *SIZE);
        make.width.height.mas_equalTo(17 *SIZE);
    }];
    
    [_rankView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.top.equalTo(_titlelab.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
    }];
    
    [_getLevel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(216 *SIZE);
        make.top.equalTo(_titlelab.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(80 *SIZE);
        make.height.mas_equalTo(12 *SIZE);
    }];
    
    [_contentlab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_rankView.mas_bottom).offset(6 *SIZE);
        make.left.equalTo(self.contentView).offset(123 *SIZE);
        make.width.mas_equalTo(200 *SIZE);
    }];
    
    [_surelab mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(310 *SIZE);
        make.top.equalTo(_rankView.mas_bottom).offset(6 *SIZE);
        make.width.mas_equalTo(50 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_contentlab.mas_bottom).offset(3 *SIZE);
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
