//
//  CustomDetailTableCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell3.h"

@interface CustomDetailTableCell3 ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    
    NSMutableArray *_propertyArr;
    NSMutableArray *_tagArr;
}

@end

@implementation CustomDetailTableCell3

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

- (void)settagviewWithdata:(NSArray *)data{
    
    _propertyArr = [NSMutableArray arrayWithArray:data[0]];
    _tagArr = [NSMutableArray arrayWithArray:data[1]];
    [_propertyColl reloadData];
    
    [_propertyColl mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    if (!_propertyArr.count && !_tagArr.count) {
        
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0 *SIZE);
            make.top.equalTo(_headImg.mas_bottom).offset(10 *SIZE);
            make.right.equalTo(self.contentView).offset(0 *SIZE);
            make.height.equalTo(@(SIZE));
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }else{
        
        [_line mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(0 *SIZE);
            make.top.equalTo(_propertyColl.mas_bottom).offset(5 *SIZE);
            make.right.equalTo(self.contentView).offset(0 *SIZE);
            make.height.equalTo(@(SIZE));
            make.bottom.equalTo(self.contentView).offset(0);
        }];
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _titleL.text = dataDic[@"project_name"];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"匹配度：%@%@",dataDic[@"score"],@"%"]];
    [attr addAttribute:NSForegroundColorAttributeName value:YJ86Color range:NSMakeRange(0, 4)];
    _rateL.attributedText = attr;
    
    NSString *imgname =dataDic[@"img_url"];
    if (imgname.length>0) {
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,dataDic[@"img_url"]]] placeholderImage:[UIImage imageNamed:@"default_1"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image = [UIImage imageNamed:@"default_1"];
            }
            
        }];
    }else{
        _headImg.image = [UIImage imageNamed:@"default_1"];

    }

    
    _addressL.text = [NSString stringWithFormat:@"%@",dataDic[@"absolute_address"]];
    
    if (dataDic[@"sort"]) {
        
        _rankView.rankL.text = [NSString stringWithFormat:@"佣金:第%@名",dataDic[@"sort"]];
    }else{
        
        _rankView.rankL.text = [NSString stringWithFormat:@"佣金:无排名"];
    }
    [_rankView.rankL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_rankView).offset(0);
        make.top.equalTo(_rankView).offset(0);
        make.height.equalTo(@(10 *SIZE));
        make.width.equalTo(@(_rankView.rankL.mj_textWith + 5 *SIZE));
    }];
    if ([dataDic[@"brokerSortCompare"] integerValue] == 0) {
        
        _rankView.statusImg.image = nil;
    }else if ([dataDic[@"brokerSortCompare"] integerValue] == 1){
        
        _rankView.statusImg.image = [UIImage imageNamed:@"rising"];
    }else if ([dataDic[@"brokerSortCompare"] integerValue] == 2){
        
        _rankView.statusImg.image = [UIImage imageNamed:@"falling"];
    }
    [_getLevel SetImage:[UIImage imageNamed:@"lightning_1"] selectImg:[UIImage imageNamed:@"lightning"] num:[dataDic[@"cycle"] integerValue]];
//    NSArray *arr = [dataDic[@"project_tags"] componentsSeparatedByString:@","];
//    self settagviewWithdata:<#(NSArray *)#>
}

- (void)ActionRecommendBtn:(UIButton *)btn{
    
    if (self.recommendBtnBlock3) {
        
        self.recommendBtnBlock3(self.tag);
    }
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
        
        return _tagArr.count > 2 ? 2:_tagArr.count;
    }else{
        
        if (_propertyArr.count) {
            
            return _propertyArr.count > 2 ? 2:_propertyArr.count;
        }else{
            
            return _tagArr.count > 2 ? 2:_tagArr.count;
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
    
    _headImg = [[UIImageView alloc]initWithFrame:CGRectMake((CGFloat) (11.7*SIZE),(CGFloat)16.3*SIZE, 100*SIZE, (CGFloat)88.3*SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake((CGFloat)123.3*SIZE, 16*SIZE, 140*SIZE, 14*SIZE)];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont boldSystemFontOfSize:(CGFloat)13.3*SIZE];
    [self.contentView addSubview:_titleL];
    
    _addressL = [[UILabel alloc]initWithFrame:CGRectMake((CGFloat)124.3*SIZE, (CGFloat)52.7*SIZE, 200*SIZE, 11*SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font =[UIFont systemFontOfSize:(CGFloat)10.7*SIZE];
    [self.contentView addSubview:_addressL];
    
    _rateL = [[UILabel alloc]initWithFrame:CGRectMake(247 *SIZE,(CGFloat) 15.7*SIZE, 100*SIZE, 13*SIZE)];
    _rateL.textColor = COLOR(27, 152, 255, 1);
    _rateL.font = [UIFont systemFontOfSize:12*SIZE];
    _rateL.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_rateL];
    
    _recommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _recommentBtn.frame = CGRectMake(281 *SIZE, 67 *SIZE, 67 *SIZE, 30 *SIZE);
    _recommentBtn.titleLabel.font = [UIFont systemFontOfSize:14 *SIZE];
    [_recommentBtn addTarget:self action:@selector(ActionRecommendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_recommentBtn setTitle:@"推荐" forState:UIControlStateNormal];
    [_recommentBtn setBackgroundColor:YJBlueBtnColor];
    if ([[UserModel defaultModel].agent_identity integerValue] == 1) {
        
        [self.contentView addSubview:_recommentBtn];
    }
    [self.contentView addSubview:_recommentBtn];
//    [_recommentBtn setTitleColor:COLOR(<#_R#>, <#_G#>, <#_B#>, <#_A#>) forState:UIControlStateNormal];
    
    
    _rankView = [[RankView alloc] initWithFrame:CGRectMake(123 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    [self.contentView addSubview:_rankView];
    
    _getLevel = [[LevelView alloc] initWithFrame:CGRectMake(217 *SIZE, 36 *SIZE, 80 *SIZE, 12 *SIZE)];
    _getLevel.titleL.text = @"结佣";
    [self.contentView addSubview:_getLevel];
    
    _propertyFlowLayout = [[GZQFlowLayout alloc] initWithType:AlignWithLeft betweenOfCell:4 *SIZE];
    _propertyFlowLayout.itemSize = CGSizeMake(65 *SIZE, 17 *SIZE);
    
    _propertyColl = [[UICollectionView alloc] initWithFrame:CGRectMake(10 *SIZE, 90 *SIZE, 340 *SIZE, 40 *SIZE) collectionViewLayout:_propertyFlowLayout];
    _propertyColl.backgroundColor = [UIColor whiteColor];
    _propertyColl.delegate = self;
    _propertyColl.dataSource = self;
    [_propertyColl registerClass:[TagCollCell class] forCellWithReuseIdentifier:@"TagCollCell"];
    [self.contentView addSubview:_propertyColl];
    
    
    _line = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
    _line.backgroundColor = YJBackColor;
    [self.contentView addSubview:_line];

    
//    [_tagview mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.contentView).offset(125 *SIZE);
//        make.top.equalTo(self.contentView).offset(88 *SIZE);
//        make.width.equalTo(@(150 *SIZE));
//        make.height.equalTo(@(17 *SIZE));
//        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
//        
//    }];
    
    [_propertyColl mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self.contentView).offset(88 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        //        make.height.mas_equalTo(40 *SIZE);
        make.height.mas_equalTo(_propertyColl.collectionViewLayout.collectionViewContentSize.height + 5 *SIZE);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(0 *SIZE);
        make.top.equalTo(_propertyColl.mas_bottom).offset(5 *SIZE);
        make.right.equalTo(self.contentView).offset(0 *SIZE);
        make.height.equalTo(@(SIZE));
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

@end
