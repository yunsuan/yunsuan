//
//  AreaCustomDetailHeader.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^AreaCustomDetailHeaderTagBlock)(NSInteger index);

@interface AreaCustomDetailHeader : UITableViewHeaderFooterView

@property (nonatomic, copy) AreaCustomDetailHeaderTagBlock areaCustomDetailHeaderTagBlock;

@property (nonatomic, strong) UIButton *projectBtn;

@property (nonatomic, strong) UIButton *rentBtn;

@property (nonatomic, strong) UIButton *secondBtn;


@end

NS_ASSUME_NONNULL_END
