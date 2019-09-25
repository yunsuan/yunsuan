//
//  RoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomDetailTableHeader.h"
#import <MapKit/MapKit.h>

@interface RoomDetailTableHeader()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
    
    NSMutableArray *_titleArr;
    NSMutableArray *_imageArr;
}

@end

@implementation RoomDetailTableHeader

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
    
    _propertyArr = [@[] mutableCopy];
    _tagArr = [@[] mutableCopy];
    
    _titleArr = [@[] mutableCopy];
    _imageArr = [@[] mutableCopy];
}

- (void)setReportArr:(NSMutableArray *)reportArr{
    
    if (reportArr.count) {
        
        for (int i = 0; i < reportArr.count; i++) {
            
            [_titleArr addObject:reportArr[i][@"comment"]];
            [_imageArr addObject:@"icon_xi"];
        }
        
        _advertScrollView.signImages = _imageArr;
        _advertScrollView.titles = _titleArr;
        [_titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(11 *SIZE);
            make.top.equalTo(_advertScrollView.mas_bottom).offset(11 *SIZE);
            make.width.mas_equalTo(280 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(321 *SIZE);
            make.top.equalTo(_advertScrollView.mas_bottom).offset(11 *SIZE);
            make.width.mas_equalTo(30 *SIZE);
        }];
        
        [_attentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(326 *SIZE);
            make.top.equalTo(_advertScrollView.mas_bottom).offset(28 *SIZE);
            make.width.height.mas_equalTo(29 *SIZE);
        }];
        
        [_attentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(230 *SIZE);
            make.top.equalTo(_advertScrollView.mas_bottom).offset(35 *SIZE);
            make.width.mas_equalTo(87 *SIZE);
        }];
    }else{
        
        [_titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self.contentView).offset(11 *SIZE);
            make.top.equalTo(_imgScroll.mas_bottom).offset(11 *SIZE);
            make.width.mas_equalTo(280 *SIZE);
        }];
        
        [_statusL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(321 *SIZE);
            make.top.equalTo(_imgScroll.mas_bottom).offset(11 *SIZE);
            make.width.mas_equalTo(30 *SIZE);
        }];
        
        [_attentBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(326 *SIZE);
            make.top.equalTo(_imgScroll.mas_bottom).offset(28 *SIZE);
            make.width.height.mas_equalTo(29 *SIZE);
        }];
        
        [_attentL mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(230 *SIZE);
            make.top.equalTo(_imgScroll.mas_bottom).offset(35 *SIZE);
            make.width.mas_equalTo(87 *SIZE);
        }];
    }
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _num = imgArr.count;
    if (imgArr.count) {
        
        _numL.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    }else{
        
        _numL.text = @"0/0";
    }
    [_imgScroll setContentSize:CGSizeMake(imgArr.count *SCREEN_Width, 202.5 *SIZE)];
    for (UIView *view in _imgScroll.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (imgArr.count) {
        
        for (int i = 0; i < imgArr.count; i++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, 202.5 *SIZE)];
            img.contentMode = UIViewContentModeScaleAspectFill;
            img.clipsToBounds = YES;
            NSString *imgname = imgArr[i][@"img_url"];
            if (imgname.length>0) {
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imgArr[i][@"img_url"]]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
                        
                        img.image = [UIImage imageNamed:@"banner_default_2"];
                    }
                }];
            }
            else{
                img.image = [UIImage imageNamed:@"banner_default_2"];

            }
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ActionImgBtn)];
            [img addGestureRecognizer:tap];
            img.userInteractionEnabled = YES;
            [_imgScroll addSubview:img];
        }
    }else{
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.image = [UIImage imageNamed:@"banner_default_2"];
        [_imgScroll addSubview:img];
    }
}

- (void)setModel:(RoomDetailModel *)model{
    
    if (model.developer_name) {
        
        _payL.text = [NSString stringWithFormat:@"开发商：%@",model.developer_name];
    }
    
    if (model.latitude) {
        _latitude = [model.latitude floatValue];
    }
    
    if (model.longitude) {
        _longitude = [model.longitude floatValue];
    }
    
    if (model.project_name) {
        
        _titleL.text = model.project_name;
    }
    
    if (model.absolute_address) {
        
        _addressL.text = model.absolute_address;
    }
    
    if (model.sale_state) {
        
        _statusL.text = [NSString stringWithFormat:@"%@",model.sale_state];
    }
    
//    [_wuyeview setData:model.property_type];
//    [_tagview setData:model.project_tags];
    _propertyArr = [NSMutableArray arrayWithArray:model.property_type];
    _tagArr = [NSMutableArray arrayWithArray:model.project_tags];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    if (model.average_price) {
        
        if (![model.average_price integerValue]) {
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 暂无数据"]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, attr.length)];
            [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, attr.length)];
            _priceL.attributedText = attr;
        }else{
            
            NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 ￥%@/㎡",model.average_price]];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
            [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, 1)];
            [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
            _priceL.attributedText = attr;
        }
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 "]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
        _priceL.attributedText = attr;
    }
}

- (void)ActionAttentBtn:(UIButton *)btn{
    
    if (self.attentBtnBlock) {
        
        self.attentBtnBlock();
    }
}

- (void)ActionImgBtn{
    
    if (self.imgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.imgBtnBlock(_nowNum, _imgArr);
            
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    _nowNum = scrollView.contentOffset.x / SCREEN_Width;
    _numL.text = [NSString stringWithFormat:@"%.0f/%ld",(scrollView.contentOffset.x / SCREEN_Width) + 1, (long)_num];
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
            
            [cell setStyleByType:@"0" lab:_propertyArr[indexPath.item]];
        }else{
            
            [cell setStyleByType:@"1" lab:_tagArr[indexPath.item]];
        }
    }
    
    return cell;
}

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imgScroll = [[UIScrollView alloc] init];//WithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 164.5 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = YJTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _advertScrollView = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 40 *SIZE)];
    [self.contentView addSubview:_advertScrollView];
    
    _titleL = [[UILabel alloc] init];//WithFrame:CGRectMake(11 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 13 *SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];//WithFrame:CGRectMake(321 *SIZE, 11 *SIZE + CGRectGetMaxY(_imgScroll.frame), 30 *SIZE, 12 *SIZE)];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    _attentBtn.frame = CGRectMake(326 *SIZE, 28 *SIZE + CGRectGetMaxY(_imgScroll.frame), 29 *SIZE, 29 *SIZE);
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:[UIImage imageNamed:@"Focus"] forState:UIControlStateNormal];
    [self.contentView addSubview:_attentBtn];
    
    _attentL = [[UILabel alloc] init];//WithFrame:CGRectMake(230 *SIZE, 35 *SIZE + CGRectGetMaxY(_imgScroll.frame), 87 *SIZE, 12 *SIZE)];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    _payL = [[UILabel alloc] init];//WithFrame:CGRectMake(10 *SIZE, 100 *SIZE + CGRectGetMaxY(_imgScroll.frame), 300 *SIZE, 12 *SIZE)];
    _payL.textColor = YJContentLabColor;
    _payL.font = [UIFont systemFontOfSize:12 *SIZE];
    _payL.text = [NSString stringWithFormat:@"开发商："];
    [self.contentView addSubview:_payL];
    
    
    _priceL = [[UILabel alloc] init];//WithFrame:CGRectMake(9 *SIZE, 123 *SIZE + CGRectGetMaxY(_imgScroll.frame), 280 *SIZE, 17 *SIZE)];
    _priceL.textColor = COLOR(250, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:16 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _addressImg = [[UIImageView alloc] init];//WithFrame:CGRectMake(11 *SIZE, 354.5 *SIZE, 16 *SIZE, 16 *SIZE)];
    _addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:_addressImg];
    
    _addressL = [[UILabel alloc] init];//WithFrame:CGRectMake(31 *SIZE, 155 *SIZE + CGRectGetMaxY(_imgScroll.frame), 250 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    _addressL.userInteractionEnabled = YES;
    [_addressL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_map)]];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 235.5 *SIZE, 225 *SIZE, 50 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
    [self.contentView addSubview:_moreBtn];
    
    [self masonryUI];
}

- (void)masonryUI{
    
    [_imgScroll mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(202.5 *SIZE);
    }];
    
    [_advertScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(_imgScroll.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(SCREEN_Width);
        make.height.mas_equalTo(40 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_advertScrollView.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(321 *SIZE);
        make.top.equalTo(_advertScrollView.mas_bottom).offset(11 *SIZE);
        make.width.mas_equalTo(30 *SIZE);
    }];
    
    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(326 *SIZE);
        make.top.equalTo(_advertScrollView.mas_bottom).offset(28 *SIZE);
        make.width.height.mas_equalTo(29 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(_advertScrollView.mas_bottom).offset(35 *SIZE);
        make.width.mas_equalTo(87 *SIZE);
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(9 *SIZE);
        make.width.equalTo(@(225 *SIZE));
        //        make.height.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];

    
    [_payL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(300 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_payL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(280 *SIZE);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(7.5 *SIZE);
        make.width.height.mas_equalTo(16 *SIZE);
    }];

    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(31 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(250 *SIZE);
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(287 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(9 *SIZE);
        make.width.mas_equalTo(65 *SIZE);
        make.height.mas_equalTo(20 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-11 *SIZE);
    }];
}

-(void)action_map
{
    //
    //    MapVC *next_vc = [[MapVC alloc]init];
    //    [[self viewController].navigationController pushViewController:next_vc animated:YES];
    CLLocationCoordinate2D endCoor = CLLocationCoordinate2DMake(_latitude, _longitude);
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endCoor addressDictionary:nil]];
    toLocation.name = _addressL.text;
    [MKMapItem openMapsWithItems:@[currentLocation, toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
}

@end
