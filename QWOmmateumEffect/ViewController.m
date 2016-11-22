//
//  ViewController.m
//  QWOmmateumEffect
//
//  Created by More Mocha on 16/11/22.
//  Copyright © 2016年 QivenDev. All rights reserved.
//

#import "ViewController.h"
#import "QWOmmateumEffectCell.h"

#define QWGetImage(row) [UIImage imageNamed:[NSString stringWithFormat:@"%zd",row]]

static NSString *cellid = @"cellid";

@interface ViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>{
    UITableView *_tableview;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}


#pragma mark - LoadUI

- (void)initUI {
    _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [_tableview registerClass:[QWOmmateumEffectCell class] forCellReuseIdentifier:cellid];
    _tableview.rowHeight   =    200;
    _tableview.dataSource  =    self;
    _tableview.delegate    =    self;
    [self.view addSubview:_tableview];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollViewDidScroll:[[UIScrollView alloc] init]];
    });
}


#pragma mark - Table View DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QWOmmateumEffectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid forIndexPath:indexPath];
    
    cell.backgroundImageView.image = QWGetImage(indexPath.row+1);
    cell.tempLabelText = [NSString stringWithFormat:@"第%zd张", indexPath.row+1];
    return cell;
}


#pragma mark - Tabel View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for (QWOmmateumEffectCell *cell in [_tableview visibleCells]) {
        [cell startCellOmmateumEffect:self.view];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
