//
//  AttentionProjectCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/11/16.
//  Copyright © 2018 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TagView.h"

NS_ASSUME_NONNULL_BEGIN

@interface AttentionProjectCell : UITableViewCell

@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UIImageView *imageview;
@property (nonatomic , strong) UILabel *contentlab;
@property (nonatomic , strong) UILabel *statulab;
@property (nonatomic, strong) UIImageView *statusImg;
@property (nonatomic , strong) TagView *tagview;
@property (nonatomic , strong) TagView *wuyeview;

-(void)SetTitle:(NSString *)title
          image:(NSString *)imagename
     contentlab:(NSString *)content
          statu:(NSString *)statu;
-(void)settagviewWithdata:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
