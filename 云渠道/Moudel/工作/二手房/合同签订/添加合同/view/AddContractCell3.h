//
//  AddContractCell3.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"
#import "DropDownBtn.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddContractCell3 : UITableViewCell

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) UILabel *allPriceL;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) UILabel *payTimeL;

@property (nonatomic, strong) DropDownBtn *payTimeBtn;

@property (nonatomic, strong) UILabel *payPriceL;

@property (nonatomic, strong) BorderTF *payPriceTF;

@property (nonatomic, strong) UILabel *loanBankL;

@property (nonatomic, strong) BorderTF *loanBankTF;

@end

NS_ASSUME_NONNULL_END
