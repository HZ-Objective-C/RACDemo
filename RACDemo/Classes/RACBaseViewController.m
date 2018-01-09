//
//  RacBaseViewController.m
//  RACDemo
//
//  Created by Harious on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACBaseViewController.h"

@interface RACBaseViewController ()

@end

@implementation RACBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)dealloc
{
    NSLog(@"%@  dealloc  ✅", NSStringFromClass([self class]));
}

@end
