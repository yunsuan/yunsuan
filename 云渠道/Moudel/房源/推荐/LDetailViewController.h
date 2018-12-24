//
//  LDetailViewController.h
//  教育资格证培训
//
//  Created by 赖星果 on 16/7/7.
//  Copyright © 2016年 赖星果. All rights reserved.
//

#import "BaseViewController.h"

@interface LDetailViewController : BaseViewController
@property (nonatomic, strong)NSArray *contentdata;
@property (nonatomic, strong)NSDictionary *data;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, assign)NSInteger type;

@end
