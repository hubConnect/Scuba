//
//  MyInvoViewController.h
//  DivePro
//
//  Created by Jon Kotowski on 3/9/15.
//  Copyright (c) 2015 Jon Kotowski. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import <ParseFacebookUtils/PFFacebookUtils.h>

@interface MyInvoViewController : ViewController <PFLogInViewControllerDelegate>
- (IBAction)FacebookHit:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *FacebookHit;
- (IBAction)ParseHit:(id)sender;

@end
