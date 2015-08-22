//
//  AlliesMapVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AlliesMapVC : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *mapOverlay;

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@end
