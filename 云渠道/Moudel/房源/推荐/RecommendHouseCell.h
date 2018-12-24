//
//  RecommendHouseCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/21.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecommendHouseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendHouseCell : UITableViewCell

@property (nonatomic, strong) RecommendHouseModel *model;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
