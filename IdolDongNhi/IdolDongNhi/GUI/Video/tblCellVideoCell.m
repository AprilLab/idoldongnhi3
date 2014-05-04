//
//  tblCellVideoCell.m
//  April
//
//  Created by admin on 4/18/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "tblCellVideoCell.h"

@implementation tblCellVideoCell
@synthesize lblTitle;
@synthesize lblTime;
@synthesize imgThumb;
@synthesize lbltemp;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        if (1) {
            UILabel *lblBackground= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
            lblBackground.backgroundColor= [UIColor grayColor];
            lblBackground.alpha= 0.2;
            [self addSubview:lblBackground];
            [self sendSubviewToBack:lblBackground];
        }
        

        self.imgThumb = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 60)];
        self.imgThumb.contentMode= UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"dn3.jpg"];
        [self.imgThumb setImage:image];
        [self addSubview:self.imgThumb];
        
        
        
        
        
        /*
        UILabel *lblAlpha= [[UILabel alloc] initWithFrame:CGRectMake(0, 185, 320, 25)];
        lblAlpha.backgroundColor= [UIColor blackColor];
        [self addSubview:lblAlpha];
        
        
        
        
       
        UILabel *lblAlphaTitle= [[UILabel alloc] initWithFrame:CGRectMake(0, 160, 320, 25)];
        lblAlphaTitle.backgroundColor= [UIColor blackColor];
        lblAlphaTitle.alpha= 0.3;
        [self addSubview:lblAlphaTitle];
        */
        
        
        
        self.lblTime = [[UILabel alloc] initWithFrame:CGRectMake(95, 25, 320, 25)];
        self.lblTime.textColor = [UIColor whiteColor];
        self.lblTime.font = [UIFont fontWithName:@"Arial" size:12.0f];
        [self addSubview:self.lblTime];
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(95, 5, 320, 25)];
        self.lblTitle.textColor = [UIColor whiteColor];
        self.lblTitle.font = [UIFont fontWithName:@"Arial-Bold" size:12.0f];
        self.lblTitle.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lblTitle];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
