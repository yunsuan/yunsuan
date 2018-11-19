//
//  SystemWorkWaitTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/10/24.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SystemWorkWaitConfirmBlock)(NSInteger index);

@interface SystemWorkWaitTableCell : UITableViewCell

@property (nonatomic, strong) SystemWorkWaitConfirmBlock systemWorkWaitConfirmBlock;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *proTypeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UIButton *confirmBtn;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
