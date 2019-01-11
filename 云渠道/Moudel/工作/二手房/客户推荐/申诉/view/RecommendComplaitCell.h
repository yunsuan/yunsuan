//
//  RecommendComplaitCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/10.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendComplaitCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *storeL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *statusL;

@property (nonatomic, strong) UILabel *recommendTimeL;

@property (nonatomic, strong) UILabel *complaintTimeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
