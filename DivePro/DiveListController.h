//
//  DiveListController.h
//  DivePro
//
//  Created by Jon Kotowski on 12/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface DiveListController : UIViewController
<UITableViewDataSource,UITableViewDelegate,FBLoginViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *DiveListTableView;

@end
