//
//  GetWorkCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GetWorkCell;

typedef void(^GetWorkCellBlock)(NSInteger index);

@interface GetWorkCell : UITableViewCell

@property (nonatomic, copy) GetWorkCellBlock getWorkCellBlock;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UILabel *sourceL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *communicateL;

@property (nonatomic, strong) UIButton *getBtn;

@property (nonatomic, strong) UIView *lineView;

@end
