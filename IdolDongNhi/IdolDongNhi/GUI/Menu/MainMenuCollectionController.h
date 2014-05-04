//
//  CollectionController.h
//  April
//
//  Created by admin on 4/21/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>

//For Delegate
@class MainMenuCollectionController;
@protocol MainMenuCollectionControllerDelegate

@end

@interface MainMenuCollectionController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
@property(nonatomic, assign)NSUInteger index;
@property (weak, nonatomic) id <MainMenuCollectionControllerDelegate> delegate;
@end
