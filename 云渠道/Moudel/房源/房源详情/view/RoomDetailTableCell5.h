//
//  RoomDetailTableCell5.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomMatchModel.h"

@class RoomDetailTableCell5;

typedef void(^RecommendBtnBlock5)(NSInteger index);

@interface RoomDetailTableCell5 : UITableViewCell

@property (nonatomic, copy) RecommendBtnBlock5 recommendBtnBlock5;

@property (nonatomic, strong) UIImageView *gender; //头像

@property (nonatomic, strong) UILabel *nameL;//姓名

@property (nonatomic, strong) UILabel *priceL;//总价

@property (nonatomic, strong) UILabel *typeL;//户型

@property (nonatomic, strong) UILabel *areaL;//区域

@property (nonatomic, strong) UILabel *matchRateL;//匹配度

@property (nonatomic, strong) UILabel *phoneL;//电话

@property (nonatomic, strong) UILabel *intentionRateL;//意向度

@property (nonatomic, strong) UILabel *urgentRateL;//紧迫度

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) CustomMatchModel *model;

@end
