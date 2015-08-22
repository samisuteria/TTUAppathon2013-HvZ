//
//  MissionsVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/22/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "MissionsVC.h"

@interface MissionsVC (){
    UIScrollView *currentScrollView;
}

@end

@implementation MissionsVC
@synthesize webView;

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
        self.tabBarItem.image = [UIImage imageNamed:@"Missions"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    
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
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ttu.samisuteria.com/hvz/iOS/missions_screen.html"]]];
    
    
    
    
}

-(void)pullToRefreshViewShouldRefresh:(PullToRefreshView *)view {
    [(UIWebView *)[self.view viewWithTag:999] reload];
}

- (void)webViewDidFinishLoad:(UIWebView *)wv
{
    [(PullToRefreshView *)[self.view viewWithTag:998] finishedLoading];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
