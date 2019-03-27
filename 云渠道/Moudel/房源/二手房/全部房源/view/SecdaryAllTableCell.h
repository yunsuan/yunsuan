//
//  SecdaryAllTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecdaryAllTableModel.h"



@interface SecdaryAllTableCell : UITableViewCell

@property (nonatomic, strong) SecdaryAllTableModel *model;

@property (nonatomic, strong) UIView *hideView;

@property (nonatomic, strong) UILabel *hideL;

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) UILabel *roomLevelL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UIView *line;

- (void)SetTagArr:(NSArray *)data;

@end
