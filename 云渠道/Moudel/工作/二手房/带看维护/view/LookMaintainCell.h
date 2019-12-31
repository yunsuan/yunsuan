//
//  LookMaintainCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainCell : UITableViewCell

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *genderImg;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *matchL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *progressL;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *agentL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
