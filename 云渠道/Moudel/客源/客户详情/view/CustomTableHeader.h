//
//  CustomTableHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/22.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerModel.h"

typedef void(^CustomTableHeaderEditBlock)(void);

typedef void(^CustomTableHeaderTagBlock)(NSInteger index);

@interface CustomTableHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) CustomTableHeaderEditBlock customTableHeaderEditBlock;

@property (nonatomic, copy) CustomTableHeaderTagBlock customTableHeaderTagBlock;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *proTypeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *genderL;

@property (nonatomic, strong) UILabel *birthL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *certL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UIButton *infoBtn;

@property (nonatomic, strong) UIButton *followBtn;

@property (nonatomic, strong) UIButton *matchBtn;

@property (nonatomic, strong) CustomerModel *model;



@end
