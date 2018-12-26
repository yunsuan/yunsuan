//
//  RentingAllRoomOfficeCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagView.h"
#import "RentingAllRoomOfficeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RentingAllRoomOfficeCell : UITableViewCell

@property (nonatomic, strong) RentingAllRoomOfficeModel *model;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UILabel *transferL;

@property (nonatomic, strong) UILabel *depositL;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *rentTypeL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *minPeriodL;

@property (nonatomic, strong) UILabel *maxPeriodL;

@property (nonatomic, strong) UILabel *inTimeL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *rentFreeL;

@property (nonatomic, strong) UILabel *commercailL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
