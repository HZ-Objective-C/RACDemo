//
//  RACDefineViewController.m
//  RACDemo
//
//  Created by Harious on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACDefineViewController.h"

#define NUMBER 10

#define ADD(num1,num2) (num1 + num2)

#define STRING_(value) #value

/// 多转一次是为了识别参数中传的也是一个宏
#define add_string(str1,str2) _add_string(str1,str2)
#define _add_string(str1,str2) (str1##str2)



@implementation RACDefineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testDefine];
}


- (void)testDefine {
    
    
    NSLog(@"%s", metamacro_stringify(990090dsnfd 3487 hdkh));
    
    NSLog(@"%d", ADD(NUMBER, NUMBER));
    NSLog(@"%d", add_string(NUMBER, NUMBER));
}
@end
