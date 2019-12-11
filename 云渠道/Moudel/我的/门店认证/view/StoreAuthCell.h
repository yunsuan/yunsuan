//
//  StoreAuthCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreAuthCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UIImageView *rightImg;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
