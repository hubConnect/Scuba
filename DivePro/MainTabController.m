//
//  MainTabController.m
//  DivePro
//
//  Created by Jon Kotowski on 12/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "MainTabController.h"

@interface MainTabController ()

@end

@implementation MainTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self setNavigationButton];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setNavigationButton {
    
    self.navigationController.navigationItem.rightBarButtonItem.title = @"Blah";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
