//
//  ViewController.m
//  前进回退
//
//  Created by iOS开发者 on 2018/4/12.
//  Copyright © 2018年 iOS开发者. All rights reserved.
//

#import "ViewController.h"
#import <StromanBackForward/StromanBackForward.h>
#import "MBProgressHUD.h"

@interface ViewController ()<BackForwardStackDelegate>

@property (strong, nonatomic) BackForwardStack *statusStack;
@property (weak, nonatomic) IBOutlet UITextView *testTextView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statusStack = [[BackForwardStack alloc] initWithDelegate:self];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)currentStackStatusBackObjectsNumber:(NSInteger)backNumber forwardObjectsNumber:(NSInteger)forwardNumber {
}

- (IBAction)backAction:(UIButton *)sender {
    BackForwardStackModel *model = [self.statusStack backAction];
    if (!model.canBack) {
		MBProgressHUD *alertHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		alertHud.mode = MBProgressHUDModeText;
		alertHud.label.text = @"不能再回退了";
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[alertHud hideAnimated:YES];
		});
    } else {
        self.testTextView.text = model.statusObject;
    }
}

- (IBAction)forwardAction:(UIButton *)sender {
    BackForwardStackModel *model = [self.statusStack forwardAction];
    if (!model.canForward) {
		MBProgressHUD *alertHud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
		alertHud.mode = MBProgressHUDModeText;
		alertHud.label.text = @"不能再前进了";
		dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
			[alertHud hideAnimated:YES];
		});
    } else {
        self.testTextView.text = model.statusObject;
    }
}

- (IBAction)printAction:(UIButton *)sender {
    [self.statusStack printCurrentStack];
}

- (IBAction)newStateSaveAction:(UIButton *)sender {
    [self.statusStack addStatusObject:self.testTextView.text];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
