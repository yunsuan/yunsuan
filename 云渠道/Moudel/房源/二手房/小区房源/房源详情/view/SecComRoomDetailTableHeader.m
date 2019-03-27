//
//  SecComRoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecComRoomDetailTableHeader.h"
#import <MapKit/MapKit.h>

@interface SecComRoomDetailTableHeader()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation SecComRoomDetailTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
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
            NSString *imageurl = imgArr[i][@"img_url"];
            if (imageurl.length>0) {
                [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,imageurl]] placeholderImage:[UIImage imageNamed:@"banner_default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
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

- (void)setModel:(SecAllRoomDetailHeaderModel *)model{

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

    
    _propertyArr = [NSMutableArray arrayWithArray:model.property_type];
    _tagArr = [NSMutableArray arrayWithArray:model.project_tags];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];


    if (model.average_price) {

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 ￥%@元/㎡",model.average_price]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
        _priceL.attributedText = attr;
    }else{

        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"均价 "]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
        _priceL.attributedText = attr;
    }

}

- (void)ActionAttentBtn:(UIButton *)btn{
    
//    if (self.attentBtnBlock) {
//        
//        self.attentBtnBlock();
//    }
}

- (void)ActionTagBtn:(UIButton *)btn{
    
    if (self.secComHeaderTagBlock) {
        
        self.secComHeaderTagBlock(btn.tag);
    }
}

- (void)ActionImgBtn{
    
    if (self.secAllDetailHeaderImgBtnBlock) {

        if (_imgArr.count) {

            self.secAllDetailHeaderImgBtnBlock(_nowNum, _imgArr);

        }
    }
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

- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
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
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 202.5 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 163.4 *SIZE, 30 *SIZE, 30 *SIZE)];
    _numL.backgroundColor = COLOR(255, 255, 255, 0.6);
    _numL.textColor = YJTitleLabColor;
    _numL.font = [UIFont systemFontOfSize:10 *SIZE];
    _numL.textAlignment = NSTextAlignmentCenter;
    _numL.layer.cornerRadius = 15 *SIZE;
    _numL.clipsToBounds = YES;
    _numL.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_numL];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _statusL = [[UILabel alloc] init];
    _statusL.textColor = COLOR(27, 152, 255, 1);
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _statusL.text = @"13123123";
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:[UIImage imageNamed:@"subscribe"] forState:UIControlStateNormal];
    _attentBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_attentBtn];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];

    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 216 *SIZE, 225 *SIZE, 50 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];

    _priceL = [[UILabel alloc] init];
    _priceL.textColor = COLOR(250, 70, 70, 1);
    _priceL.font = [UIFont systemFontOfSize:16 *SIZE];
    [self.contentView addSubview:_priceL];
    
    _addressImg = [[UIImageView alloc] init];
    _addressImg.image = [UIImage imageNamed:@"map"];
    [self.contentView addSubview:_addressImg];
    
    _addressL = [[UILabel alloc] init];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_addressL];
    _addressL.userInteractionEnabled = YES;
    [_addressL addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action_map)]];
    
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.titleLabel.font = [UIFont systemFontOfSize:11 *SIZE];
    [_moreBtn setTitle:@"查看更多 >>" forState:UIControlStateNormal];
    _moreBtn.tag = 4;
    [_moreBtn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn setTitleColor:YJContentLabColor forState:UIControlStateNormal];
//    [self.contentView addSubview:_moreBtn];
    
    _btnView = [[UIView alloc] initWithFrame:CGRectMake(0, 344 *SIZE, SCREEN_Width, 107 *SIZE)];
    _btnView.backgroundColor = [UIColor whiteColor];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width , SIZE)];
    line.backgroundColor = YJBackColor;
    [_btnView addSubview:line];
    
    NSArray *titleArr = @[@"发布房源",@"二手房源",@"二手成交",@"小区概述"];
    NSArray *imgArr = @[@"release",@"secondhand",@"clinch",@"summarize"];
    for (int i = 0; i < 4; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(22 *SIZE + i *89 *SIZE, 15 *SIZE, 47 *SIZE, 47 *SIZE)];
        img.image = [UIImage imageNamed:imgArr[i]];
        [_btnView addSubview:img];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_Width / 4 * i, 80 *SIZE, SCREEN_Width /4, 11 *SIZE)];
        label.textColor = YJTitleLabColor;
        label.font = [UIFont systemFontOfSize:12 *SIZE];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = titleArr[i];
        [_btnView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(17 *SIZE + i *89 *SIZE, 10 *SIZE, 57 *SIZE, 57 *SIZE);
        btn.tag = i + 1;
//        if (i != 3) {
        
            [btn addTarget:self action:@selector(ActionTagBtn:) forControlEvents:UIControlEventTouchUpInside];
//        }
        [_btnView addSubview:btn];
    }
    [self.contentView addSubview:_btnView];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(self.contentView).offset(212.5 *SIZE);
        make.right.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(320 *SIZE);
        make.top.equalTo(self.contentView).offset(212.5 *SIZE);
        make.width.mas_equalTo(40 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-43 *SIZE);
    }];
    
    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(self.contentView).offset(326 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(5 *SIZE);
        make.width.equalTo(@(29 *SIZE));
        make.height.equalTo(@(29 *SIZE));
    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(11 *SIZE);
        make.width.equalTo(@(225 *SIZE));
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(self.contentView).offset(-40 *SIZE);
    }];
    
    [_addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(11 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(13 *SIZE);
        make.width.equalTo(@(16 *SIZE));
        make.height.equalTo(@(16 *SIZE));
    }];
    
    [_addressL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(31 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(15 *SIZE);
        make.right.equalTo(self.contentView).offset(-40 *SIZE);
    }];
    
//    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(287 *SIZE);
//        make.top.equalTo(_priceL.mas_bottom).offset(15 *SIZE);
//        make.width.equalTo(@(65 *SIZE));
//        make.height.equalTo(@(20 *SIZE));
//    }];
    
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_addressL.mas_bottom).offset(17 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(107 *SIZE));
        make.bottom.equalTo(self.contentView).offset(0 *SIZE);

    }];
}


@end
