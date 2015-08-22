//
//  CallForHelpVC.h
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CallForHelpVC : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *callButton;
@property (nonatomic, retain) CLLocationManager *locationManager;

@end
