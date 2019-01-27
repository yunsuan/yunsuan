//
//  LookMaintainDetailFollowCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LookMaintainDetailFollowCell : UITableViewCell

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *timeL;

@property (nonatomic, strong) UILabel *wayL;

@property (nonatomic, strong) UILabel *placeL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) UILabel *numL;

@property (nonatomic, strong) UILabel *nextTimeL;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
