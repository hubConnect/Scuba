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

@interface FirstViewController ()

@end

@implementation FirstViewController
{
    
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.86
                                                            longitude:151.20
                                                                 zoom:6];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.map = mapView_;
    
    NSLog(@"starting");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
