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
@interface DiveListController ()

@end

@implementation DiveListController

NSArray *arrayOfLocations;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.DiveListTableView.dataSource = self;
    self.DiveListTableView.delegate = self;
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    appD.DLC = self.DiveListTableView;
    
    [self updateLocations];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    
    
    UIBarButtonItem *anotherButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(didReceiveMemoryWarning:)];
    self.tabBarController.navigationController.navigationItem.rightBarButtonItem = anotherButton;
    [self updateLocations];
    
    
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
