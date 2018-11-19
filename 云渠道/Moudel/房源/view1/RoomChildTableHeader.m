//
//  RoomChildTableHeader.m
//  云渠道
//
//  Created by 谷治墙 on 2018/9/13.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "RoomChildTableHeader.h"

@implementation RoomChildTableHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)ActionRoomListBtn:(UIButton *)btn{
    
    if (self.roomChildTableHeaderRoomBlock) {
        
        self.roomChildTableHeaderRoomBlock();
    }
}

- (void)ActionComListBtn:(UIButton *)btn{
    
    if (self.roomChildTableHeaderComBlock) {
        
        self.roomChildTableHeaderComBlock();
    }
}

- (void)initUI{
    
    _whiteView = [[UIView alloc] init];
    _whiteView.backgroundColor = CH_COLOR_white;
    [self.contentView addSubview:_whiteView];
    
    _roomListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *roomImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53 *SIZE, 53 *SIZE)];
    roomImg.layer.cornerRadius = 26.5 *SIZE;
    roomImg.clipsToBounds = YES;
    roomImg.image = [UIImage imageNamed:@"all"];
    [_roomListBtn addSubview:roomImg];
    
    UILabel *roomL = [[UILabel alloc] initWithFrame:CGRectMake(0, 61 *SIZE, 53 *SIZE, 11 *SIZE)];
    roomL.textColor = YJ86Color;
    roomL.font = [UIFont systemFontOfSize:12 *SIZE];
    roomL.textAlignment = NSTextAlignmentCenter;
    roomL.text = @"房源列表";
    [_roomListBtn addSubview:roomL];

    [_roomListBtn addTarget:self action:@selector(ActionRoomListBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_whiteView addSubview:_roomListBtn];
    
    _comListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_comListBtn addTarget:self action:@selector(ActionComListBtn:) forControlEvents:UIControlEventTouchUpInside];
    UIImageView *comImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 53 *SIZE, 53 *SIZE)];
    comImg.layer.cornerRadius = 26.5 *SIZE;
    comImg.clipsToBounds = YES;
    comImg.image = [UIImage imageNamed:@"community"];
    [_comListBtn addSubview:comImg];
    
    UILabel *comL = [[UILabel alloc] initWithFrame:CGRectMake(0, 61 *SIZE, 53 *SIZE, 11 *SIZE)];
    comL.textColor = YJ86Color;
    comL.font = [UIFont systemFontOfSize:12 *SIZE];
    comL.textAlignment = NSTextAlignmentCenter;
    comL.text = @"小区列表";
    [_comListBtn addSubview:comL];
    [_whiteView addSubview:_comListBtn];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(0);
        make.width.mas_equalTo(SCREEN_Width);
        make.bottom.equalTo(self.contentView).offset(0);
    }];
    
    [_roomListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_whiteView).offset(67 *SIZE);
        make.top.equalTo(_whiteView).offset(6 *SIZE);
        make.width.mas_equalTo(53 *SIZE);
        make.height.mas_equalTo(81 *SIZE);
        make.bottom.equalTo(_whiteView).offset(-6 *SIZE);
    }];
    
    [_comListBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(_whiteView).offset(240 *SIZE);
        make.top.equalTo(_whiteView).offset(6 *SIZE);
        make.width.mas_equalTo(53 *SIZE);
        make.height.mas_equalTo(81 *SIZE);
    }];
    
}

@end
