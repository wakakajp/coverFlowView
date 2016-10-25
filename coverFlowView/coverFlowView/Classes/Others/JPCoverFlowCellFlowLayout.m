//
//  JPCoverFlowCellFlowLayout.m
//  coverFlowView
//
//  Created by 哇咔咔 on 16/8/2.
//  Copyright © 2016年 jp. All rights reserved.
//

#import "JPCoverFlowCellFlowLayout.h"

@implementation JPCoverFlowCellFlowLayout

- (void)prepareLayout {
    
    [super prepareLayout];
    
    self.minimumLineSpacing = 0;
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat height = self.collectionView.bounds.size.height * 0.8;
    
    CGFloat width = height;
    
    self.itemSize = CGSizeMake(width, height);
    
    CGFloat inset = (self.collectionView.bounds.size.width - width) * 0.5;
    self.sectionInset = UIEdgeInsetsMake(0, inset, 0, inset);
}

//显示区域发生变化就会调用,重新计算布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *oldAttrs = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *tempArrM = [NSMutableArray array];
    
    [oldAttrs enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //copy操作可以防止系统报错,虽然报错也没有什么事情
        UICollectionViewLayoutAttributes *newAttr = obj.copy;
        
        CGFloat screenCenterX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
        
        CGFloat itemCenterX = newAttr.center.x;
        
        CGFloat distance = itemCenterX - screenCenterX;
        //缩放比例
        CGFloat scale = 1 - ABS(distance) / self.collectionView.frame.size.width;
        
        CATransform3D transform = CATransform3DIdentity;
        
        transform = CATransform3DScale(transform, scale, scale, 1);
        
        newAttr.transform3D = transform;
        
        [tempArrM addObject:newAttr];
    }];
    return tempArrM;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGPoint point = [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
    
    CGRect rect;
    rect.size = self.collectionView.bounds.size;
    rect.origin = proposedContentOffset;
    
    CGFloat screenCenterX = self.collectionView.bounds.size.width * 0.5 + proposedContentOffset.x;
    
    NSArray<UICollectionViewLayoutAttributes *> *visibleAttrs = [self layoutAttributesForElementsInRect:rect];
    
    __block CGFloat mimMargin = CGFLOAT_MAX;
    
    __block NSInteger index = -1;
    [visibleAttrs enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGFloat offsetX = obj.center.x - screenCenterX;
        if (ABS(offsetX) < mimMargin ) {
            mimMargin = ABS(offsetX);
            index = idx;
        }
    }];
    CGFloat x = visibleAttrs[index].center.x - screenCenterX;
    
    CGPoint newPoint = CGPointMake(x + point.x, point.y);
    return newPoint;
    
}
@end
