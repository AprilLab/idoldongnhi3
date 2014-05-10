//
//  AUIMovingImages.m
//  IdolDongNhi
//
//  Created by Vu Duy Khanh on 5/4/14.
//  Copyright (c) 2014 April. All rights reserved.
//

#import "AUIMovingImages.h"

@implementation AUIMovingImages

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setImage:(UIImage *) image andText: (NSString *)text{
    if(self.imageMoving != image){
        self.imageMoving = image;
        self.textMoving = text;
        [self setUp];
    }
}

- (void) setUp{
    imageViewMoving = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageMoving.size.width, self.imageMoving.size.height)];
    [imageViewMoving setImage:self.imageMoving];
    [self addSubview:imageViewMoving];
    
    //UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(20, 385, 280, 80)];
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    scroll.contentSize = CGSizeMake(self.imageMoving.size.width, self.imageMoving.size.height);
    scroll.scrollEnabled= NO;
    [scroll addSubview:imageViewMoving];
    
    [scroll setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    
    UIImageView *transparentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    transparentView.image= [UIImage imageNamed:@"bg_news"];
    transparentView.alpha= 0.6;
    [scroll addSubview:transparentView];
    
    UILabel *lblTextMoving = [[UILabel alloc] initWithFrame:CGRectMake(15, 50, self.frame.size.width - 20, 18)];
    lblTextMoving.text= self.textMoving;
    lblTextMoving.textColor= [UIColor whiteColor];
    lblTextMoving.font= self.font;
    [scroll addSubview:lblTextMoving];
    
    
    [self addSubview:scroll];
    [self setBackgroundColor:[UIColor whiteColor]];
    
    
    [NSTimer scheduledTimerWithTimeInterval: 0.05 target: self
                                   selector: @selector(movingImage) userInfo: nil repeats: YES];
}

- (void) movingImage{

    if(self.isMovingImage){
        if (movingDirection == 0) {
            movingX = movingX- 1;
            movingY = movingY- 1;
            if (movingX <=0 || movingY <=0) {
                movingDirection = 1;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [UIView beginAnimations:nil context:NULL];
                    imageViewMoving.alpha= 0.2;
                    [UIView setAnimationDuration:2];
                    [UIView commitAnimations];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView beginAnimations:nil context:NULL];
                        imageViewMoving.alpha= 1;
                        [UIView setAnimationDuration:2];
                        [UIView commitAnimations];
                        [imageViewMoving setImage:self.imageMoving];
                    });
                });
            }
        }else{
            movingX = movingX + 1;
            movingY = movingY + 1;
            if (movingX >=320 || movingY >=200) {
                movingDirection= 0;
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    
                    [UIView beginAnimations:nil context:NULL]; // animate the following:
                    imageViewMoving.alpha= 0.2;
                    [UIView setAnimationDuration:2];
                    [UIView commitAnimations];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [UIView beginAnimations:nil context:NULL]; // animate the following:
                        imageViewMoving.alpha= 1;
                        [UIView setAnimationDuration:2];
                        [UIView commitAnimations];
                        UIImage *image = self.imageMoving;
                        [imageViewMoving setImage:image];
                    });
                });
                
            }
        }
        
        [imageViewMoving setCenter:CGPointMake(movingX , movingY)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
