//
//  RentingAllRoomTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RentingAllRoomProjectModel.h"

#import "TagView.h"

@interface RentingAllRoomTableCell : UITableViewCell

@property (nonatomic, strong) RentingAllRoomProjectModel *model;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *liftL;

@property (nonatomic, strong) UILabel *seeL;

@property (nonatomic, strong) UILabel *decorateL;

@property (nonatomic, strong) UILabel *faceL;

@property (nonatomic, strong) UILabel *intentL;

@property (nonatomic, strong) UILabel *urgentL;

@end
