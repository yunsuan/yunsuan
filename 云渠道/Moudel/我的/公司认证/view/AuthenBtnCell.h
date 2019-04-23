//
//  AuthenBtnCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AuthenBtnCellCommitBtnBlock)(void);

typedef void(^AuthenBtnCellDimissionBtnBlock)(void);

@interface AuthenBtnCell : UITableViewCell

@property (nonatomic, copy) AuthenBtnCellCommitBtnBlock authenBtnCellCommitBtnBlock;

@property (nonatomic, copy) AuthenBtnCellDimissionBtnBlock authenBtnCellDimissionBtnBlock;

@property (nonatomic, strong) UIButton *commitBtn;

@property (nonatomic, strong) UIButton *dimissionBtn;

@end

NS_ASSUME_NONNULL_END
