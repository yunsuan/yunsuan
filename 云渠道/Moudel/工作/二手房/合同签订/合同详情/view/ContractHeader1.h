//
//  ContractHeader1.h
//  云渠道
//
//  Created by xiaoq on 2019/2/14.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ContractHeader1 : UITableViewHeaderFooterView

@property (nonatomic , strong) UIView *tradeView;
@property (nonatomic , strong) UIImageView *imgView;
@property (nonatomic , strong) UILabel *numLab;
@property (nonatomic , strong) UILabel *moneyLab;
@property (nonatomic , strong) UILabel *creattimeLab;
@property (nonatomic , strong) UILabel *passtimeLab;
@property (nonatomic , strong) UILabel *peopleLab;

@property (nonatomic , strong) UIView *infoView;
@property (nonatomic , strong) UILabel *adressLab;
@property (nonatomic , strong) UILabel *roomLab;
@property (nonatomic , strong) UILabel *buyLab;
@property (nonatomic , strong) UILabel *sellLab;

@end

NS_ASSUME_NONNULL_END
