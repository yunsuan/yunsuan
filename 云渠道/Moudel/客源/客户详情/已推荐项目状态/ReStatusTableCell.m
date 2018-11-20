
//
//  ReStatusTableCell.m
//  云渠道
//
//  Created by 谷治墙 on 2018/4/28.
//  Copyright © 2018年 xiaoq. All rights reserved.
//

#import "ReStatusTableCell.h"

@implementation ReStatusTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initUI];
    }
    return self;
}

- (void)setDataDic:(NSMutableDictionary *)dataDic{
    
    _img1.image = [UIImage imageNamed:@"progressbar_gray"];
    _img2.image = [UIImage imageNamed:@"progressbar_gray"];
    _img3.image = [UIImage imageNamed:@"progressbar_gray"];
    _img4.image = [UIImage imageNamed:@"progressbar_gray"];
    _img5.image = [UIImage imageNamed:@"progressbar_gray"];
    
    _line1.backgroundColor = COLOR(191, 191, 191, 1);
    _line2.backgroundColor = COLOR(191, 191, 191, 1);
    _line3.backgroundColor = COLOR(191, 191, 191, 1);
    _line4.backgroundColor = COLOR(191, 191, 191, 1);
    
    _content1.textColor = YJTitleLabColor;
    _content2.textColor = YJTitleLabColor;
    _content3.textColor = YJTitleLabColor;
    _content4.textColor = YJTitleLabColor;
    _content5.textColor = YJTitleLabColor;
    
    if ([dataDic[@"disabled_state"] integerValue] == 0) {
        
        _statusL.text = @"有效";
        _statusL.textColor = YJBlueBtnColor;
    }else{
        
        _statusL.text = @"无效";
        _statusL.textColor = YJContentLabColor;
    }
    
    
    _titleL.text = dataDic[@"project_name"];
    switch ([dataDic[@"current_state"] integerValue]) {
        case 1:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar_gray"];
            _img3.image = [UIImage imageNamed:@"progressbar_gray"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            _img5.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(191, 191, 191, 1);
            _line2.backgroundColor = COLOR(191, 191, 191, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            _line4.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = YJTitleLabColor;
            _content3.textColor = YJTitleLabColor;
            _content4.textColor = YJTitleLabColor;
            _content5.textColor = YJTitleLabColor;
            
            _timeL.text = [NSString stringWithFormat:@"%@推荐",dataDic[@"state_change_time"]];
            break;
        }
        case 2:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar_gray"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            _img5.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(191, 191, 191, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            _line4.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);
            _content2.textColor = COLOR(255, 165, 29, 1);
            _content3.textColor = YJTitleLabColor;
            _content4.textColor = YJTitleLabColor;
            _content5.textColor = YJTitleLabColor;
            _timeL.text = [NSString stringWithFormat:@"%@到访",dataDic[@"state_change_time"]];
            break;
        }
        case 3:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar_gray"];
            _img5.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(191, 191, 191, 1);
            _line4.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = YJTitleLabColor;
            _content5.textColor = YJTitleLabColor;
            _timeL.text = [NSString stringWithFormat:@"%@认购",dataDic[@"state_change_time"]];
            break;
        }
        case 4:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar"];
            _img5.image = [UIImage imageNamed:@"progressbar_gray"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(255, 165, 29, 1);
            _line4.backgroundColor = COLOR(191, 191, 191, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = COLOR(255, 165, 29, 1);;
            _content5.textColor = YJTitleLabColor;
            _timeL.text = [NSString stringWithFormat:@"%@签约",dataDic[@"state_change_time"]];
            break;
        }
        case 5:
        {
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar"];
            _img5.image = [UIImage imageNamed:@"progressbar"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(255, 165, 29, 1);
            _line4.backgroundColor = COLOR(255, 165, 29, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = COLOR(255, 165, 29, 1);;
            _content5.textColor = COLOR(255, 165, 29, 1);;
            
            _timeL.text = [NSString stringWithFormat:@"%@结佣",dataDic[@"state_change_time"]];
            break;
        }
        default:
            _img1.image = [UIImage imageNamed:@"progressbar"];
            _img2.image = [UIImage imageNamed:@"progressbar"];
            _img3.image = [UIImage imageNamed:@"progressbar"];
            _img4.image = [UIImage imageNamed:@"progressbar"];
            _img5.image = [UIImage imageNamed:@"progressbar"];
            
            _line1.backgroundColor = COLOR(255, 165, 29, 1);
            _line2.backgroundColor = COLOR(255, 165, 29, 1);
            _line3.backgroundColor = COLOR(255, 165, 29, 1);
            _line4.backgroundColor = COLOR(255, 165, 29, 1);
            
            _content1.textColor = COLOR(255, 165, 29, 1);;
            _content2.textColor = COLOR(255, 165, 29, 1);;
            _content3.textColor = COLOR(255, 165, 29, 1);;
            _content4.textColor = COLOR(255, 165, 29, 1);;
            _content5.textColor = COLOR(255, 165, 29, 1);;
            
            _timeL.text = [NSString stringWithFormat:@"%@结佣",dataDic[@"state_change_time"]];
            break;
    }
    
    [_titleL mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.contentView).offset(27 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        //        make.right.equalTo(_timeL.mas_left).offset(-22 *SIZE);
        make.width.equalTo(@(_titleL.mj_textWith + 5 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
}

- (void)initUI{
    
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(10 *SIZE, 14 *SIZE, 7 *SIZE, 13 *SIZE)];
    titleView.backgroundColor = YJBlueBtnColor;
    [self.contentView addSubview:titleView];
    
    _titleL = [[UILabel alloc] init];
    _titleL.textColor = YJTitleLabColor;
    _titleL.font = [UIFont systemFontOfSize:13 *SIZE];
    [self.contentView addSubview:_titleL];
    
    _timeL = [[UILabel alloc] init];
    _timeL.textColor = YJContentLabColor;
    _timeL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_timeL];
    
    _statusL = [[UILabel alloc] initWithFrame:CGRectMake(310 *SIZE, 15 *SIZE, 35 *SIZE, 11 *SIZE)];
    _statusL.textColor = YJContentLabColor;
    _statusL.textAlignment = NSTextAlignmentRight;
    _statusL.font = [UIFont systemFontOfSize:12 *SIZE];
    [self.contentView addSubview:_statusL];
    
    for (int i = 0; i < 5; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10 *SIZE + i * 81 *SIZE, 49 *SIZE, 17 *SIZE, 17 *SIZE)];
        img.image = [UIImage imageNamed:@"progressbar_gray"];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10 *SIZE + i * 81 *SIZE, 75 *SIZE, 40 *SIZE, 11 *SIZE)];
        content.textColor = YJTitleLabColor;
        content.font = [UIFont systemFontOfSize:12 *SIZE];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(27 *SIZE + i * 81 *SIZE, 57 *SIZE, 64 *SIZE, SIZE)];
        line.backgroundColor = COLOR(191, 191, 191, 1);
        switch (i) {
            case 0:
            {
                _img1 = img;
                [self.contentView addSubview:_img1];
                
                _content1 = content;
                _content1.text = @"推荐";
                [self.contentView addSubview:_content1];
                
                _line1 = line;
                [self.contentView addSubview:_line1];
                break;
            }
            case 1:
            {
                _img2 = img;
                [self.contentView addSubview:_img2];
                
                _content2 = content;
                _content2.text = @"到访";
                [self.contentView addSubview:_content2];
                
                _line2 = line;
                [self.contentView addSubview:_line2];
                break;
            }
            case 2:
            {
                _img3 = img;
                [self.contentView addSubview:_img3];
                
                _content3 = content;
                _content3.text = @"认购";
                [self.contentView addSubview:_content3];
                
                _line3 = line;
                [self.contentView addSubview:_line3];
                break;
            }
            case 3:
            {
                _img4 = img;
                [self.contentView addSubview:_img4];
                
                _content4 = content;
                _content4.text = @"签约";
                [self.contentView addSubview:_content4];
                
                _line4 = line;
                [self.contentView addSubview:_line4];
                break;
            }
            case 4:
            {
                _img5 = img;
                [self.contentView addSubview:_img5];
                
                _content5 = content;
                _content5.text = @"结佣";
                [self.contentView addSubview:_content5];
                break;
            }
            default:
                break;
        }
    }
    
    [_titleL mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.contentView).offset(27 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
//        make.right.equalTo(_timeL.mas_left).offset(-22 *SIZE);
        make.width.equalTo(@(_titleL.mj_textWith + 5 *SIZE));
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
    
    [_timeL mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.contentView).offset(-50 *SIZE);
        make.top.equalTo(self.contentView).offset(15 *SIZE);
        make.left.equalTo(_titleL.mas_right).offset(22 *SIZE);
        make.bottom.equalTo(self.contentView).offset(-86 *SIZE);
    }];
}

@end
