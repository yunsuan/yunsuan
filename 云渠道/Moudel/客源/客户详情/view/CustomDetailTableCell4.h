//
//  CustomDetailTableCell4.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/19.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView2.h"

@class CustomDetailTableCell4;

typedef void(^AddBtnBlock)(void);

@interface CustomDetailTableCell4 : UITableViewCell

@property (nonatomic, copy) AddBtnBlock addBtnBlock;

@property (nonatomic, strong) TagView2 *tagView;

@property (nonatomic, strong) UIButton *addBtn;

- (void)MasonryUI;

@end
