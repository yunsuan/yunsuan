//
//  ConfrimPhoneWaitCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ConfrimPhoneWaitCellBlock)(void);

@interface ConfrimPhoneWaitCell : UITableViewCell

@property (nonatomic, copy) ConfrimPhoneWaitCellBlock confrimPhoneWaitCellBlock;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) UIView *line;

@end

NS_ASSUME_NONNULL_END
