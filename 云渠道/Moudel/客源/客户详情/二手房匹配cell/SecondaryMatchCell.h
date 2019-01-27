//
//  SecondaryMatchCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SecondaryMatchCell : UITableViewCell

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *storeAllL;

@property (nonatomic, strong) UILabel *roomL;

@property (nonatomic, strong) UILabel *roomSeeL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
