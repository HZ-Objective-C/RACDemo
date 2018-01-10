//
//  RACTableViewController.m
//  RACDemo
//
//  Created by Harious on 2018/1/9.
//  Copyright © 2018年 zzh. All rights reserved.
//

#import "RACTableViewController.h"
#import "RACCombineViewController.h"
#import "RACDefineViewController.h"
#import "RACExampleViewController.h"
#import "RACLoginViewController.h"

@interface RACTableViewController ()

@property (nonatomic, copy)   NSDictionary <NSString *, Class>*dataSource;

@property (nonatomic, copy)   NSArray <NSString *>*cellTiles;


@end

@implementation RACTableViewController

- (NSDictionary <NSString *, Class>*)dataSource {
    if (!_dataSource) {
        _dataSource = @{@"commbine": [RACCombineViewController class],
                        @"RAC 中的宏解析": [RACDefineViewController class],
                        @"一个例子": [RACExampleViewController class],
                        @"登录的例子": [RACLoginViewController class]
                        };
    }
    return _dataSource;
}

- (NSArray <NSString *>*)cellTiles {
    if (!_cellTiles) {
        _cellTiles = self.dataSource.allKeys;
    }
    return _cellTiles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"RAC Demo";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    
}

#pragma mark:   ----------  UItableViewDatasource, UITableViewDelegate  ---------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellTiles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.textLabel.text = self.cellTiles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    NSString *cellTitle = self.cellTiles[indexPath.row];
    Class class = self.dataSource[cellTitle];
    RACBaseViewController *vc = [[class alloc] init];
    
    vc.navigationItem.title = cellTitle;
    [self.navigationController pushViewController:vc animated:true];
}


@end
