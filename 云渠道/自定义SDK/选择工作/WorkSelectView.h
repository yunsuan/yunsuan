//
//  WorkSelectView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^WorkSelectViewHideBlook)(void);
typedef void (^WorkSelectViewClickBlook)(int selctnum);

@interface WorkSelectView : UIScrollView

@property (nonatomic , copy) WorkSelectViewHideBlook hideblook;
@property (nonatomic , copy) WorkSelectViewClickBlook clickblook;

- (void)show;
- (void)hide;

@end

NS_ASSUME_NONNULL_END
