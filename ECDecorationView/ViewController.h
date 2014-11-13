//
//  ViewController.h
//  ECDecorationView
//
//  Created by Eric Chapman on 11/13/14.
//  Copyright (c) 2014 Eric Chapman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ECCollectionViewLayout : UICollectionViewFlowLayout

@end

@interface ECCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes
@property (nonatomic, strong) UIColor *color;
@end

@interface ECCollectionReusableView : UICollectionReusableView

@end

@interface ViewController : UICollectionViewController <UICollectionViewDataSource>


@end

