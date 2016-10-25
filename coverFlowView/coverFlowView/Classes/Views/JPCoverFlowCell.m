//
//  JPCoverFlowCell.m
//  coverFlowView
//
//  Created by 哇咔咔 on 16/8/2.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "JPCoverFlowCell.h"
#import "Masonry.h"

@implementation JPCoverFlowCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage new]];
    
    imageView.backgroundColor = [UIColor blueColor];
    
    imageView.layer.cornerRadius = 10;
    
    imageView.layer.masksToBounds = YES;
    
    imageView.layer.borderColor = (__bridge CGColorRef _Nullable)((__bridge id)[UIColor redColor].CGColor);
    
    imageView.layer.borderWidth = 5;
    
    [self.contentView addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}
@end
