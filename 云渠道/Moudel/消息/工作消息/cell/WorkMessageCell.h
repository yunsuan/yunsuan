//
//  WorkMessageCell.h
//  云渠道
//
//  Created by xiaoq on 2018/3/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkMessageCell : UITableViewCell

@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *contentlab;
@property (nonatomic , strong) UILabel *numlab;
@property (nonatomic , strong) UILabel *namelab;
@property (nonatomic , strong) UILabel *projectlab;
@property (nonatomic , strong) UILabel *timelab;
@property (nonatomic , strong) UIImageView *messageimg;

-(void)SetCellbytitle:(NSString *)title
                  num:(NSString *)num
                 name:(NSString *)name
              project:(NSString *)project
                 time:(NSString *)time
           messageimg:(BOOL)isopen;
@end
