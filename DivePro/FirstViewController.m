//
//  FirstViewController.m
//  DivePro
//
//  Created by Jon Kotowski on 12/5/14.
//  Copyright (c) 2014 Jon Kotowski. All rights reserved.
//

#import "MapCell.h"
#import "FirstViewController.h"
#import "PlaceDetailVO.h"
#import "InfoWindow.h"
#import <Parse/Parse.h>
#import "DiveLocation.h"
#import "DYRateView.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    
    GMSMapView *mapView_;
    CLLocationManager *locationManager;
    NSMutableDictionary *dictionaryOfMarkerInfo;
    NSMutableArray *arrayOfLocations;
    NSOperationQueue *opQueue;
    NSOperationQueue *mainQueue;
    NSMutableArray *arrayOfMarkers;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches Ended");
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch ;
    touch = [[event allTouches] anyObject];
    NSLog(@"Touch event");
    
    if ([touch view] == mapView_)
    {
        NSLog(@"Touched map");
    }
}

-(void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    NSLog(@"Long press at - %lf %lf ", coordinate.longitude, coordinate.latitude);
}

-(void)viewDidAppear:(BOOL)animated
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    
    button.title = @"List";
    
    
    NSLog(@"Button items added");
    
    
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker {
    InfoWindow *view =  [[[NSBundle mainBundle] loadNibNamed:@"InfoWindow" owner:self options:nil] objectAtIndex:0];
    //view.name.text = @"Place Name";
    //view.description.text = @"Place description";
    //view.phone.text = @"123 456 789";
    //view.placeImage.image = [UIImage imageNamed:@"customPlaceImage"];
    //view.placeImage.transform = CGAffineTransformMakeRotation(-.08);

    DiveLocation *dive = ((DiveLocation *)marker.userData);
    NSString *string = dive.Name;
    view.NameLabel.text = dive.Name;
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:view.RatingRect.frame
        fullStar:[UIImage imageNamed:@"StarFullLarge.png"] emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
    [rateView setRate:dive.Rating];
    
    view.RatingRect = rateView;
    [view addSubview:rateView];
    
    NSLog(@"%@", string);

    return view;
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    NSLog(@"Hit info window");
}

-(BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
    
//    [self.tabBarController performSegueWithIdentifier:@"PushDetail" sender:self.tabBarController];
//    NSLog(@"Marker hit");
//    GMSMarker *tempMarker = [[GMSMarker alloc] init];
//    CLLocationCoordinate2D loc = marker.position;
//    loc.latitude = loc.latitude + .01;
//    tempMarker .position = loc;
//    tempMarker.title = @"blah";
//    tempMarke/Users/JonKotowski/Documents/Scuba/DivePro/FirstViewController.mr.snippet = @"another blah";
//    
//    
//    tempMarker.map = mapView_;
    NSLog(@"Hit");
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    opQueue = [[NSOperationQueue alloc] init];
    mainQueue = [NSOperationQueue mainQueue];
    [opQueue addOperationWithBlock:^{
        
        
        
        
        NSLog(@"Ending operation.");

        
    }];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationManager.location.coordinate.latitude longitude:locationManager.location.coordinate.longitude zoom:1];
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    
    self.view = mapView_;
    mapView_.myLocationEnabled = YES;
    mapView_.mapType = kGMSTypeSatellite;
    
    mapView_.camera = [GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude longitude:mapView_.myLocation.coordinate.longitude zoom:1];

    mapView_.delegate = self;

    [opQueue addOperationWithBlock:^{
        
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        
        
        [locationManager startUpdatingLocation];
        
        // Creating test markers.
        
        

    }];
    
    [self downloadLocations];
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    
    NSLog(@"starting");
}

- (void) downloadLocations {
    arrayOfLocations = [[NSMutableArray alloc]init];
    
    AppDelegate *appd = [UIApplication sharedApplication].delegate;

    PFQuery *query = [PFQuery queryWithClassName:@"Dive"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Fetching");
        if (!error) {
            for (PFObject *object in objects) {
                
                NSString *string = [object objectForKey:@"Name"];
                DiveLocation * theLocation = [[DiveLocation alloc] init];
                theLocation.Name = string;
                PFGeoPoint *geopoint = (PFGeoPoint *)[object objectForKey:@"Location"];
                
                NSNumber *theNumber = (NSNumber *)[object objectForKey:@"Rating"];
                float number = [theNumber floatValue];
                theLocation.Rating = number;
                theLocation.Coordinates = CLLocationCoordinate2DMake(geopoint.latitude, geopoint.longitude);
                
                theLocation.Pictures = [object objectForKey:@"Photos"];
                
                PFFile *object2 = ((PFFile *)[theLocation.Pictures firstObject]);
                NSLog(@"Getting");
                [arrayOfLocations addObject:theLocation];
                
                
            }
        } else {
            NSLog(@"Error fetching");
        }
        
        NSLog(@"Fetched");
        
        [self addMarkersToMap:arrayOfLocations];
        appd.arrayOfLocations = arrayOfLocations;
    }];
}

- (void) buildMarker: (DiveLocation *) Location {
    
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = Location.Coordinates;
    marker.title = Location.Name;
    marker.snippet = @"Rating";
    
    marker.infoWindowAnchor = CGPointMake(0.41f, 0.56f);
    marker.appearAnimation = YES;
    marker.icon = [UIImage imageNamed:@"new-maker"];
    marker.map = mapView_;
    marker.userData = Location;
    
}

- (void) buildRandomMarkers: (int) Amount {
    
    arrayOfLocations = [[NSMutableArray alloc] init];
    dictionaryOfMarkerInfo = [[NSMutableDictionary alloc] init];
    arrayOfMarkers = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < Amount; i++) {
        
        long longit = (random() % 90);
        int chance = (int) random() % 2;
        if (chance == 0) {
            longit = longit * -1;
        }
        
        long latit = (random() % 90);
        chance = (int) random() % 2;
        if (chance == 0) {
            latit = latit * -1;
        }
        
        DiveLocation *dive = [[DiveLocation alloc] init];
        dive.Coordinates = CLLocationCoordinate2DMake(latit, longit);
        dive.Name = @"Dive";
        
        NSMutableArray *photos = [[NSMutableArray alloc]init];
        int numberOfPhotos = random() %4;
        
        for (int i = 0; i < numberOfPhotos; i++) {
            [photos addObject:[UIImage imageNamed:@"arrow"]];
        }
        dive.Rating = random() % 6;
        
        dive.Pictures = photos;
        dive.Creator = @"me";
        [arrayOfLocations addObject:dive];
    }
    
    for (DiveLocation *dive in arrayOfLocations) {
        
        PFObject *pfObj = [[PFObject alloc] initWithClassName:@"Dive"];
        [opQueue addOperationWithBlock:^{
            NSMutableArray *arrayOfPhotos = [[NSMutableArray alloc] init];
            
            for (UIImage *picture in dive.Pictures) {
                PFFile *fileImage = [PFFile fileWithData:UIImagePNGRepresentation(picture)];
                [fileImage save];
                [arrayOfPhotos addObject:fileImage];
                
            }
            pfObj[@"Photos"] = arrayOfPhotos;
            pfObj[@"Name"] =dive.Name;
            PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:dive.Coordinates.latitude longitude:dive.Coordinates.longitude];
            pfObj[@"Location"] = point;
            pfObj[@"Rating"] = [NSNumber numberWithFloat:dive.Rating];
            [pfObj save];

        }];
    }

}

- (BOOL) addMarkersToMap : (NSArray
                            *) arrayOfMarkers {
    NSLog(@"Adding markers");
    
    [opQueue addOperationWithBlock:^{
        
        for (DiveLocation * location in arrayOfLocations  ) {
            [mainQueue addOperationWithBlock:^{
                
                [self buildMarker:location];
                
            }];
            [NSThread sleepForTimeInterval:.05];
            NSLog(@"hit");
        }
        
        
    }];
    NSLog(@"Markers added");
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
