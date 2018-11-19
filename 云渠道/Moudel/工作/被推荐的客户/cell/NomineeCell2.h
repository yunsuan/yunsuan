//
//  NomineeCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^phoneBtnBlock)(NSInteger index);

@interface NomineeCell2 : UITableViewCell

@property (nonatomic, copy) phoneBtnBlock phoneBtnBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *reportTimeL;

@property (nonatomic, strong) UIButton *phoneBtn;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end
