//
//  JCCollectionViewTagFlowLayout.m
//  JCTagListView
//
//  Created by 李京城 on 15/7/3.
//  Copyright (c) 2015年 李京城. All rights reserved.
//

#import "JCCollectionViewTagFlowLayout.h"

@interface JCCollectionViewTagFlowLayout()

@property (nonatomic, weak) id<UICollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, strong) NSMutableArray *itemAttributes;

@property (nonatomic, assign) CGFloat contentHeight;

@end

@implementation JCCollectionViewTagFlowLayout

- (id)init
{
    self = [super init];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.itemSize = CGSizeMake(100.0f, 26.0f);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumInteritemSpacing = 10.0f;
    self.minimumLineSpacing = 10.0f;
    self.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
    
    _itemAttributes = [NSMutableArray array];
}

#pragma mark -

- (void)prepareLayout
{
    [self.itemAttributes removeAllObjects];
    
    self.contentHeight = self.sectionInset.top + self.itemSize.height;
    
    CGFloat originX = self.sectionInset.left;
    CGFloat originY = self.sectionInset.top;
    
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger i = 0; i < itemCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        CGSize itemSize = [self itemSizeForIndexPath:indexPath];
        
        if ((originX + itemSize.width + self.sectionInset.right/2) > self.collectionView.frame.size.width) {
            originX = self.sectionInset.left;
            originY += itemSize.height + self.minimumLineSpacing;
            
            self.contentHeight += itemSize.height + self.minimumLineSpacing;
        }
        
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        attributes.frame = CGRectMake(originX, originY, itemSize.width, itemSize.height);
        [self.itemAttributes addObject:attributes];
        
        originX += itemSize.width + self.minimumInteritemSpacing;
    }
    
    self.contentHeight += self.sectionInset.bottom;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.frame.size.width, self.contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.itemAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    CGRect oldBounds = self.collectionView.bounds;
    
    if (CGRectGetWidth(newBounds) != CGRectGetWidth(oldBounds)) {
        return YES;
    }
    
    return NO;
}

#pragma mark -

- (id<UICollectionViewDelegateFlowLayout>)delegate
{
    if (!_delegate) {
        _delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    }
    
    return _delegate;
}

- (CGSize)itemSizeForIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
        self.itemSize = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];
    }
   
    return self.itemSize;
}

@end
