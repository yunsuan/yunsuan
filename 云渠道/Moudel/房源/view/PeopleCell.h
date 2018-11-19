//
//  PeopleCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TagView.h"
#import "LevelView.h"
#import "RankView.h"

@interface PeopleCell : UITableViewCell
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UIImageView *imageview;
@property (nonatomic , strong) UILabel *contentlab;
@property (nonatomic , strong) UILabel *statulab;
@property (nonatomic , strong) UILabel *surelab;
@property (nonatomic , strong) TagView *tagview;
@property (nonatomic, strong) UIImageView *statusImg;
@property (nonatomic , strong) TagView *wuyeview;
@property (nonatomic, strong) RankView *rankView;
@property (nonatomic, strong) LevelView *getLevel;



-(void)SetTitle:(NSString *)title
          image:(NSString *)imagename
     contentlab:(NSString *)content
          statu:(NSString *)statu;

-(void)settagviewWithdata:(NSArray *)data;
@end
