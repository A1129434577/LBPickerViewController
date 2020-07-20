//
//  LBPickerVC.h
//  Site
//
//  Created by 刘彬 on 2020/6/29.
//  Copyright © 2020 yc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LBPickerViewController : UIViewController
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, copy, nullable)void(^pickerViewSelected)(NSString * _Nonnull resultString);
@property (nonatomic, strong) NSArray<NSString *> *dataSource;
@property (nonatomic, strong) NSString *selectedResult;
@end

NS_ASSUME_NONNULL_END
