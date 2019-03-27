//
//  CompanyCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/20.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompanyCell : UITableViewCell

@property (nonatomic , strong) UILabel *titlelab;

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *contentlab;

@property (nonatomic , strong) UILabel *statulab;

@property (nonatomic, strong) UIImageView *statusImg;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) UIView *line;

-(void)SetTitle:(NSString *)title
          image:(NSString *)imagename
     contentlab:(NSString *)content
          statu:(NSString *)statu;

-(void)settagviewWithdata:(NSArray *)data;
@end
