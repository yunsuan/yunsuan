//
//  SecAllRoomTableCell3.m
//  云渠道
//
//  Created by 谷治墙 on 2018/6/11.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SecAllRoomTableCell3.h"

@implementation SecAllRoomTableCell3

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}


- (void)setModel:(SecAllRoomProjectModel *)model{
    
    if (model.project_img_url.length>0) {
        [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.project_img_url]] placeholderImage:[UIImage imageNamed:@"default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _roomImg.image = [UIImage imageNamed:@"default_2"];
            }
        }];
    }else{
         _roomImg.image = [UIImage imageNamed:@"default_2"];
    }
   
    
    if (![model.project_average_price integerValue]) {
        
        _priceL.text = @"参考均价：暂无数据";
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"参考均价：%@元/m²",model.project_average_price];
    }
    
    if (![model.project_total_build integerValue]) {
        
        _buildL.text = @"楼栋总数：暂无数据";
    }else{
        
        _buildL.text = [NSString stringWithFormat:@"楼栋总数：%@栋",model.project_total_build];
    }
    
    _roomL.text = @"房屋总数：暂无数据";
}

- (void)setStoreModel:(SecAllRoomStoreModel *)storeModel{
    if (storeModel.project_img_url.length>0) {
        [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,storeModel.project_img_url]] placeholderImage:[UIImage imageNamed:@"default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _roomImg.image = [UIImage imageNamed:@"default_2"];
            }
        }];
    }
    else{
         _roomImg.image = [UIImage imageNamed:@"default_2"];
    }
    
    if (![storeModel.project_average_price integerValue]) {
        
        _priceL.text = @"参考均价：暂无数据";
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"参考均价：%@元/m²",storeModel.project_average_price];
    }
    
    if (![storeModel.project_total_build integerValue]) {
        
        _buildL.text = @"楼栋总数：暂无数据";
    }else{
        
        _buildL.text = [NSString stringWithFormat:@"楼栋总数：%@栋",storeModel.project_total_build];
    }
    
    _roomL.text = @"房屋总数：暂无数据";
}

- (void)setOfficeModel:(SecAllRoomOfficeModel *)officeModel{
    
    if (officeModel.project_img_url.length>0) {
        [_roomImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,officeModel.project_img_url]] placeholderImage:[UIImage imageNamed:@"default_2"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _roomImg.image = [UIImage imageNamed:@"default_2"];
            }
        }];
    }
    else{
        _roomImg.image = [UIImage imageNamed:@"default_2"];
    }
    
    
    if (![officeModel.project_average_price integerValue]) {
        
        _priceL.text = @"参考均价：暂无数据";
    }else{
        
        _priceL.text = [NSString stringWithFormat:@"参考均价：%@元/m²",officeModel.project_average_price];
    }
    
    if (![officeModel.project_total_build integerValue]) {
        
        _buildL.text = @"楼栋总数：暂无数据";
    }else{
        
        _buildL.text = [NSString stringWithFormat:@"楼栋总数：%@栋",officeModel.project_total_build];
    }
    
    _roomL.text = @"房屋总数：暂无数据";
}

- (void)initUI{
    
    _priceL = [[UILabel alloc] init];
    _priceL.textColor = YJTitleLabColor;
    _priceL.font = [UIFont systemFontOfSize:13 *SIZE];
    _priceL.numberOfLines = 0;
    [self.contentView addSubview:_priceL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJTitleLabColor;
    _timeL.font = [UIFont systemFontOfSize:13 *SIZE];
    _timeL.numberOfLines = 0;
    [self.contentView addSubview:_timeL];
    
    _buildL = [[UILabel alloc] init];
    _buildL.textColor = YJTitleLabColor;
    _buildL.font = [UIFont systemFontOfSize:13 *SIZE];
    _buildL.numberOfLines = 0;
    [self.contentView addSubview:_buildL];
    
    _roomL = [[UILabel alloc] init];
    _roomL.textColor = YJTitleLabColor;
    _roomL.font = [UIFont systemFontOfSize:13 *SIZE];
    _roomL.numberOfLines = 0;
    [self.contentView addSubview:_roomL];
    
    _roomImg = [[UIImageView alloc] init];
    _roomImg.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_roomImg];
    
    [self MasonryUI];
}

- (void)MasonryUI{
    
    [_priceL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(self.contentView).offset(10 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];

    [_buildL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_priceL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
    }];
    
    
    [_roomImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(250 *SIZE);
        make.top.equalTo(self.contentView).offset(11 *SIZE);
        make.height.mas_equalTo(88 *SIZE);
        make.width.mas_equalTo(100 *SIZE);
    }];
    
    [_roomL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(10 *SIZE);
        make.top.equalTo(_buildL.mas_bottom).offset(13 *SIZE);
        make.right.equalTo(self.contentView).offset(-120 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-36 *SIZE);
    }];
}
@end
