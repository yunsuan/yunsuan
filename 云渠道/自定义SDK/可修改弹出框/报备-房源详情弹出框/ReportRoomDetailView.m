//
//  ReportRoomDetailView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReportRoomDetailView.h"

@implementation ReportRoomDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionCancelBtn:(UIButton *)btn{
    
    [self removeFromSuperview];
}

- (void)ActionConfirmBtn:(UIButton *)btn{
    
    if (self.reportRoomDetailBlock) {
    
        self.reportRoomDetailBlock();
        [self removeFromSuperview];
    }
}

- (void)initUI{
    
    UIView *alphaView = [[UIView alloc] initWithFrame:self.frame];
    alphaView.backgroundColor = [UIColor blackColor];
    alphaView.alpha = 0.4;
    [self addSubview:alphaView];
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CH_COLOR_white;
    _whiteView.layer.cornerRadius = 3 *SIZE;
    _whiteView.clipsToBounds = YES;
    [self addSubview:_whiteView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:15 *SIZE];
    _titleL.numberOfLines = 0;
    _titleL.textAlignment = NSTextAlignmentCenter;
    [_whiteView addSubview:_titleL];
    
    _blueView = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [_whiteView addSubview:_blueView];
    
    _blueView2 = [[UIView alloc] init];
    _blueView.backgroundColor = YJBlueBtnColor;
    [_whiteView addSubview:_blueView2];
    
    _room = [[UILabel alloc] init];
    _room.textColor = YJTitleLabColor;
    _room.font = [UIFont systemFontOfSize:13 *SIZE];
    _room.numberOfLines = 0;
    [_whiteView addSubview:_room];
    
    _typeL = [[UILabel alloc] init];
    _typeL.textColor = YJTitleLabColor;
    _typeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _typeL.numberOfLines = 0;
    [_whiteView addSubview:_typeL];
    
    _roomNumL = [[UILabel alloc] init];
    _roomNumL.textColor = YJContentLabColor;
    _roomNumL.font = [UIFont systemFontOfSize:12 *SIZE];
    _roomNumL.numberOfLines = 0;
    [_whiteView addSubview:_roomNumL];
    
    _buildL = [[UILabel alloc] init];
    _buildL.textColor = YJContentLabColor;
    _buildL.font = [UIFont systemFontOfSize:12 *SIZE];
    _buildL.numberOfLines = 0;
    [_whiteView addSubview:_buildL];
    
    _unitL = [[UILabel alloc] init];
    _unitL.textColor = YJContentLabColor;
    _unitL.font = [UIFont systemFontOfSize:12 *SIZE];
    _unitL.numberOfLines = 0;
    [_whiteView addSubview:_unitL];
    
    _floorL = [[UILabel alloc] init];
    _floorL.textColor = YJContentLabColor;
    _floorL.font = [UIFont systemFontOfSize:12 *SIZE];
    _floorL.numberOfLines = 0;
    [_whiteView addSubview:_floorL];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = YJBackColor;
    [_whiteView addSubview:_lineView];
    
    _areaL = [[UILabel alloc] init];
    _areaL.textColor = YJContentLabColor;
    _areaL.font = [UIFont systemFontOfSize:12 *SIZE];
    _areaL.numberOfLines = 0;
    [_whiteView addSubview:_areaL];
    
    _areaL2 = [[UILabel alloc] init];
    _areaL2.textColor = YJContentLabColor;
    _areaL2.font = [UIFont systemFontOfSize:12 *SIZE];
    _areaL2.numberOfLines = 0;
    [_whiteView addSubview:_areaL2];
    
    _infoL = [[UILabel alloc] init];
    _infoL.textColor = YJContentLabColor;
    _infoL.font = [UIFont systemFontOfSize:12 *SIZE];
    _infoL.numberOfLines = 0;
    [_whiteView addSubview:_infoL];

    _cancenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancenBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_cancenBtn addTarget:self action:@selector(ActionCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_cancenBtn setTitle:@"考虑一下" forState:UIControlStateNormal];
    [_cancenBtn setTitleColor:YJ86Color forState:UIControlStateNormal];
    [_cancenBtn setBackgroundColor:COLOR(238, 238, 238, 1)];
    [_whiteView addSubview:_cancenBtn];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:14 *sIZE];
    [_confirmBtn addTarget:self action:@selector(ActionConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setBackgroundColor:YJBlueBtnColor];
    [_whiteView addSubview:_confirmBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self).offset(47 *SIZE);
        make.top.equalTo(self).offset(96 *SIZE);
        make.width.mas_equalTo(267 *SIZE);
    }];
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(10 *SIZE);
        make.top.equalTo(_whiteView).offset(18 *SIZE);
        make.right.equalTo(_whiteView).offset(-10 *SIZE);
    }];
    
    [_blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(32 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_room mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(16 *SIZE);
        make.top.equalTo(_titleL.mas_bottom).offset(32 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_roomNumL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(42 *SIZE);
        make.top.equalTo(_room.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(42 *SIZE);
        make.top.equalTo(_roomNumL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_unitL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(42 *SIZE);
        make.top.equalTo(_buildL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_floorL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(42 *SIZE);
        make.top.equalTo(_unitL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_floorL.mas_bottom).offset(17 *SIZE);
        make.width.mas_equalTo(267 *SIZE);
        make.height.mas_equalTo(1 *SIZE);
    }];
    
    [_blueView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_lineView.mas_bottom).offset(19 *SIZE);
        make.width.mas_equalTo(7 *SIZE);
        make.height.mas_equalTo(13 *SIZE);
    }];
    
    [_typeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(16 *SIZE);
        make.top.equalTo(_lineView.mas_bottom).offset(19 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_areaL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(17 *SIZE);
        make.top.equalTo(_typeL.mas_bottom).offset(20 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_areaL2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(17 *SIZE);
        make.top.equalTo(_areaL.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_infoL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(17 *SIZE);
        make.top.equalTo(_areaL2.mas_bottom).offset(18 *SIZE);
        make.right.equalTo(_whiteView).offset(-16 *SIZE);
    }];
    
    [_cancenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(0 *SIZE);
        make.top.equalTo(_infoL.mas_bottom).offset(38 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(133 *SIZE);
        make.height.mas_equalTo(43 *SIZE);
    }];
    
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(134 *SIZE);
        make.top.equalTo(_infoL.mas_bottom).offset(38 *SIZE);
        make.bottom.equalTo(_whiteView).offset(0 *SIZE);
        make.width.mas_equalTo(133 *SIZE);
        make.height.mas_equalTo(43 *SIZE);
    }];
}

@end
