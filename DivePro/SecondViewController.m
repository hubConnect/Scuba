//
//  SecondViewController.m
//  DivePro
//
//  Created by Jon Kotowski on 12/5/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch ;
    touch = [[event allTouches] anyObject];
    NSLog(@"Touch event");
    
    if ([touch view] == self.view)
    {
        NSLog(@"Touched map");
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
