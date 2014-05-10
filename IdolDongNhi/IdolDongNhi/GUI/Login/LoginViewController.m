//
//  LoginViewController.m
//  April
//
//  Created by admin on 4/22/14.
//  Copyright (c) 2014 Icde. All rights reserved.
//

#import "LoginViewController.h"
#import "PlayingMusicView.h"
#import "AUIFreedomController.h"
#import "ManageSize.h"
#import <Social/Social.h>

@interface LoginViewController ()
{
    UIScrollView *scrollView;
    UITextField *usernameTextField;
    UITextField *passwordTextField;
    UITextField *shareTextField;
}
@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setClipsToBounds:YES];
    
    
    // BACKGROUND
    // ======
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [scrollView setShowsVerticalScrollIndicator:NO];
    [scrollView setScrollEnabled:NO];
    [self.view addSubview:scrollView];
    
    
    
    // KIEM TRA TINH TRANG LOGIN
    // =====
    
    
    
    
    
    // LOGIN
    // =====
    usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 100, 320, 40)];
    [usernameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [scrollView addSubview:usernameTextField];
    
    passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 140, 320, 40)];
    [passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [scrollView addSubview:passwordTextField];
    
    UIButton *loginButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 190, 320, 30)];
    [loginButton setTitle:@"login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [loginButton addTarget:self action:@selector(actionLogin:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:loginButton];
    
    
    
    UIButton *userButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 220, 320, 30)];
    [userButton setTitle:@"user" forState:UIControlStateNormal];
    [userButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [userButton addTarget:self action:@selector(actionUser:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:userButton];
    
    
    
    
    // SHARE
    // =====
    shareTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 300, 320, 40)];
    [shareTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [scrollView addSubview:shareTextField];
    
    UIButton *shareButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 350, 320, 30)];
    [shareButton setTitle:@"share" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(actionShare:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:shareButton];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


- (void) actionLogin:(id)sender
{
    // get data
    NSString *username = [usernameTextField text];
    NSString *password = [passwordTextField text];
    
    NSLog(@"username/password: %@/%@", username, password);
    
    // ----
    NSDictionary *testDic = [ManageSize getDictionaryJSONFromServer:@"//idol.april.com.vn/api/login/tuzebra/huyhaha"];
    NSLog(@"testDic: %@", testDic);
}

- (void) actionUser:(id)sender
{
    // ----
    NSDictionary *testDic = [ManageSize getDictionaryJSONFromServer:@"//idol.april.com.vn/api/user"];
    NSLog(@"testDic: %@", testDic);
}





- (void) actionShare:(id)sender
{
    // get text
    NSString *text = [shareTextField text];
    
    // tao moi 1 controller share facebook
    SLComposeViewController *composeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    // set text
    [composeViewController setInitialText:text];
    [composeViewController addImage:[UIImage imageNamed:@"dn1.jpg"]];
    
    [self presentViewController:composeViewController animated:YES completion:nil];
}

- (void) keyboardWillShow:(NSNotification *)notify
{
    // get keyboard frame
    NSDictionary *userInfo = (NSDictionary *)[notify userInfo];
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGRect convertedFrame = [self.view convertRect:keyboardFrame fromView:self.view.window];
    
    NSLog(@"keyboardFrame: %f, %f, %f, %f", keyboardFrame.origin.x, keyboardFrame.origin.y, keyboardFrame.size.width, keyboardFrame.size.height);
    NSLog(@"convertedFrame: %f, %f, %f, %f", convertedFrame.origin.x, convertedFrame.origin.y, convertedFrame.size.width, convertedFrame.size.height);
    
    // set lai height cua scrollview
    [scrollView setContentSize:CGSizeMake(scrollView.frame.size.width, scrollView.frame.size.height + convertedFrame.size.height)];
    [scrollView scrollRectToVisible:CGRectMake(0, scrollView.frame.size.height, scrollView.frame.size.width, convertedFrame.size.height) animated:YES];
    
    // cho manual scroll
    [scrollView setScrollEnabled:YES];
}

- (void) keyboardWillHide:(id)sender
{
    // scroll thoi
    [scrollView scrollRectToVisible:CGRectMake(0, 0, scrollView.frame.size.width, scrollView.frame.size.height) animated:YES];
    
    // tra ve khong cho scroll nua
    [scrollView setScrollEnabled:NO];
}


@end
