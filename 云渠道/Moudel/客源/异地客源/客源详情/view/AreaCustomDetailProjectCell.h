//
//  AreaCustomDetailProjectCell.h
//  云渠道
//
//  Created by 谷治墙 on 2019/12/6.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AreaCustomDetailProjectCell : UITableViewCell

@property (nonatomic , strong) UILabel *titleL;

@property (nonatomic , strong) UIImageView *imageview;

@property (nonatomic , strong) UILabel *addressL;

@property (nonatomic , strong) UILabel *statuL;

@property (nonatomic, strong) UILabel *recommendL;

@property (nonatomic, strong) GZQFlowLayout *propertyFlowLayout;

@property (nonatomic, strong) UICollectionView *propertyColl;

@property (nonatomic, strong) NSMutableDictionary *dataDic;

@property (nonatomic, strong) UIView *line;

-(void)settagviewWithdata:(NSArray *)data;

@end

NS_ASSUME_NONNULL_END
