//
//  LBPickerVC.m
//  Site
//
//  Created by 刘彬 on 2020/6/29.
//  Copyright © 2020 yc. All rights reserved.
//

#import "LBPickerViewController.h"
#import "LBPresentTransitions.h"

#define LBPicker_WINDOW \
({\
id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;\
UIWindow *keyWindow = [delegate respondsToSelector:@selector(window)]?delegate.window:nil;\
if (keyWindow == nil) {\
    if (@available(ios 13, *)) {\
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes){\
            if (windowScene.activationState == UISceneActivationStateForegroundActive){\
                UIWindow *window = windowScene.windows.firstObject;\
                if (window) {\
                    keyWindow = window;\
                }\
                break;\
            }\
        }\
        if (keyWindow == nil) {\
            keyWindow = [UIApplication sharedApplication].keyWindow;\
        }\
    }else{\
        keyWindow = [UIApplication sharedApplication].keyWindow;\
    }\
}\
keyWindow;\
})

@interface LBPickerViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    LBPresentTransitions *_transitions;
}
@property (nonatomic,strong)UIPickerView *pickerView;
@end

@implementation LBPickerViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _transitions = [LBPresentTransitions new];
        _transitions.coverViewType = LBTransitionsCoverViewAlpha0_5;
        _transitions.contentMode = LBTransitionsContentModeBottom;
        self.transitioningDelegate = _transitions;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

-(void)loadView{
    [super loadView];
    
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 0);
    self.view.backgroundColor = [UIColor whiteColor];
    //取消
    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 40, 30)];
    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(pickerCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    _cancelButton = cancelButton;
    
    //确定
    UIButton *selectButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)-CGRectGetWidth(cancelButton.frame)-15, CGRectGetMinY(cancelButton.frame), CGRectGetWidth(cancelButton.frame), CGRectGetHeight(cancelButton.frame))];
    [selectButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [selectButton setTitle:@"确定" forState:UIControlStateNormal];
    [selectButton addTarget:self action:@selector(pickerSelected) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:selectButton];
    _selectButton = selectButton;
    
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(selectButton.frame), CGRectGetWidth(self.view.frame), 210)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
    
    CGFloat safeAreaInsetsBottom = 0;
    if (@available(iOS 11.0, *)) {
        safeAreaInsetsBottom = LBPicker_WINDOW.safeAreaInsets.bottom;
    }
    
    self.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetMaxY(pickerView.frame)+safeAreaInsetsBottom);
}

-(void)setDataSource:(NSArray<NSString *> *)dataSource{
    _dataSource = dataSource;
    [self view];
    [_pickerView reloadAllComponents];
    
    NSUInteger index = [_dataSource indexOfObject:_selectedResult];
    if (_selectedResult && index<dataSource.count) {
        [_pickerView layoutIfNeeded];
        [_pickerView selectRow:index inComponent:0 animated:NO];
    }
}
-(void)setSelectedResult:(NSString *)selectedResult{
    _selectedResult = selectedResult;
    
    [_pickerView layoutIfNeeded];
    
    NSUInteger index = [_dataSource indexOfObject:selectedResult];
    if (index<_dataSource.count && [_pickerView selectedRowInComponent:0] != [_dataSource indexOfObject:selectedResult]) {
        [_pickerView selectRow:index inComponent:0 animated:NO];
    }
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataSource.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataSource[row];
}


-(void)pickerCancel{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)pickerSelected{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.pickerViewSelected?
    self.pickerViewSelected(self.dataSource[[_pickerView selectedRowInComponent:0]]):NULL;
}
@end
