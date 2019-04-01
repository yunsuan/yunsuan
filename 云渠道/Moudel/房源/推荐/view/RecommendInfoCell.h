//
//  RecommendInfoCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/27.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RecommendInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendInfoCell : UITableViewCell

//@property (nonatomic, strong) RecommendInfoModel *model;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic , strong) UILabel *autherL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
