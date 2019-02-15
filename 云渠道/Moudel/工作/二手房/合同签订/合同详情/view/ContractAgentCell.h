//
//  ContractAgentCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContractAgentCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headerImg;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
