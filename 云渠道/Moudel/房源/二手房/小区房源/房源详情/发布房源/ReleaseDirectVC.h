//
//  ReleaseDirectVC.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/23.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ReleaseDirectVCBlock)(void);

@interface ReleaseDirectVC : BaseViewController

@property (nonatomic, copy) ReleaseDirectVCBlock releaseDirectVCBlock;

@property (nonatomic, strong) NSDictionary *dataDic;

@property (nonatomic, strong) NSString *surveyId;

@property (nonatomic, strong) NSString *projectID;

@property (nonatomic, strong) NSString *buildId;

@property (nonatomic, strong) NSString *unitId;

@property (nonatomic, strong) NSString *comName;

@property (nonatomic, strong) NSString *status;

@end

NS_ASSUME_NONNULL_END
