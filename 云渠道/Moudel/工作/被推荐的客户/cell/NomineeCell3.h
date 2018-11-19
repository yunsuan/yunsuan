//
//  NomineeCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/10.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NomineeCell3;

typedef void(^messBtnBlock)(NSInteger index);

typedef void(^phoneBtnBlock)(NSInteger index);

@interface NomineeCell3 : UITableViewCell

@property (nonatomic, copy) messBtnBlock messBtnBlock;

@property (nonatomic, copy) phoneBtnBlock phoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *reportTimeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *messBtn;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
