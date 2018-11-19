//
//  BlueTitleBaseCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/17.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlueTitleBaseCell : UITableViewCell

@property (nonatomic, strong) UIView *colorView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIView *lineView;

- (void)ReMasonryUI;

@end
