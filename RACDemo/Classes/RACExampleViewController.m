//
//  RACExampleViewController.m
//  RACDemo
//
//  Created by 郑章海 on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACExampleViewController.h"

@interface RACExampleViewController ()
    
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;

@property (weak, nonatomic) IBOutlet UITextField *redTF;
@property (weak, nonatomic) IBOutlet UITextField *greenTF;
@property (weak, nonatomic) IBOutlet UITextField *blueTF;
    
@property (weak, nonatomic) IBOutlet UIView *testView;

@end

@implementation RACExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initSignal];

    [self test];
    
    [self sequenceAndMap];
    
    [self filterDemo];
    
    [self flattenMapDemo];
}


- (void)flattenMapDemo {
    // flattenMap 用于处理RACSequence中的RACSequence
    // 会将满足条件的组合到一个RACSequence中
    RACSequence *s1 = [@[@(1), @(2), @(3), @(6)] rac_sequence];
    RACSequence *s2 = [@[@(1), @(3), @(6), @(9)] rac_sequence];
    RACSequence *s3 = [[@[s1, s2] rac_sequence] flattenMap:^__kindof RACSequence * _Nullable(id  _Nullable value) {
        return [value filter:^BOOL(id  _Nullable value) {
            return ([value integerValue] % 3 == 0);
        }];
    }];
    NSLog(@"flattenMapDemo");
    NSLog(@"%@", [s3 array]);
}
- (void)filterDemo {
    NSArray *array = @[@(1), @(2), @(3), @(4), @(5)];
    RACSequence *sequeue = [array rac_sequence];
    
    // filter相当于筛选，把满足条件的留下，不满足条件的踢出
    RACSequence *filterSequeue = [sequeue filter:^BOOL(id  _Nullable value) {
        return ([value integerValue] % 2 == 1);
    }];
    
    NSArray *filterArr = [filterSequeue array];
    
    NSLog(@"filterDemo");
    NSLog(@"%@", filterArr);
    
}
    
- (void)sequenceAndMap {
    
    // pull 拉 （RACSignal）
    // push 推 （RACSequeue）
    
    NSArray *array = @[@(1), @(2), @(3), @(4)];
    // RACSequence 是数组的容器， 跟signal的原理是相反的
    // 将数组转，序列可以使用map函数
    RACSequence *sequence = [array rac_sequence];
    // map 叫做映射，把所有元素都做同样的处理
    RACSequence *mapSequence = [sequence map:^id _Nullable(id  _Nullable value) {
        return @([value integerValue]*3);
    }];
    
    // 再将序列转数组
    NSArray *resultArr = [mapSequence array];
    NSLog(@"sequenceAndMap");
    NSLog(@"%@", resultArr);
}
    
    // rac 中的坑
- (void)test {
    
    __block int num = 10;
//    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        num += 5;
//        [subscriber sendNext:@(num)];
//        [subscriber sendCompleted];
//
//        return nil;
//    }];
    RACSignal *signal = [[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        num += 5;
        [subscriber sendNext:@(num)];
        [subscriber sendCompleted];
        
        return nil;
    }] replayLast];
    
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
}
    
- (void)initSignal {
    _redTF.text = _greenTF.text = _blueTF.text = @"0.5";
    RACSignal *redSignal = [self bindSlider:_redSlider textField:_redTF];
    RACSignal *greenSignal = [self bindSlider:_greenSlider textField:_greenTF];
    RACSignal *blueSignal = [self bindSlider:_blueSlider textField:_blueTF];
    
//    [[RACSignal combineLatest:@[redSignal, greenSignal, blueSignal]] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    
//    [[[RACSignal combineLatest:@[redSignal, greenSignal, blueSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
//        return [UIColor colorWithRed:[value[0] floatValue]
//                               green:[value[1] floatValue]
//                                blue:[value[2] floatValue]
//                               alpha:1];
//    }] subscribeNext:^(id  _Nullable x) {
//        _testView.backgroundColor = x;
//    }] ;
    
    RAC(_testView, backgroundColor) = [[RACSignal combineLatest:@[redSignal, greenSignal, blueSignal]] map:^id _Nullable(RACTuple * _Nullable value) {
        return [UIColor colorWithRed:[value[0] floatValue]
                               green:[value[1] floatValue]
                                blue:[value[2] floatValue]
                               alpha:1];
    }];
}
    
- (RACSignal *)bindSlider:(UISlider *)slider textField:(UITextField *)textField {
    RACSignal *textSignal = [[textField rac_textSignal] take:1];
    
    RACChannelTerminal *signalSlider = [slider rac_newValueChannelWithNilValue:nil];
    RACChannelTerminal *signalText = [textField rac_newTextChannel];
    
    [signalText subscribe:signalSlider];
    [[signalSlider map:^id _Nullable(id  _Nullable value) {
        return [NSString stringWithFormat:@"%.02f", [value floatValue]];
    }] subscribe:signalText];
    
    return [[signalText merge:signalSlider] merge:textSignal];
}

   
    
    

@end
