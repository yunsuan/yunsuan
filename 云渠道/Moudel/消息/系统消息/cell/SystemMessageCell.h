//
//  SystemMessageCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemMessageCell : UITableViewCell
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *contentlab;
@property (nonatomic , strong) UILabel *timelab;
@property (nonatomic , strong) UIImageView *messageimg;

-(void)SetCellbytitle:(NSString *)title
              content:(NSString *)content
                 time:(NSString *)time
           messageimg:(BOOL)isopen;
@end
