//
//  CodeView.h
//  云渠道
//
//  Created by 谷治墙 on 2019/9/12.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^CodeViewShareBlock)(void);

typedef void(^CodeViewSaveBlock)(void);

@interface CodeView : UIView

@property (nonatomic, copy) CodeViewShareBlock codeViewShareBlock;

@property (nonatomic, copy) CodeViewSaveBlock codeViewSaveBlock;

@property (nonatomic, strong) UIView *whiteView;

@property (nonatomic, strong) UIImageView *codeImg;

@property (nonatomic, strong) UILabel *customL;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) UILabel *projectL;

@property (nonatomic, strong) UIButton *saveBtn;

@property (nonatomic, strong) UIButton *shareBtn;

- (void)creatQRCodeWith:(NSString *)urlString;

- (void)setErWeiMaWithUrl:(NSString *)url AndView:(UIView *)View;

@end

NS_ASSUME_NONNULL_END
