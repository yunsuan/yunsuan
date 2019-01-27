//
//  LookMaintainAddRoomCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/25.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainAddRoomCell : UITableViewCell

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *unitPriceL;

@property (nonatomic, strong) UILabel *seeWayL;

@property (nonatomic, strong) UILabel *line;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@end

NS_ASSUME_NONNULL_END
