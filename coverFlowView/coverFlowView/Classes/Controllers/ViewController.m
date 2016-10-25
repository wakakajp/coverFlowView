//
//  ViewController.m
//  coverFlowView
//
//  Created by 哇咔咔 on 16/8/2.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "ViewController.h"
#import "JPCoverFlowCellFlowLayout.h"
#import "Masonry.h"
#import "JPCoverFlowCell.h"
static NSString *cellID = @"cell";
@interface ViewController ()<UICollectionViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}
- (void)setupUI {
    JPCoverFlowCellFlowLayout *coverFlowLayer = [[JPCoverFlowCellFlowLayout alloc] init];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:coverFlowLayer];
    [self.view addSubview:collectionView];
    collectionView.dataSource = self;
    
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.view);
        make.center.equalTo(self.view);
        make.height.mas_equalTo(200);
    }];
    
    [collectionView registerClass:[JPCoverFlowCell class] forCellWithReuseIdentifier:cellID];
}

#pragma mark - tableView的数据源方法
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JPCoverFlowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
