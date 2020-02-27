//
//  ActionRoomDetailRecommendCell.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/27.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionRoomDetailRecommendCellBlock)(NSString *title, NSString *content);

@interface ActionRoomDetailRecommendCell : UITableViewCell

@property (nonatomic, copy) ActionRoomDetailRecommendCellBlock actionRoomDetailRecommendCellBlock;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

@property (nonatomic, strong) BorderTF *titleTF;

@property (nonatomic, strong) UITextView *contentTV;

@end

NS_ASSUME_NONNULL_END
