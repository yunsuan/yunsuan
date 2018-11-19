//
//  SelectCompanyTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/3/23.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "SelectCompanyTableCell.h"

@implementation SelectCompanyTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setModel:(CompanyModel *)model{
    if (model.logo.length>0) {
        [_headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TestBase_Net,model.logo]] placeholderImage:[UIImage imageNamed:@"default_3"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            if (error) {
                
                _headImg.image = [UIImage imageNamed:@"default_3"];
            }
        }];
    }
   else
   {
       _headImg.image = [UIImage imageNamed:@"default_3"];
   }
    
    _nameL.text = model.company_name;
    _addressL.text = model.absolute_address;
    _phoneL.text = [NSString stringWithFormat:@"联系方式：%@",model.contact_tel];
    _contactL.text = [NSString stringWithFormat:@"负责人：%@",model.contact];
}

- (void)initUI{
    
    _headImg = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE, 17 *SIZE, 67 *SIZE, 67 *SIZE)];
    _headImg.contentMode = UIViewContentModeScaleAspectFill;
    _headImg.clipsToBounds = YES;
    [self.contentView addSubview:_headImg];
    
    _nameL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 16 *SIZE, 180 *SIZE, 13 *SIZE)];
    _nameL.textColor = YJContentLabColor;
    _nameL.font = [UIFont systemFontOfSize:13 *SIZE];
//    _nameL.text = @"云算科技";
    [self.contentView addSubview:_nameL];
    
    _addressL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 36 *SIZE, 180 *SIZE, 11 *SIZE)];
    _addressL.textColor = YJContentLabColor;
    _addressL.font = [UIFont systemFontOfSize:12 *SIZE];
//    _addressL.text = @"大禹东路108号3栋2单元";
    [self.contentView addSubview:_addressL];
    
    _codeL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 56 *SIZE, 180 *SIZE, 10 *SIZE)];
    _codeL.textColor = YJContentLabColor;
    _codeL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _codeL.text = @"营业执照：YYZZHNO138";
    [self.contentView addSubview:_codeL];
    
    _phoneL = [[UILabel alloc] initWithFrame:CGRectMake(95 *SIZE, 74 *SIZE, 150 *SIZE, 10 *SIZE)];
    _phoneL.textColor = YJContentLabColor;
    _phoneL.font = [UIFont systemFontOfSize:11 *SIZE];
//    _phoneL.text = @"联系方式：18745455623";
    [self.contentView addSubview:_phoneL];
    
    _contactL = [[UILabel alloc] initWithFrame:CGRectMake(250 *SIZE, 74 *SIZE, 100 *SIZE, 10 *SIZE)];
    _contactL.textColor = YJContentLabColor;
    _contactL.font = [UIFont systemFontOfSize:11 *SIZE];
    _contactL.textAlignment = NSTextAlignmentRight;
//    _contactL.text = @"负责人：张三";
    [self.contentView addSubview:_contactL];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 99 *SIZE, SCREEN_Width, SIZE)];
    line.backgroundColor = YJBackColor;
    [self.contentView addSubview:line];
}

@end
