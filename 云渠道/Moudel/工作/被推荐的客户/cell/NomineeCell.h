//
//  NomineeCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NomineeCell;

typedef void(^messBtnBlock)(NSInteger index);

typedef void(^phoneBtnBlock)(NSInteger index);

typedef void(^confirmBtnBlock)(NSInteger index);

@interface NomineeCell : UITableViewCell

@property (nonatomic, copy) messBtnBlock messBtnBlock;

@property (nonatomic, copy) phoneBtnBlock phoneBtnBlock;

@property (nonatomic, copy) confirmBtnBlock confirmBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *reportTimeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *messBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
