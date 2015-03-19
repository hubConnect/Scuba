//
//  MyInvoViewController.m
//  DivePro
//
//  Created by Jon Kotowski on 3/9/15.
//  Copyright (c) 2015 Jon Kotowski. All rights reserved.
//

#import "MyInvoViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "LoginView.h"

@interface MyInvoViewController ()

- (IBAction)TwitterHit:(id)sender;

@end

@implementation MyInvoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL linkedWithFacebook = [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]];
    NSLog(@"%@",[PFUser currentUser].username );
    [PFUser logOut];
    if ([PFUser currentUser] ) {
        
        
    }
    if (linkedWithFacebook) {
        NSLog(@"logged in with facebook");
    }
    
    LoginView *theView = [[LoginView alloc] init];
  
    
    [self.view addSubview:theView];
    // Do any additional setup after loading the view.
}

-(void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    
    NSLog(@"Facebook login failed - %@",error);
}
- (void)logInViewController:(PFLogInViewController *)controller
                didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)FacebookHit:(id)sender {
    NSLog(@"hit");
    
    
    [PFFacebookUtils logInWithPermissions:@[@"user_about_me",@"public_profile"] block:^(PFUser *user, NSError *error) {
    if (!user) {
        NSLog(@"Uh oh. The user cancelled the Facebook login.");
    } else if (user.isNew) {
        NSLog(@"User signed up and logged in through Facebook!");
    } else {
        NSLog(@"User logged in through Facebook!");
    }
}];
}

- (void)fetchPicture {
    NSURL *profilePictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", @""]];
    NSURLRequest *profilePictureURLRequest = [NSURLRequest requestWithURL:profilePictureURL cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0f]; // Facebook profile picture cache policy: Expires in 2 weeks
    [NSURLConnection connectionWithRequest:profilePictureURLRequest delegate:self];
}

- (IBAction)ParseHit:(id)sender {
    
    PFLogInViewController *logInController = [[PFLogInViewController alloc] init];
    logInController.delegate = self;
    logInController.fields = ( PFLogInFieldsFacebook
                              | PFLogInFieldsTwitter);
    logInController.facebookPermissions =  @[@"public_profile", @"email", @"user_friends"];
    
    [self presentViewController:logInController animated:YES completion:nil];  

}

- (IBAction)TwitterHit:(id)sender {
}
- (IBAction)pow:(id)sender {
    NSLog(@"Pow");
}


@end
