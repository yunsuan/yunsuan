//
//  RecommendMoreInfoVC.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/29.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import "WMPageController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^RecommendMoreInfoVCBlock)(NSString *attent);

@interface RecommendMoreInfoVC : WMPageController

@property (nonatomic, copy) RecommendMoreInfoVCBlock recommendMoreInfoVCBlock;

- (instancetype)initWithApplyFocusId:(NSString *)applyFocusId titleStr:(NSString *)titleStr applyId:(NSString *)applyId;

@end

NS_ASSUME_NONNULL_END
