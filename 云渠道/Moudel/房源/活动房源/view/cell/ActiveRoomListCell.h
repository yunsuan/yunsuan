//
//  ActiveRoomListCell.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ActiveRoomListCell : UITableViewCell

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UIView *specialView;

@property (nonatomic, strong) UILabel *specialL;

@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic, strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *typeL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
