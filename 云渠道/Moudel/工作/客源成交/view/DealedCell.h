//
//  DealedCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DealedCell;

typedef void(^DealedCellPhoneBtnBlock)(NSInteger index);

@interface DealedCell : UITableViewCell

@property (nonatomic, copy) DealedCellPhoneBtnBlock dealedCellPhoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *dealTimeL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
