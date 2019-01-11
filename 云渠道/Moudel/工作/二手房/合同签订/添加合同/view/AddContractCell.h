//
//  AddContractVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/11.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DropDownBtn.h"
#import "BorderTF.h"

NS_ASSUME_NONNULL_BEGIN

@interface AddContractCell : UITableViewCell

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) BorderTF *codeTF;

@property (nonatomic, strong) UILabel *priceL;

@property (nonatomic, strong) BorderTF *priceTF;

@property (nonatomic, strong) UILabel *buyBreachL;

@property (nonatomic, strong) BorderTF *buyBreachTF;

@property (nonatomic, strong) UILabel *sellBreachL;

@property (nonatomic, strong) BorderTF *sellBreachTF;

@property (nonatomic, strong) UILabel *costL;

@property (nonatomic, strong) BorderTF *costTF;

@property (nonatomic, strong) UILabel *loanTimeL;

@property (nonatomic, strong) DropDownBtn *loanTimeBtn;

@property (nonatomic, strong) UILabel *cardTimeL;

@property (nonatomic, strong) DropDownBtn *cardTimeBtn;

@property (nonatomic, strong) UILabel *mortgageTimeL;

@property (nonatomic, strong) DropDownBtn *mortgageTimeBtn;

@property (nonatomic, strong) UILabel *payWayL;

@property (nonatomic, strong) DropDownBtn *payWayBtn;

@end

NS_ASSUME_NONNULL_END
