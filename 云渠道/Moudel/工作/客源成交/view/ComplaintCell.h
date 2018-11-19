//
//  ComplaintCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/8.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComplaintCell;

typedef void(^ComplaintCellCellPhoneBtnBlock)(NSInteger index);

@interface ComplaintCell : UITableViewCell

@property (nonatomic, copy) ComplaintCellCellPhoneBtnBlock complaintCellCellPhoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *recomTimeL;

@property (nonatomic, strong) UILabel *complainL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
