//
//  ReStatusTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReStatusTableCellVisitBlock)(void);

typedef void(^ReStatusTableCellDealBlock)(void);

typedef void(^ReStatusTableCellCodeBlock)(void);

@interface ReStatusTableCell : UITableViewCell

@property (nonatomic, copy) ReStatusTableCellVisitBlock reStatusTableCellVisitBlock;

@property (nonatomic, copy) ReStatusTableCellDealBlock reStatusTableCellDealBlock;

@property (nonatomic, copy) ReStatusTableCellCodeBlock reStatusTableCellCodeBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *content1;

@property (nonatomic, strong) UILabel *content2;

@property (nonatomic, strong) UILabel *content3;

@property (nonatomic, strong) UILabel *content4;

@property (nonatomic, strong) UILabel *content5;

@property (nonatomic, strong) UIImageView *img1;

@property (nonatomic, strong) UIImageView *img2;

@property (nonatomic, strong) UIImageView *img3;

@property (nonatomic, strong) UIImageView *img4;

@property (nonatomic, strong) UIImageView *img5;

@property (nonatomic, strong) UIView *line1;

@property (nonatomic, strong) UIView *line2;

@property (nonatomic, strong) UIView *line3;

@property (nonatomic, strong) UIView *line4;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIButton *visitBtn;

@property (nonatomic, strong) UIButton *dealBtn;

@property (nonatomic, strong) UIButton *codeBtn;
@end
