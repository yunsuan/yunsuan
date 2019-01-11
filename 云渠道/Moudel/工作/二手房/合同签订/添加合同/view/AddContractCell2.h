//
//  AddContractCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddContractCell2 : UITableViewCell

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *allPriceL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *firstPayL;

@property (nonatomic, strong) BorderTF *firstPayTF;

@property (nonatomic, strong) UILabel *loanPriceL;

@property (nonatomic, strong) BorderTF *loanPriceTF;

@property (nonatomic, strong) UILabel *loanYearL;

@property (nonatomic, strong) BorderTF *loanYearTF;

@property (nonatomic, strong) UILabel *loanBankL;

@property (nonatomic, strong) BorderTF *loanBankTF;

@end

NS_ASSUME_NONNULL_END
