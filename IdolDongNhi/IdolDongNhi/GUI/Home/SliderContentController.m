//
//  SliderContentController.m
//  April
//
//  Created by admin on 4/23/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "SliderContentController.h"

@interface SliderContentController ()

@end

@implementation SliderContentController
@synthesize index, img;

- (void)viewDidLoad{
    [super viewDidLoad];
    img= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 280, 250)];
    UIImage *src;
    if (index==0 || index == 2 || index == 4) {
        src= [UIImage imageNamed:@"dn1.jpg"];
    }else{
        src= [UIImage imageNamed:@"dn2.jpg"];
    }
    
    img.image= src;
    img.contentMode= UIViewContentModeScaleAspectFill;
    [self.view addSubview:img];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
