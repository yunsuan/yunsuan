//
//  RecommendFailCell1.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/21.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RecommendFailCell1 : UITableViewCell

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UILabel *phoneL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *houseCodeL;

@property (nonatomic, strong) UILabel *recommendTimeL;

@property (nonatomic, strong) UILabel *failTimeL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
