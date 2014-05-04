//
//  HomeViewController.m
//  April
//
//  Created by admin on 4/22/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "HomeViewController.h"
#import "SliderContentController.h"
#import "MainMenuViewController.h"
#import "PlayingMusicView.h"
#import "AUIFreedomController.h"
#import "ManageSize.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
UIImageView *imgThumb;
UILabel *lblNews;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // ======
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg"]];
    bgImageView.frame = self.view.bounds;
    [self.view addSubview:bgImageView];
    [self.view sendSubviewToBack:bgImageView];
    [bgImageView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    

    
    // TITLE: DONG NHI
    // ======
    UILabel *lblTitle= [[UILabel alloc]initWithFrame:CGRectMake(0, 40, 320, 80)];
    lblTitle.font = [UIFont fontWithName:@"UTM Bitsumishi Pro" size:40];
    lblTitle.textColor= [UIColor whiteColor];
    lblTitle.textAlignment= NSTextAlignmentCenter;
    lblTitle.text= @"ĐÔNG NHI";
    [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    
    [self.view addSubview:lblTitle];
    
    
    
    // SLIDER
    // ======
    AUICarousel *carousel = [[AUICarousel alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
    [carousel setImages:[NSArray arrayWithObjects:@"dn1@2x.jpg", @"dn2@2x.jpg", nil]];
    [self.view addSubview:carousel];
    
    
    
    // MOVING IMAGES
    // ======
    AUIMovingImages *movingImages = [[AUIMovingImages alloc] initWithFrame:CGRectMake(20, 385, 280, 80)];
    movingImages.isMovingImage = YES;
    UIFont *fontRegular = [UIFont fontWithName:@"OpenSans" size:12];
    movingImages.font = fontRegular;
    [movingImages setImage:[UIImage imageNamed:@"moving-image.jpg"] andText:@"Đông Nhi: “Muốn thành công, phải có bí quyết”"];
    [self.view addSubview:movingImages];
    
    
    
    // MENU BUTTON
    // ======
    
    UIImage *buttonImage = [UIImage imageNamed:@"menu-nav-transparent-border.png"];
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(4, 23, buttonImage.size.width, buttonImage.size.height)];
    
    [menuButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [menuButton addTarget:self action:@selector(menuButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:menuButton];
    
    
    /*
    [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(updateTime:) userInfo:nil repeats:YES];
    */

}

/*

- (void) updateTime:(NSTimer *)timer{
    int random = arc4random() % 4;
    SliderContentController *contentPV= [self viewControllerAtIndex:random];
    
    NSArray *viewControllers = [NSArray arrayWithObject:contentPV];
    

    [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [_pageControll setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    } completion:nil];
    
}
 */

/*

int _x, _y;
bool _moveImage;
-(void) moveImage{
    if (_moveImage) {
        _x= _x- 1;
        _y= _y- 1;
        if (_x<=0 || _y<=0) {
            _moveImage= NO;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [UIView beginAnimations:nil context:NULL];
                imgThumb.alpha= 0.2;
                [UIView setAnimationDuration:2];
                [UIView commitAnimations];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView beginAnimations:nil context:NULL];
                    imgThumb.alpha= 1;
                    [UIView setAnimationDuration:2];
                    [UIView commitAnimations];
                    UIImage *image = [UIImage imageNamed:@"moving-image.jpg"];
                    [imgThumb setImage:image];
                });
            });

        }
    }else{
        _x= _x+ 1;
        _y= _y+ 1;
        if (_x>=320 || _y>=200) {
            _moveImage= YES;
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                
                [UIView beginAnimations:nil context:NULL]; // animate the following:
                imgThumb.alpha= 0.2;
                [UIView setAnimationDuration:2];
                [UIView commitAnimations];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UIView beginAnimations:nil context:NULL]; // animate the following:
                    imgThumb.alpha= 1;
                    [UIView setAnimationDuration:2];
                    [UIView commitAnimations];
                    UIImage *image = [UIImage imageNamed:@"moving-image1.jpg"];
                    [imgThumb setImage:image];
                });
            });
            
        }
    }
    
    [imgThumb setCenter:CGPointMake(_x, _y)];
}

*/


/*
UIPageViewController *_pageControll;
- (SliderContentController *)viewControllerAtIndex:(NSUInteger)index
{
    SliderContentController *contentPV= [[SliderContentController alloc] init];
    contentPV.index= index;
    
    return contentPV;
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index= [(SliderContentController *)viewController index];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index= [(SliderContentController *)viewController index];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index >=5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
}

*/




-(void) scrollViewTouchInside
{
    [ManageSize toggleShowHideMusicBar];
}





-(void) menuButtonClick:(id)sender
{
    [ManageSize showMainMenu];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
