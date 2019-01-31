//
//  AddContractCell4.h
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddContractCell4 : UITableViewCell
//权益人
@property (nonatomic , strong) UILabel *titelL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UIImageView *seximg;
@property (nonatomic , strong) UILabel *telL;
@property (nonatomic , strong) UIButton *stickieBtn;
@property (nonatomic , strong) UIView *line;
- (void)setData:(NSMutableDictionary *)dataDic;

@end

NS_ASSUME_NONNULL_END
