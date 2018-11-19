//
//  MineCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineCell : UITableViewCell
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UIImageView *icon;
@property (nonatomic , strong) UILabel *contentlab;
-(void)SetTitle:(NSString *)title
           icon:(NSString *)iconname
     contentlab:(NSString *)content;

@end
