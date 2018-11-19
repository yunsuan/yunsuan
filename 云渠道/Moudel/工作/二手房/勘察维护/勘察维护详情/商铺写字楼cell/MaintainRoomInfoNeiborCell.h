//
//  MaintainRoomInfoNeiborCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MaintainRoomInfoNeiborCell : UITableViewCell

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, strong) UILabel *leftL;

@property (nonatomic, strong) UILabel *rightL;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *markL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
