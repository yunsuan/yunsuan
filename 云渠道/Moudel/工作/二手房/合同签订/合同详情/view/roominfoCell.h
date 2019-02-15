//
//  roominfoCell.h
//  云渠道
//
//  Created by xiaoq on 2019/2/15.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface roominfoCell : UITableViewCell

@property (nonatomic , strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *houseCodeL;

@property (nonatomic, strong) UILabel *houseNumL;

@property (nonatomic, strong) UILabel *houseTypeL;

@property (nonatomic , strong) UILabel *areaL;

@property (nonatomic, strong) UILabel *certNumL;

@property (nonatomic, strong) UILabel *homelandL;

@property (nonatomic , strong) UILabel *agentL;

@property (nonatomic , strong) UILabel *phoneL;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@end

NS_ASSUME_NONNULL_END
