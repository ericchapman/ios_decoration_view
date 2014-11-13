//
//  ViewController.m
//  ECDecorationView
//
//  Created by Eric Chapman on 11/13/14.
//  Copyright (c) 2014 Eric Chapman. All rights reserved.
//

#import "ViewController.h"

static NSString *kDecorationReuseIdentifier = @"section_background";
static NSString *kCellReuseIdentifier = @"view_cell";

@implementation ECCollectionViewLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    self.minimumLineSpacing = 8.0f;
    self.minimumInteritemSpacing = 8.0f;
    self.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    self.itemSize = CGSizeMake(148.0f, 115.0f);
    
    [self registerClass:[ECCollectionReusableView class] forDecorationViewOfKind:kDecorationReuseIdentifier];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [super layoutAttributesForElementsInRect:rect];
    
    NSMutableArray *allAttributes = [NSMutableArray arrayWithArray:attributes];
    
    for (UICollectionViewLayoutAttributes *attribute in attributes) {
        
        // Look for the first item in a row
        if (attribute.frame.size.height == self.itemSize.height
            && attribute.frame.size.width == self.itemSize.width
            && attribute.frame.origin.x == self.sectionInset.left) {
            
            // Create decoration attributes
            ECCollectionViewLayoutAttributes *decorationAttributes =
            [ECCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:kDecorationReuseIdentifier
                                                                        withIndexPath:attribute.indexPath];
            
            // Make the decoration view span the entire row (you can do item by item as well.  I just
            // chose to do it this way)
            decorationAttributes.frame =
            CGRectMake(0,
                       attribute.frame.origin.y-(self.sectionInset.top),
                       self.collectionViewContentSize.width,
                       self.itemSize.height+(self.minimumLineSpacing+self.sectionInset.top+self.sectionInset.bottom));
            
            // Set the zIndex to be behind the item
            decorationAttributes.zIndex = attribute.zIndex-1;
            
            // Add the attribute to the list
            [allAttributes addObject:decorationAttributes];

        }

    }
    
    return allAttributes;
}

@end

@implementation ECCollectionViewLayoutAttributes
+ (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)decorationViewKind
                                                                withIndexPath:(NSIndexPath *)indexPath {
    
    ECCollectionViewLayoutAttributes *layoutAttributes = [super layoutAttributesForDecorationViewOfKind:decorationViewKind
                                                                                              withIndexPath:indexPath];
    if (indexPath.section%2 == 0) {
        layoutAttributes.color = [UIColor redColor];
    } else {
        layoutAttributes.color = [UIColor blueColor];
    }
    return layoutAttributes;
}
@end

@implementation ECCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    [super applyLayoutAttributes:layoutAttributes];
    
    ECCollectionViewLayoutAttributes *ecLayoutAttributes = (ECCollectionViewLayoutAttributes*)layoutAttributes;
    self.backgroundColor = ecLayoutAttributes.color;
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellReuseIdentifier];
    
    self.collectionView.collectionViewLayout = [[ECCollectionViewLayout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection View method subclasses

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView
    numberOfItemsInSection:(NSInteger)section {
    return 7;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:kCellReuseIdentifier
                                                                                forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
}

@end
