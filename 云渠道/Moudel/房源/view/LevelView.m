//
//  LevelView.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/16.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "LevelView.h"

@interface LevelView()
{

    NSInteger _level;
    UIImage *_image;
    NSString *_title;
}

@end

@implementation LevelView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


        [self initUI];
    }
    return self;
}

- (void)SetImage:(UIImage *)image selectImg:(UIImage *)selectImg num:(NSInteger)num{
    
    switch (num) {
        case 0:
        {
            _level1.image = image;
            _level2.image = image;
            _level3.image = image;
            _level4.image = image;
            _level5.image = image;
            break;
        }
        case 1:
        {
            _level1.image = selectImg;
            _level2.image = image;
            _level3.image = image;
            _level4.image = image;
            _level5.image = image;
            break;
        }
        case 2:
        {
            _level1.image = selectImg;
            _level2.image = selectImg;
            _level3.image = image;
            _level4.image = image;
            _level5.image = image;
            break;
        }
        case 3:
        {
            _level1.image = selectImg;
            _level2.image = selectImg;
            _level3.image = selectImg;
            _level4.image = image;
            _level5.image = image;
            break;
        }
        case 4:
        {
            _level1.image = selectImg;
            _level2.image = selectImg;
            _level3.image = selectImg;
            _level4.image = selectImg;
            _level5.image = image;
            break;
        }
        case 5:
        {
            _level1.image = selectImg;
            _level2.image = selectImg;
            _level3.image = selectImg;
            _level4.image = selectImg;
            _level5.image = selectImg;
            break;
        }
        default:
            break;
    }
}

- (void)initUI{
    
    _titleL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 25 *SIZE, 10 *SIZE)];
    _titleL.textColor = YJContentLabColor;
    _titleL.font = [UIFont systemFontOfSize:11 *SIZE];
    [self addSubview:_titleL];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(29 *SIZE + i * 17 *SIZE, 0, 12 *SIZE, 12 *SIZE)];
        switch (i) {
            case 0:
            {
                _level1 = imageView;
                [self addSubview:_level1];
                break;
            }
            case 1:
            {
                _level2 = imageView;
                [self addSubview:_level2];
                break;
            }
            case 2:
            {
                _level3 = imageView;
                [self addSubview:_level3];
                break;
            }
            case 3:
            {
                _level4 = imageView;
                [self addSubview:_level4];
                break;
            }
            case 4:
            {
                _level5 = imageView;
                [self addSubview:_level5];
                break;
            }
            default:
                break;
        }
    }
}

@end
