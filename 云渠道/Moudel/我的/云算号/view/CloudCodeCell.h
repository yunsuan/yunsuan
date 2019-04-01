//
//  CloudCodeCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/4/1.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CloudCodeCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *identifyL;

@property (nonatomic, strong) UILabel *briefL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;
@end

NS_ASSUME_NONNULL_END
