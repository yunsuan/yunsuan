//
//  ActiveRoomDetailVC.h
//  云渠道
//
//  Created by 谷治墙 on 2020/2/25.
//  Copyright © 2020 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ActiveRoomDetailVC : BaseViewController

@property (nonatomic, strong) NSString *project_id;

- (instancetype)initWithHouseId:(NSString *)house_id info_id:(NSString *)info_id;


@end

NS_ASSUME_NONNULL_END
