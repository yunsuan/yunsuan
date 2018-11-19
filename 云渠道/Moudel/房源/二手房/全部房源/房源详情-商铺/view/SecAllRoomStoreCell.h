//
//  SecAllRoomStoreCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/9/27.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SecAllRoomStoreModel.h"

#import "TagView.h"

NS_ASSUME_NONNULL_BEGIN

@interface SecAllRoomStoreCell : UITableViewCell

@property (nonatomic, strong) SecAllRoomStoreModel *model;

@property (nonatomic, strong) TagView *tagView;

@property (nonatomic, strong) TagView *tagView2;

@property (nonatomic, strong) UILabel *codeL;//房源编号

@property (nonatomic, strong) UILabel *priceL;//单价

@property (nonatomic, strong) UILabel *proLimitL;//拿证时间

@property (nonatomic, strong) UILabel *yearL;//产权年限

@property (nonatomic, strong) UILabel *rentL;//当前租金

@property (nonatomic, strong) UILabel *reRentL;//参考租金

@property (nonatomic, strong) UILabel *endTimeL;//租期结束时间

@property (nonatomic, strong) UILabel *formatL;//适合业态

@property (nonatomic, strong) UIView *markView;

@property (nonatomic, strong) UILabel *markL;

@end

NS_ASSUME_NONNULL_END
