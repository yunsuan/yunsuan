//
//  MessageTableCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/3/21.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImg;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *contentL;

-(void)SetCellContentbyimg:(NSString *)imgname
                     title:(NSString *)title
                   content:(NSString *)content;

@end
