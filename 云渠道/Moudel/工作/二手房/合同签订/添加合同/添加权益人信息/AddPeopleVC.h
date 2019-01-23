//
//  AddPeopleVC.h
//  云渠道
//
//  Created by xiaoq on 2019/1/22.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AddPeopleBlock)(NSMutableDictionary *dic);

@interface AddPeopleVC : BaseViewController

@property (nonatomic, copy) AddPeopleBlock AddPeopleblock;
@property (nonatomic, strong) NSMutableDictionary *dataDic;


@end

NS_ASSUME_NONNULL_END
