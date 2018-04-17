//
//  ViewController.m
//  TTTouchID
//
//  Created by Loren on 2018/1/5.
//  Copyright © 2018年 Loren. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import <Security/Security.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)touchIDAuthentication:(id)sender {
    LAContext * la = [[LAContext alloc] init];
    NSError * error;
    BOOL isOk = [la canEvaluatePolicy:LAPolicyDeviceOwnerAuthentication error:&error];
    if (isOk) {
        //此data存本地 下次比较不一致就说明指纹发生变动
        NSData * data = la.evaluatedPolicyDomainState;
        [la evaluatePolicy:LAPolicyDeviceOwnerAuthentication localizedReason:@"I want you touch id" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                
            }
            else{
                [self showAlert:[NSString stringWithFormat:@"%@",error.userInfo]];
            }
        }];
    }
    else{
        [self showAlert:@"No support touchID"];
    }
}

- (void)showAlert:(NSString *)message{
    UIAlertController * v = [[UIAlertController alloc] init];
    v.title = @"Error";
    v.message = message;
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"YES" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [v addAction:action];
    [self presentViewController:v animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
