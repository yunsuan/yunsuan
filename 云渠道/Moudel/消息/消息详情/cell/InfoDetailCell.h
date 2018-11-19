//
//  InfoDetailCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoDetailCell : UITableViewCell
@property (nonatomic , strong) UILabel *contentlab;
-(void)SetCellContentbystring:(NSString *)str;
-(CGFloat)calculateTextHeight;
@end
