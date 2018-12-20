//
//  RentingModifyProjectImageVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/12/20.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RentingModifyProjectImageVCBlock)(void);

@interface RentingModifyProjectImageVC : BaseViewController

@property (nonatomic, copy) RentingModifyProjectImageVCBlock rentingModifyProjectImageVCBlock;

@property (nonatomic, strong) NSString *houseId;

- (instancetype)initWithImgArr:(NSArray *)imgArr;

@end

NS_ASSUME_NONNULL_END
