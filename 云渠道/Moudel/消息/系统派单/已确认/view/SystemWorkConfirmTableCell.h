//
//  SystemWorkConfirmTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/25.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SystemWorkConfirmConfirmBlock)(NSInteger index);

@interface SystemWorkConfirmTableCell : UITableViewCell

@property (nonatomic, strong) SystemWorkConfirmConfirmBlock systemWorkConfirmConfirmBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *proTypeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *getTimeL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *DisableDic;

@end

NS_ASSUME_NONNULL_END
