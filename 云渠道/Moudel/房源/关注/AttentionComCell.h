//
//  AttentionComCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AttetionComModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttentionComCell : UITableViewCell

@property (nonatomic, strong) AttetionComModel *model;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *onSaleL;

@property (nonatomic, strong) UILabel *attionL;

@property (nonatomic, strong) UILabel *reasonL;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
