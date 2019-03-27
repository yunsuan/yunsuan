//
//  ApplyProjectCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/3/13.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LevelView.h"
#import "RankView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyProjectCell : UITableViewCell

@property (nonatomic, strong) UIImageView *selectImg;

@property (nonatomic , strong) UILabel *titlelab;

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *contentlab;

@property (nonatomic , strong) UILabel *statulab;

@property (nonatomic , strong) UILabel *surelab;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) RankView *rankView;

@property (nonatomic, strong) LevelView *getLevel;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;



-(void)SetTitle:(NSString *)title
          image:(NSString *)imagename
     contentlab:(NSString *)content
          statu:(NSString *)statu;

-(void)settagviewWithdata:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
