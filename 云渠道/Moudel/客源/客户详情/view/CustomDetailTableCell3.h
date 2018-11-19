//
//  CustomDetailTableCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/30.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "LevelView.h"
#import "RankView.h"

@class CustomDetailTableCell3;

typedef void(^RecommendBtnBlock3)(NSInteger index);

@interface CustomDetailTableCell3 : UITableViewCell

@property (nonatomic, copy) RecommendBtnBlock3 recommendBtnBlock3;

@property (nonatomic , strong) UILabel *titleL;

@property (nonatomic , strong) UIImageView *headImg;

@property (nonatomic , strong) UILabel *addressL;

@property (nonatomic , strong) UILabel *rateL;

@property (nonatomic, strong) UIButton *recommentBtn;

@property (nonatomic , strong) TagView *tagview;

@property (nonatomic , strong) TagView *wuyeview;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) RankView *rankView;

@property (nonatomic, strong) LevelView *getLevel;

- (void)settagviewWithdata:(NSArray *)data;

@end
