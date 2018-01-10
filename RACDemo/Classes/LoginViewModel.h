//
//  LoginViewModel.h
//  RACDemo
//
//  Created by 郑章海 on 2018/1/10.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

@property (copy, nonatomic) NSString *userName;

@property (copy, nonatomic) NSString *pwd;

@property (strong, nonatomic) RACSignal *loginSignal;

@property (strong, nonatomic) RACCommand *loginCommand;

@end
