//
//  AlbumsCell.h
//  Dong Nhi
//
//  Created by Vu Duy Khanh on 4/25/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumsCell : UICollectionViewCell

- (void)setInfo:(NSDictionary *)info;
+ (CGSize)sizeForCellWithIndexPath:(NSIndexPath *)indexPath;

@end
