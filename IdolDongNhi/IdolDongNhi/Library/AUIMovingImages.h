//
//  AUIMovingImages.h
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 5/4/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AUIMovingImages : UIView{
    int movingDirection;
    UIImageView *imageViewMoving;
    int movingX, movingY;
}

@property BOOL isMovingImage;
@property (nonatomic, strong) UIImage *imageMoving;
@property (nonatomic, strong) NSString *textMoving;
@property (nonatomic, strong) UIFont *font;

- (void) setImage:(UIImage *) image andText: (NSString *)text;
@end
