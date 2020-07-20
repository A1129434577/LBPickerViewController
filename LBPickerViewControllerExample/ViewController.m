//
//  ViewController.m
//  LBPickerViewControllerExample
//
//  Created by 刘彬 on 2020/7/20.
//  Copyright © 2020 刘彬. All rights reserved.
//

#import "ViewController.h"
#import "LBPickerViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSString *result;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesBegan:nil withEvent:nil];
    });
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    LBPickerViewController *vc = [[LBPickerViewController alloc] init];
    vc.selectedResult = _result;
    vc.dataSource = @[@"全部",@"选项一",@"选项二"];
    vc.view.layer.cornerRadius = 5;
    [vc.selectButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self presentViewController:vc animated:YES completion:nil];
    __weak typeof(self) weakSelf = self;
    vc.pickerViewSelected = ^(NSString * _Nonnull resultString) {
        weakSelf.result = resultString;
    };
}
@end
