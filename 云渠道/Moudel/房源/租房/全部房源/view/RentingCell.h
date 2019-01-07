//
//  RentingCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "RentingAllTableModel.h"

@interface RentingCell : UITableViewCell

@property (nonatomic, strong) RentingAllTableModel *model;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UIView *line;


@end
