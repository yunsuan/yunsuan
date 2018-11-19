//
//  DropDownBtn.h
//  云渠道
//
//  Created by xiaoq on 2018/3/29.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownBtn : UIButton {
@public
    NSString *str;
}

@property (nonatomic , strong) UILabel *content;
@property (nonatomic , strong) UIImageView *dropimg;

@end
