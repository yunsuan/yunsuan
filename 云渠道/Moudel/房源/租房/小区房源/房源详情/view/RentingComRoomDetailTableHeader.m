//
//  RentingComRoomDetailTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/11/29.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "RentingComRoomDetailTableHeader.h"
#import <MapKit/MapKit.h>

@interface RentingComRoomDetailTableHeader()<UIScrollViewDelegate>
{
    NSInteger _num;
    NSInteger _nowNum;
    float _longitude;
    float _latitude;
}

@end

@implementation RentingComRoomDetailTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setImgArr:(NSMutableArray *)imgArr{
    
    _imgArr = [NSMutableArray arrayWithArray:imgArr];
    _num = imgArr.count;
    if (imgArr.count) {
        
        _numL.text = [NSString stringWithFormat:@"1/%lu",(unsigned long)imgArr.count];
    }else{
        
        _numL.text = @"0/0";
    }
    [_imgScroll setContentSize:CGSizeMake(imgArr.count *SCREEN_Width, 183 *SIZE)];
    for (UIView *view in _imgScroll.subviews) {
        
        [view removeFromSuperview];
    }
    
    if (imgArr.count) {
        
        for (int i = 0; i < imgArr.count; i++) {
            
            UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_Width * i, 0, SCREEN_Width, 183 *SIZE)];
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
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
        img.contentMode = UIViewContentModeScaleAspectFill;
        img.clipsToBounds = YES;
        img.image = [UIImage imageNamed:@"banner_default_2"];
        [_imgScroll addSubview:img];
    }
}

- (void)setModel:(SecAllRoomDetailHeaderModel *)model{
    //
    //    if (model.developer_name) {
    //
    //        _payL.text = [NSString stringWithFormat:@"开发商：%@",model.developer_name];
    //    }
    //
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
    
    //    if (model.sale_state) {
    //
    //        _statusL.text = [NSString stringWithFormat:@"%@",model.sale_state];
    //    }
    
    //    NSDictionary *configdic = [UserModelArchiver unarchive].Configdic;
    //    NSDictionary *dic =  [configdic valueForKey:[NSString stringWithFormat:@"%d",15]];
    //    NSArray *tempArr = dic[@"param"];
    //    NSMutableArray * arr = [[NSMutableArray alloc] init];
    //    NSArray *subArr = [model.project_tags componentsSeparatedByString:@","];
    //    for (int i = 0; i < subArr.count; i++) {
    //
    //        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //
    //            if ([obj[@"id"] integerValue] == [subArr[i] integerValue]) {
    //
    //                [arr addObject:obj[@"param"]];
    //                *stop = YES;
    //            }
    //        }];
    //    }
    
    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 216 *SIZE, 200*SIZE, 20 *SIZE)  type:@"0"];
    [_wuyeview setData:model.property_type];
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 245 *SIZE, 200 *SIZE, 20 *SIZE)  type:@"1"];
    [_tagview setData:model.project_tags];
    [self.contentView addSubview:_tagview];
    
    
    if (model.average_price) {
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"参考租金 ￥%@元/月",model.average_price]];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 *SIZE] range:NSMakeRange(0, 3)];
        [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 *SIZE] range:NSMakeRange(3, 1)];
        [attr addAttribute:NSForegroundColorAttributeName value:YJContentLabColor range:NSMakeRange(0, 3)];
        _priceL.attributedText = attr;
    }else{
        
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"参考价格 "]];
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
    
    if (self.rentingComHeaderTagBlock) {
        
        self.rentingComHeaderTagBlock(btn.tag);
    }
}

- (void)ActionImgBtn{
    
    if (self.rentingAllDetailHeaderImgBtnBlock) {
        
        if (_imgArr.count) {
            
            self.rentingAllDetailHeaderImgBtnBlock(_nowNum, _imgArr);
            
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

- (void)initUI{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _imgScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, 183 *SIZE)];
    _imgScroll.pagingEnabled = YES;
    _imgScroll.delegate = self;
    _imgScroll.showsVerticalScrollIndicator = NO;
    _imgScroll.showsHorizontalScrollIndicator = NO;
    _imgScroll.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_imgScroll];
    
    
    _numL = [[UILabel alloc] initWithFrame:CGRectMake(319 *SIZE, 144 *SIZE, 30 *SIZE, 30 *SIZE)];
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
    _statusL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_statusL];
    
    _attentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_attentBtn addTarget:self action:@selector(ActionAttentBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_attentBtn setImage:[UIImage imageNamed:@"subs"] forState:UIControlStateNormal];
    _attentBtn.userInteractionEnabled = NO;
    [self.contentView addSubview:_attentBtn];
    
    _attentL = [[UILabel alloc] init];
    _attentL.textColor = YJContentLabColor;
    _attentL.font = [UIFont systemFontOfSize:12 *SIZE];
    _attentL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_attentL];
    
    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake(10 *SIZE, 216 *SIZE, 200 *SIZE, 20 *SIZE)  type:@"0"];
    _wuyeview.collectionview.userInteractionEnabled = NO;
    _wuyeview.userInteractionEnabled = NO;
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake(10*SIZE, 245*SIZE, 200*SIZE, 20 *SIZE)  type:@"1"];
    _tagview.collectionview.userInteractionEnabled = NO;
    _tagview.userInteractionEnabled = NO;
    [self.contentView addSubview:_tagview];
    
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
    
    NSArray *titleArr = @[@"发布房源",@"租房房源",@"租房成交",@"小区概述"];
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
        make.top.equalTo(self.contentView).offset(193 *SIZE);
        make.right.equalTo(self.contentView).offset(-60 *SIZE);
    }];
    
    [_statusL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(320 *SIZE);
        make.top.equalTo(self.contentView).offset(193 *SIZE);
        make.right.equalTo(self.contentView).offset(-10 *SIZE);
    }];
    
    [_attentL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(230 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(14 *SIZE);
        make.right.equalTo(self.contentView).offset(-15 *SIZE);
    }];
    
    //    [_attentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self.contentView).offset(326 *SIZE);
    //        make.top.equalTo(_titleL.mas_bottom).offset(5 *SIZE);
    //        make.width.equalTo(@(29 *SIZE));
    //        make.height.equalTo(@(29 *SIZE));
    //    }];
    
    [_wuyeview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(11 *SIZE);
        make.width.equalTo(@(200 *SIZE));
        make.height.equalTo(@(20 *SIZE));
        make.top.equalTo(_tagview.mas_top).offset(-9 *SIZE);
    }];
    
    [_tagview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_wuyeview.mas_bottom).offset(9 *SIZE);
        make.width.equalTo(@(200 *SIZE));
        make.height.equalTo(@(20 *SIZE));
        make.bottom.equalTo(_priceL.mas_top).offset(-18 *SIZE);
    }];
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_tagview.mas_bottom).offset(18 *SIZE);
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
