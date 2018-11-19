//
//  WorkingCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/15.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkingCell : UITableViewCell
@property (nonatomic , strong) UIImageView *headimg;
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *contentlab;
@property (nonatomic , strong) UIImageView *tagimg;
-(void)setTitle:(NSString *)title
        content:(NSString *)content
            img:(NSString *)imgname;

@end
