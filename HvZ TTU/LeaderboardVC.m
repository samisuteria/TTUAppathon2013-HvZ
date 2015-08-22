//
//  LeaderboardVC.m
//  HvZ TTU
//
//  Created by Sami Suteria on 2/23/13.
//  Copyright (c) 2013 Limerick Design. All rights reserved.
//

#import "LeaderboardVC.h"

@interface LeaderboardVC (){
    UIScrollView* currentScrollView;
}

@end

@implementation LeaderboardVC
@synthesize backButton;
@synthesize webview;

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
    
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-normal"] forState:UIControlStateNormal];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back-highlight"] forState:UIControlStateHighlighted];

    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ttu.samisuteria.com/hvz/iOS/leaderboard.html"]]];
    [webview setDelegate:self];
    webview.tag = 999;
    
    for (UIView* subView in webview.subviews) {
        if ([subView isKindOfClass:[UIScrollView class]]) {
            currentScrollView = (UIScrollView *)subView;
            currentScrollView.delegate = (id) self;
        }
    }
    
    PullToRefreshView *pull = [[PullToRefreshView alloc] initWithScrollView:currentScrollView];
    [pull setDelegate:self];
    pull.tag = 998;
    [currentScrollView addSubview:pull];
    [self.view addSubview:webview];
    
    
    
    
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

-(IBAction)back{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
