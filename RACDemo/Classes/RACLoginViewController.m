//
//  RACLoginViewController.m
//  RACDemo
//
//  Created by 郑章海 on 2018/1/10.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACLoginViewController.h"
#import "LoginViewModel.h"

@interface RACLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@property (strong, nonatomic) LoginViewModel *loginVM;
@end

@implementation RACLoginViewController

- (LoginViewModel *)loginVM {
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc] init];
    }
    return _loginVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self rac_bind];
    
    [self rac_bind1];

}

- (void)rac_bind1 {
    RAC(self.loginVM, userName) = _userTF.rac_textSignal;
    RAC(self.loginVM, pwd) = _pwdTF.rac_textSignal;
    
    RAC(_loginBtn, enabled) = self.loginVM.loginSignal;
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.loginVM.loginCommand execute:nil];
        
    }];
}

- (void)rac_bind {
    RAC(_loginBtn, enabled) = [RACSignal combineLatest:@[_userTF.rac_textSignal, _pwdTF.rac_textSignal] reduce:^id _Nonnull(NSString *user, NSString *pwd){
        
        return @(user.length && pwd.length);

    }] ;
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"发送登录请求"];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"登录中");
            
        } else {
            NSLog(@"完成登录");
        }
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {

        [command execute:nil];
        
    }];
}



@end
