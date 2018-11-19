//
//  SecdaryComTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecdaryComModel.h"

@interface SecdaryComTableCell : UITableViewCell

@property (nonatomic, strong) SecdaryComModel *model;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *onSaleL;

@property (nonatomic, strong) UILabel *attionL;

@property (nonatomic, strong) UIView *line;

@end
