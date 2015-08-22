//
//  EnemyRadarVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "EnemyRadarVC.h"
#import <Parse/Parse.h>
#import "GeoPointAnnotation.h"

@interface EnemyRadarVC ()

@end

@implementation EnemyRadarVC
@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;
@synthesize imageOverlay;
@synthesize backButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    PFGeoPoint *myLocation = [PFGeoPoint geoPointWithLatitude:33.58777390315338 longitude:-101.876086046607];
    [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(myLocation.latitude, myLocation.longitude), MKCoordinateSpanMake(0.01, 0.01))];
    
    self.mapView.mapType = MKMapTypeHybrid;
    
    [[self locationManager] startUpdatingLocation];
    
    CLLocation *location = _locationManager.location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    
    [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    if(geoPoint.latitude != 0.0){
        [self.mapView setRegion:MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.0025, 0.0025))];
    }
    
    NSString *userStatus = [[PFUser currentUser] objectForKey:@"status"];
    
    if([userStatus isEqualToString:@"Zombie"]){
        
        PFQuery *humanQuery = [PFUser query];
        [humanQuery whereKey:@"status" equalTo:@"Human"];
        [humanQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                for(PFObject *object in objects){
                    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:object];
                    [self.mapView addAnnotation:annotation];
                }
            }
        }];
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (screenSize.height > 480.0f) {
            imageOverlay.image = [UIImage imageNamed:@"zombieoverlay5"];
        } else {
            imageOverlay.image = [UIImage imageNamed:@"zombieoverlay"];
        }
        
    } else {
        PFQuery *zombieQuery = [PFUser query];
        [zombieQuery whereKey:@"status" equalTo:@"Zombie"];
        [zombieQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if(!error){
                for(PFObject *object in objects){
                    GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:object];
                    [self.mapView addAnnotation:annotation];
                }
            }
        }];
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (screenSize.height > 480.0f) {
            imageOverlay.image = [UIImage imageNamed:@"uavoverlay5"];
        } else {
            imageOverlay.image = [UIImage imageNamed:@"uavoverlay"];
        }
    }
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}
/*
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.animatesDrop = YES;
    }
    
    return annotationView;
}
*/
- (CLLocationManager *)locationManager {
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    
    return _locationManager;
}

@end
