//
//  CollectionCell.h
//  April
//
//  Created by admin on 4/21/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainMenuCollectionCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) NSString *strImage;

@property (assign, nonatomic) int cellId;
@property (strong, nonatomic) IBOutlet UIImageView *imgThumb;
@end
