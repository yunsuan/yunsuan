//
//  TextFieldImgCell.h
//  云渠道
//
//  Created by 谷治墙 on 2018/7/18.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TextFieldImgCellBlock)(NSString *str);

@interface TextFieldImgCell : UITableViewCell

@property (nonatomic, copy) TextFieldImgCellBlock textFieldImgCellBlock;

@property (nonatomic, strong) UIButton *nameBtn;

@property (nonatomic, strong) UILabel *nameL;

@property (nonatomic, strong) UIImageView *bigImg;

//@property (nonatomic, strong) UIButton *cancenBtn;

@end
