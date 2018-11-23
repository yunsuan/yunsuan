//
//  AddAlbumView.h
//  云渠道
//
//  Created by 谷治墙 on 2018/6/26.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BorderTF.h"

@class AddAlbumView;

typedef void(^AddAlbumViewAddBlock)(void);

@interface AddAlbumView : UIView

@property (nonatomic, copy) AddAlbumViewAddBlock addAlbumViewAddBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UILabel *titleL;

@property (nonatomic, strong) UILabel *nameL;

//@property (nonatomic, strong) UILabel *roomNumL;

@property (nonatomic, strong) BorderTF *nameTF;

@property (nonatomic, strong) UIButton *cancenBtn;

@property (nonatomic, strong) UIButton *confirmBtn;
@end
