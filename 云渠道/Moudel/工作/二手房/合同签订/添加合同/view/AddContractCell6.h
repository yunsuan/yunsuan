//
//  AddContractCell6.h
//  云渠道
//
//  Created by xiaoq on 2019/1/23.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddContractCell6 : UITableViewCell
//房源信息
//@property (nonatomic , strong) UIView *colorView;
//@property (nonatomic , strong) UILabel *titleL;
@property (nonatomic , strong) UIButton *choosebtn;
@property (nonatomic , strong) UILabel *numL;
@property (nonatomic , strong) UILabel *addressL;
@property (nonatomic , strong) UILabel *nameL;
@property (nonatomic , strong) UILabel *telL;
@property (nonatomic , strong) UIView *line;
- (void)setDataDic:(NSMutableDictionary *)dataDic;
@end

NS_ASSUME_NONNULL_END
