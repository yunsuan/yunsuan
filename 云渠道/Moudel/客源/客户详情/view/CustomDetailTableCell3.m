//
//  CustomDetailTableCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "CustomDetailTableCell3.h"

@implementation CustomDetailTableCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)settagviewWithdata:(NSArray *)data{
    [_wuyeview setData:data[0]];
    [_tagview setData:data[1]];
   
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
    
    _wuyeview = [[TagView alloc]initWithFrame:CGRectMake((CGFloat)124.7*SIZE,(CGFloat) 66.7*SIZE, 150*SIZE,(CGFloat) 16.7*SIZE)  type:@"0"];
    [self.contentView addSubview:_wuyeview];
    
    _tagview = [[TagView alloc]initWithFrame:CGRectMake((CGFloat)124.7*SIZE, 88*SIZE, 150*SIZE,(CGFloat) 16.7*SIZE)  type:@"1"];
    [self.contentView addSubview:_tagview];
    
    [_tagview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(125 *SIZE);
        make.top.equalTo(self.contentView).offset(88 *SIZE);
        make.width.equalTo(@(150 *SIZE));
        make.height.equalTo(@(17 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-16 *SIZE);
        
    }];
    UIView *lane = [[UIView alloc]initWithFrame:CGRectMake(0*SIZE, 119*SIZE, 360*SIZE, 1*SIZE)];
    lane.backgroundColor = YJBackColor;
    [self.contentView addSubview:lane];

}

@end
