//
//  SecondaryMatchCell2.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/27.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^SecondaryMatchCell2Block)(NSInteger index);

@interface SecondaryMatchCell2 : UITableViewCell

@property (nonatomic, copy) SecondaryMatchCell2Block secondaryMatchCell2Block;

@property (nonatomic, strong) UIImageView *roomImg;

@property (nonatomic, strong) UILabel *storeNameL;

@property (nonatomic, strong) UILabel *codeL;

@property (nonatomic, strong) UILabel *addressL;

@property (nonatomic, strong) UILabel *contactL;

@property (nonatomic, strong) UILabel *matchNumL;

@property (nonatomic, strong) UIButton *recommendBtn;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) NSMutableDictionary *dicData;

@end

NS_ASSUME_NONNULL_END
