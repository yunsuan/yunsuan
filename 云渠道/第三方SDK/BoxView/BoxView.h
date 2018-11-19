//
//  BoxView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBtnBlock)(NSString *ID,NSString *str);

typedef void(^CancelBtnBlock)(void);

@interface BoxView : UIView

@property (nonatomic, copy) ConfirmBtnBlock confirmBtnBlock;

@property (nonatomic, copy) CancelBtnBlock cancelBtnBlock;

@property (nonatomic, strong) NSMutableArray *dataArr;

@property (nonatomic, strong) NSMutableArray *selectArr;

@property (nonatomic, strong) UITableView *mainTable;

@end
