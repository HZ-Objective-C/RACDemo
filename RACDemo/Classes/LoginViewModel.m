//
//  LoginViewModel.m
//  RACDemo
//
//  Created by 郑章海 on 2018/1/10.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel

- (instancetype)init {
    if (self = [super init]) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    _loginSignal = [RACSignal combineLatest:@[RACObserve(self, userName), RACObserve(self, pwd)] reduce:^id _Nonnull(NSString *userName, NSString *pwd){
        return @(userName.length && pwd.length);
    }];
    
    _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"发送登录请求"];
            
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
    [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"登录中");
            
        } else {
            NSLog(@"完成登录");
        }
    }];
    
    [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
}
@end
