//
//  RentingModifyTagVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingModifyTagSaveBtnBlock)(NSArray *array);

@interface RentingModifyTagVC : BaseViewController

@property (nonatomic, copy) RentingModifyTagSaveBtnBlock rentingModifyTagSaveBtnBlock;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *houseId;

//@property (nonatomic, strong) NSString *typeId;

- (instancetype)initWithArray:(NSArray *)array type:(NSInteger )type;

@end

NS_ASSUME_NONNULL_END
