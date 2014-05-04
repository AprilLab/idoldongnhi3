//
//  CollectionCell.m
//  April
//
//  Created by admin on 4/21/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "MainMenuCollectionCell.h"

@implementation MainMenuCollectionCell

@synthesize lblTitle, imgThumb, cellId;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(-5, 60, 61, 30)];
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.textAlignment= NSTextAlignmentCenter;
        self.lblTitle.font = [UIFont fontWithName:@"Arial" size:12.0f];
        
        [self addSubview:self.lblTitle];
    
    }
    return self;
}


@end
