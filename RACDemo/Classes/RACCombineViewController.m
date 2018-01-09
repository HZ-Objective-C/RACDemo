//
//  RACCombineViewController.m
//  RACDemo
//
//  Created by Harious on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACCombineViewController.h"

@interface RACCombineViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RACCombineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self combine];
//    [self combineReduce];
}

- (void)combine {
    
    // RACTuple相当于swift中的元组
    @weakify(self);
    [[RACSignal combineLatest:@[self.userTF.rac_textSignal, self.pwdTF.rac_textSignal]] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        
        NSLog(@"%@  %@", x.first, x.second);
        
        /// 这个元组越界后不会崩溃，越界的元素会返回一个nil
        NSLog(@"%@  %@ %@", x.first, x.second, x.third);
        
        BOOL verify = [self verify:x.first pwd:x.second];
        self.sureBtn.userInteractionEnabled = verify;
        self.sureBtn.backgroundColor = verify ? [UIColor orangeColor] : [UIColor lightGrayColor];
        
    }];
}

- (void)combineReduce {
    
    @weakify(self);
    [[RACSignal combineLatest:@[self.userTF.rac_textSignal, self.pwdTF.rac_textSignal] reduce:^id _Nonnull(NSString *userName, NSString *pwd){
        
         @strongify(self);
        
        NSLog(@"%@   %@", userName, pwd);
        
        /// 这个返回的值将会被传到下面的这个block中
        return @([self verify:userName pwd:pwd]);
    }] subscribeNext:^(id  _Nullable x) {
        
        @strongify(self);
        
        BOOL isUse = ((NSNumber *)(x)).boolValue;
        self.sureBtn.userInteractionEnabled = isUse;
        self.sureBtn.backgroundColor = isUse ? [UIColor orangeColor] : [UIColor lightGrayColor];
    }];
}

- (BOOL)verify:(NSString *)userNmae pwd:(NSString *)pwd {
    
    if (userNmae == nil || pwd == nil) return false;
    if ([userNmae isEqualToString:@""] || [pwd isEqualToString:@""]) return false;
    
    return true;
}

@end
