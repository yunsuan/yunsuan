//
//  TeamInfoView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/8/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "TeamInfoView.h"

@implementation TeamInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{

    [self removeFromSuperview];
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.bounds];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    alphaView.userInteractionEnabled = YES;
    [self addSubview:alphaView];
    
    _backImg = [[UIImageView alloc] initWithFrame:CGRectMake(13 *SIZE, 181 *SIZE, 333 *SIZE, 217 *SIZE)];
    _backImg.image = [UIImage imageNamed:@"blue1"];
    [self addSubview:_backImg];
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(142 *SIZE, 12 *SIZE, 50 *SIZE, 50 *SIZE)];
    _headImg.backgroundColor = [UIColor greenColor];
    _headImg.layer.cornerRadius = 25 *SIZE;
    _headImg.clipsToBounds = YES;
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    [_backImg addSubview:_headImg];
    
    
    _tagImg = [[UIImageView alloc] initWithFrame:CGRectMake(131 *SIZE, 70 *SIZE, 77 *SIZE, 28 *SIZE)];
    _tagImg.image = [UIImage imageNamed:@"tag"];
    [_backImg addSubview:_tagImg];
    
    _genderImg = [[UIImageView alloc] initWithFrame:CGRectMake(9 *SIZE, 9 *SIZE, 9 *SIZE, 9 *SIZE)];
    //    _genderImg.image = [UIImage imageNamed:@"man"];
    [_tagImg addSubview:_genderImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(23 *SIZE, 8 *SIZE, 40 *SIZE, 10 *SIZE)];
    _nameL.textColor = CH_COLOR_white;
    _nameL.font = [UIFont systemFontOfSize:11 *SIZE];
    [_tagImg addSubview:_nameL];
    
    _YSlable = [[UILabel alloc]initWithFrame:CGRectMake(21 *SIZE, 115*SIZE, 130 *SIZE, 11*SIZE)];
    _YSlable.font = [UIFont systemFontOfSize:12*SIZE];
    _YSlable.textColor = YJTitleLabColor;
    [_backImg addSubview:_YSlable];
    
    _companyL = [[UILabel alloc]initWithFrame:CGRectMake(21 *SIZE, 143*SIZE, 130 *SIZE, 11*SIZE)];
    _companyL.font = [UIFont systemFontOfSize:12*SIZE];
    _companyL.textColor = YJTitleLabColor;
    [_backImg addSubview:_companyL];
    
    _phoneL = [[UILabel alloc]initWithFrame:CGRectMake(179 *SIZE, 115*SIZE, 150 *SIZE, 11*SIZE)];
    _phoneL.font = [UIFont systemFontOfSize:12*SIZE];
    _phoneL.textColor = YJTitleLabColor;
    [_backImg addSubview:_phoneL];
    
    _yearL = [[UILabel alloc]initWithFrame:CGRectMake(179 *SIZE, 143*SIZE, 150 *SIZE, 11*SIZE)];
    _yearL.font = [UIFont systemFontOfSize:12*SIZE];
    _yearL.textColor = YJTitleLabColor;
    [_backImg addSubview:_yearL];
    
}

@end
