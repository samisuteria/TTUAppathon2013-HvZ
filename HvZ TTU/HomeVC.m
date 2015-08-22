//
//  HomeVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/17/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "HomeVC.h"
#import <Parse/Parse.h>

@interface HomeVC (){
    UIScrollView* currentScrollView;
}

@end

@implementation HomeVC
@synthesize scoreLabel;
@synthesize humanScoreLabel;
@synthesize zombieScoreLabel;
@synthesize webView;
@synthesize locationManager = _locationManager;
@synthesize topImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        self.tabBarItem.image = [UIImage imageNamed:@"Home"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //[self.tabBarController.tabBar.items objectAtIndex:0].image = [[UIImage imageNamed:@"Home"]];
    //[self.tabBarItem
    
    topImage.image = [UIImage imageNamed:@"logo"];
    
    
    
    humanScoreLabel.text = @"Humans:0";
    zombieScoreLabel.text = @"Zombies:0";
    
    PFQuery *humanQuery = [PFUser query];
    [humanQuery whereKey:@"status" equalTo:@"Human"];
    [humanQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            humanScoreLabel.text = [NSString stringWithFormat:@"Humans:%i",objects.count];
        }
    }];
    PFQuery *zombieQuery = [PFUser query];
    [zombieQuery whereKey:@"status" equalTo:@"Zombie"];
    [zombieQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            zombieScoreLabel.text = [NSString stringWithFormat:@"Zombies:%i",objects.count];
        }
    }];
    
    //webView.scrollView.bounces = NO;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ttu.samisuteria.com/hvz/iOS/home_screen.html"]]];
    
    
    
    //[self.newsWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"test" ofType:@"html" inDirectory:@""] isDirectory:NO]]];
    
    [[self locationManager] startUpdatingLocation];
    
    CLLocation *location = _locationManager.location;
    CLLocationCoordinate2D coordinate = [location coordinate];
    PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                  longitude:coordinate.longitude];
    
    [[PFUser currentUser] setObject:geoPoint forKey:@"location"];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        
    }];
    
    
    [webView setDelegate:self];
    webView.tag = 999;
    
    for (UIView* subView in webView.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            currentScrollView = (UIScrollView *)subView;
            currentScrollView.delegate = (id) self;
        }
    }
    
    PullToRefreshView *pull = [[PullToRefreshView alloc] initWithScrollView:currentScrollView];
    [pull setDelegate:self];
    pull.tag = 998;
    [currentScrollView addSubview:pull];
    [self.view addSubview:webView];
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)wv
{
    [(PullToRefreshView *)[self.view viewWithTag:998] finishedLoading];
}

-(void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view {
    [(UIWebView *)[self.view viewWithTag:999] reload];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
