//
//  LevelView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/4/16.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LevelView : UIView

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UIImageView *level1;

@property (nonatomic, strong) UIImageView *level2;

@property (nonatomic, strong) UIImageView *level3;

@property (nonatomic, strong) UIImageView *level4;

@property (nonatomic, strong) UIImageView *level5;

- (void)SetImage:(UIImage *)image selectImg:(UIImage *)selectImg num:(NSInteger )num;

@end
