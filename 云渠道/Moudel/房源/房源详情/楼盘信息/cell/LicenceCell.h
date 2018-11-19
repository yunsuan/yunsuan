//
//  LicenceCell.h
//  云渠道
//
//  Created by xiaoq on 2018/4/2.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LicenceCell : UITableViewCell
@property (nonatomic , strong) UILabel *titlelab;
@property (nonatomic , strong) UILabel *contentlab;
-(void)settitle:(NSString *)title
        content:(NSString *)content;
@end
