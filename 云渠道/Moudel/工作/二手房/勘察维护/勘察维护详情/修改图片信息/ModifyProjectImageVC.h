//
//  ModifyProjectImageVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/8/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

typedef void(^ModifyProjectImageVCBlock)(void);

@interface ModifyProjectImageVC : BaseViewController

@property (nonatomic, copy) ModifyProjectImageVCBlock modifyProjectImageVCBlock;

@property (nonatomic, strong) NSString *houseId;

- (instancetype)initWithImgArr:(NSArray *)imgArr;

@end
