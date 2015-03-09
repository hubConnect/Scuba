//
//  DiveListController.m
//  DivePro
//
//  Created by Jon Kotowski on 12/17/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "DiveListController.h"
#import "AppDelegate.h"
#import "DiveListCellTableViewCell.h"
#import "DiveLocation.h"
#import "DYRateView.h"
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
@interface DiveListController ()

@end

@implementation DiveListController

NSArray *arrayOfLocations;

UIBarButtonItem *showButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.DiveListTableView.dataSource = self;
    self.DiveListTableView.delegate = self;
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    appD.DLC = self.DiveListTableView;
    
    [self setButton];
    
    [self updateLocations];
    // Do any additional setup after loading the view.
}

-(void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user{
    NSLog(@"yeah %@",user.name);
}

- (void)viewDidAppear:(BOOL)animated {
    FBLoginView *login =
    [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"email", @"user_friends"]];
    login.center = self.view.center;
    login.delegate = self;
    [self.view addSubview:login];

}

- (void)loadData {
    // ...
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            // result is a dictionary with the user's Facebook data
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            NSString *name = userData[@"name"];
            NSString *location = userData[@"location"][@"name"];
            NSString *gender = userData[@"gender"];
            NSString *birthday = userData[@"birthday"];
            NSString *relationship = userData[@"relationship_status"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            // Now add the data to the UI elements
            // ...
        }
    }];
}

-(void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSLog(@"Error");
}
- (void) setButton {
    
    
    showButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(loadData)];
    showButton.title = @"Filter";

        
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"bam");
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

-(void)viewWillDisappear:(BOOL)animated {
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    appD.mainNav.topViewController.navigationItem.rightBarButtonItem = showButton;
    
    [self updateLocations];
    NSLog(@"Coming into view");
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) updateLocations {
    
    AppDelegate * appD = [UIApplication sharedApplication].delegate;
    arrayOfLocations = [appD.arrayOfLocations copy];
    
    [self.DiveListTableView reloadData];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"DiveCell";
    DiveListCellTableViewCell *cell = (DiveListCellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    DiveLocation *location = arrayOfLocations[indexPath.row];
    
    if(cell == nil)
    {
        cell = [[DiveListCellTableViewCell alloc] init];
    }
    // Configure the cell...
    
    if (indexPath.row == 0) {
        
        cell.NameLabel.text = location.Name;
        //cell.textLabel.textColor = [UIColor whiteColor];
        //cell.backgroundColor = [UIColor clearColor];
        
    } else if (indexPath.row != 0) {
        
        cell.NameLabel.text = location.Name;
        NSLog(@"%@ is the name",location.Name);
        //cell.textLabel.textColor = [UIColor whiteColor];
        //cell.backgroundColor = [UIColor clearColor];
    }
    
    
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:cell.RatingViewOutlet.frame
                                                    fullStar:[UIImage imageNamed:@"StarFullLarge.png"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
    [rateView setRate:location.Rating];
    
    cell.RatingViewOutlet = rateView;
    [cell addSubview:rateView];

    
    //Image
    PFFile
    * file = [location.Pictures firstObject];
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithFrame:cell.Photo.frame];
    
    [spinner setTintColor:[UIColor blueColor]];
    [cell.Photo addSubview:spinner];
    
    [spinner startAnimating];
//    
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        
//        UIImage *img = [UIImage imageWithData:data];
//        //cell.Photo.image = img;
//        
//        if (error) {
//            
//            NSLog(@"Err");
//
//        } else {
//            
//            if (data == nil) {
//                NSLog(@"Other err");
//            }
//        }
//        //[spinner removeFromSuperview];
//        [self.DiveListTableView reloadData];
//        
//    }];

    
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate * appD = [UIApplication sharedApplication].delegate;
    return appD.arrayOfLocations.count;
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
