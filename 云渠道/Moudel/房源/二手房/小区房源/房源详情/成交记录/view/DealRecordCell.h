//
//  DealRecordCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/12.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagView.h"

@interface DealRecordCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIImageView *statusImg;

//@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *averageL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UIView *line;

- (void)setData:(NSDictionary *)data;

@end
