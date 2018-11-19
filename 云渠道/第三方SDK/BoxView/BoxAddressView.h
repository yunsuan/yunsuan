//
//  BoxAddressView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/5/14.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BoxAddressView;

typedef void(^BoxAddressComfirmBlock)(NSString *ID,NSString *str,NSInteger index);

typedef void(^BoxAddressCancelBlock)(void);

@interface BoxAddressView : UIView


@property (nonatomic, copy) BoxAddressComfirmBlock boxAddressComfirmBlock;

@property (nonatomic, copy) BoxAddressCancelBlock boxAddressCancelBlock;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectArr;

@property (nonatomic, strong) UITableView *mainTable;

@end
