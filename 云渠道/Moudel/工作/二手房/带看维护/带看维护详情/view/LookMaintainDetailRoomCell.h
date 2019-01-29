//
//  LookMaintainDetailRoomCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailRoomCell : UITableViewCell

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *satisfyL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *compL;

@property (nonatomic, strong) UILabel *firstTimeL;

@property (nonatomic, strong) UILabel *lastTimeL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) NSMutableDictionary *data;

@end

NS_ASSUME_NONNULL_END
