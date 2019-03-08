//
//  InfoDetailCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^InfoDetailCellBlock)(void);

@interface InfoDetailCell : UITableViewCell

@property (nonatomic, copy) InfoDetailCellBlock infoDetailCellBlock;

@property (nonatomic , strong) UILabel *contentlab;

@property (nonatomic, strong) UIButton *moreBtn;

-(void)SetCellContentbystring:(NSString *)str;
//-(CGFloat)calculateTextHeight;
@end
