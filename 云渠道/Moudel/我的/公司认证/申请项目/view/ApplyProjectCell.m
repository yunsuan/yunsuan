//
//  ApplyProjectCell.m
//  云渠道
//
//  Created by 谷治墙 on 2019/3/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "ApplyProjectCell.h"

@interface ApplyProjectCell ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation ApplyProjectCell

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
    
    _propertyArr = [NSMutableArray arrayWithArray:data[0]];
    _tagArr = [NSMutableArray arrayWithArray:data[1]];
    [_propertyColl reloadData];
    
//    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
//    }];
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
        
        cell = [[TagCollCell alloc] initWithFrame:CGRectMake(0, 0, 60 *SIZE, 17 *SIZE)];
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
    
    _selectImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 48 *SIZE, 15 *SIZE, 15 *SIZE)];
    [self.contentView addSubview:_selectImg];
    
    _imageview = [[UIImageView alloc]initWithFrame:CGRectMake(31 *SIZE,16.3*SIZE, 100*SIZE, 88.3*SIZE)];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    [self.contentView addSubview:_imageview];
    _titlelab = [[UILabel alloc]initWithFrame:CGRectMake(143*SIZE, 16*SIZE, 200*SIZE, 14*SIZE)];
    _titlelab.textColor = YJTitleLabColor;
    _titlelab.font = [UIFont boldSystemFontOfSize:13.3*SIZE];
    [self.contentView addSubview:_titlelab];
    _contentlab = [[UILabel alloc]initWithFrame:CGRectMake(144 *SIZE, 52.7*SIZE, 200*SIZE, 11*SIZE)];
    _contentlab.textColor = YJContentLabColor;
    _contentlab.font =[UIFont systemFontOfSize:10.7*SIZE];
    [self.contentView addSubview:_contentlab];
    
    _rankView = [[RankView alloc] initWithFrame:CGRectMake(143 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    [self.contentView addSubview:_rankView];
    
    _getLevel = [[LevelView alloc] initWithFrame:CGRectMake(237 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    _getLevel.titleL.text = @"结佣";
    [self.contentView addSubview:_getLevel];
    
    _statulab = [[UILabel alloc]initWithFrame:CGRectMake(327.7*SIZE, 15.7*SIZE, 30*SIZE, 13*SIZE)];
    _statulab.textColor = COLOR(27, 152, 255, 1);
    _statulab.font = [UIFont systemFontOfSize:12*SIZE];
    //        [self.contentView addSubview:_statulab];
    
    _statusImg = [[UIImageView alloc] initWithFrame:CGRectMake(333 *SIZE, 11 *SIZE, 17 *SIZE, 17 *SIZE)];
    _statusImg.image = [UIImage imageNamed:@"tui"];
    [self.contentView addSubview:_statusImg];
    
    
    _surelab = [[UILabel alloc]initWithFrame:CGRectMake(309.7*SIZE, 52.7*SIZE, 50*SIZE, 11*SIZE)];
    _surelab.textColor = COLOR(255, 165, 29, 1);
    _surelab.font = [UIFont systemFontOfSize:10.7*SIZE];
    _surelab.text = @"保证结佣";
    [self.contentView addSubview:_surelab];
//    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(144*SIZE, 66.7*SIZE, 200*SIZE, 16.7*SIZE)  type:@"0"];
//    [self.contentView addSubview:_wuyeview];
//
//    _tagview = [[TagView alloc]initWithFrame:CGRectMake(144 *SIZE, 88*SIZE, 200*SIZE, 16.7*SIZE)  type:@"1"];
//    [self.contentView addSubview:_tagview];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(60 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(144 *SIZE, 67 *SIZE, 200 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
    lane.backgroundColor = YJBackColor;
    [self.contentView addSubview:lane];
}



@end
