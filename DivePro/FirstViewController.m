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
#import <ParseFacebookUtils/PFFacebookUtils.h>
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
    UIBarButtonItem *showButton;
}

    bool firstLoad = YES;
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

- (void) viewWillAppear:(BOOL)animated {
    
    [self setButton];
}

-(void)viewDidAppear:(BOOL)animated
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc] init];
    
    button.title = @"List";
    
    
    NSLog(@"Button items added");
    
    
}

- (void) setButton {
    
    
    showButton = [[UIBarButtonItem alloc] initWithTitle:@"Show" style:UIBarButtonItemStylePlain target:self action:@selector(addMarkersToMap)];
    showButton.title = @"Refresh";
    
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    appD.mainNav.topViewController.navigationItem.rightBarButtonItem = showButton;
    
}


-(void) addMarkersToMap {
    
    [mapView_ clear];
    [self addMarkersToMap:arrayOfLocations inGroupsOf:4];
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
        fullStar:[UIImage imageNamed:@"full_flag.png"] emptyStar:[UIImage imageNamed:@"empty_flag.png"]];
    [rateView setRate:dive.Rating];
    
    view.RatingRect = rateView;
    [view addSubview:rateView];
    
    NSLog(@"%@", string);

    return view;
}

-(void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    NSLog(@"Hit info window");
    AppDelegate *appD = [UIApplication sharedApplication].delegate;
    appD.DiveToShow = (DiveLocation *) marker.userData;
    [self.tabBarController performSegueWithIdentifier:@"PushDetail" sender:self];
    
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


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    if (firstLoad) {
        
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:newLocation.coordinate.latitude
                                                                longitude:newLocation.coordinate.longitude
                                                                     zoom:12];
        [mapView_ animateToCameraPosition:camera];
        firstLoad = NO;
        [locationManager stopUpdatingLocation];
    }
    NSLog(@"LocationUpdated");
    //...
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
    
    mapView_.mapType = kGMSTypeSatellite;
    
    mapView_.camera = [GMSCameraPosition cameraWithLatitude:mapView_.myLocation.coordinate.latitude longitude:mapView_.myLocation.coordinate.longitude zoom:1];

    mapView_.delegate = self;

        
        
        locationManager = [[CLLocationManager alloc] init];
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        locationManager.delegate = self;
        
        
        [locationManager requestWhenInUseAuthorization];
        [locationManager startUpdatingLocation];
        NSLog(@"%lf lat",locationManager.location.coordinate.latitude);
        
        mapView_.myLocationEnabled = YES;
        // Creating test markers.
        
    
    
    //[self downloadLocations:1000];
    [self buildRandomMarkers:100];
    
    
    mapView_.settings.myLocationButton = YES;
    
    
    
    NSLog(@"starting");
}

- (void) downloadLocations:(double) miles {
    arrayOfLocations = [[NSMutableArray alloc]init];
    
    AppDelegate *appd = [UIApplication sharedApplication].delegate;

    
    PFGeoPoint *myPoint = [[PFGeoPoint alloc] init];
    myPoint.longitude = locationManager.location.coordinate.longitude;
    myPoint.latitude = locationManager.location.coordinate.latitude;
    
    PFQuery *query = [PFQuery queryWithClassName:@"Dive"];
    [query whereKey:@"Location" nearGeoPoint:myPoint withinMiles:miles];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSLog(@"Fetching");
        if (!error) {
            NSLog(@"count %i",objects.count);
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
        
        long longit = (random() % 180);
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
    AppDelegate * appD = [UIApplication sharedApplication].delegate;
    appD.arrayOfLocations = [arrayOfLocations copy];
    NSLog(@"%d items created for array",appD.arrayOfLocations.count);

}

- (BOOL) addMarkersToMap : (NSArray
                            *) arrayOfMarkers inGroupsOf: (int) amount {
    
    NSLog(@"Adding markers");
    
    __block NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    
    [opQueue addOperationWithBlock:^{
        
        NSLog(@"%d items in array",tempArray.count);
        for (DiveLocation * location in arrayOfLocations  ) {
            
                
                [tempArray addObject:location];
                
                if ((tempArray.count % amount == 0)) {
                    NSArray *secondTemp = [tempArray copy];
                    
                    [mainQueue addOperationWithBlock:^{
                        for (DiveLocation *dive in secondTemp) {
                            [self buildMarker:dive];
                            NSLog(@"Adding a marker!");
                        }
                    }];

                    
                    [tempArray removeAllObjects];
                }
            
                [NSThread sleepForTimeInterval:.05];
            }
        
        
        if (tempArray.count != 0) {
            for (DiveLocation *dive in tempArray) {
                [mainQueue addOperationWithBlock:^{
                    [self buildMarker:dive];
                }];
            }
        }
    }];
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
