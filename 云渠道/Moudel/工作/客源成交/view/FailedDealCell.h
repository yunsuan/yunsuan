//
//  FailedDealCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FailedDealCell;

typedef void(^FailedDealCellPhoneBtnBlock)(NSInteger index);

@interface FailedDealCell : UITableViewCell

@property (nonatomic, copy) FailedDealCellPhoneBtnBlock failedDealCellPhoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *recommendTimeL;

@property (nonatomic, strong) UILabel *invalidTimeL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
