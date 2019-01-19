//
//  PhoneTextField.h
//  云渠道
//
//  Created by 谷治墙 on 2019/1/19.
//  Copyright © 2019 xiaoq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol KeyInputTextFieldDelegate <NSObject>

@optional

- (void)deleteBackWard:(UITextField *)textField;

@end

@interface PhoneTextField : UITextField

@property (nonatomic, weak) id<KeyInputTextFieldDelegate> keyInputTextFieldDelegate;

@end

NS_ASSUME_NONNULL_END
