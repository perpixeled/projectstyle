//
//  HearstViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/10/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "HearstViewController.h"

@interface HearstViewController ()

@end

@implementation HearstViewController

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
	// Do any additional setup after loading the view.
    
    NSString *fullUrl = @"http://hearst.api.mashery.com/ArticleImage/search?_pretty=0&shape=full&caption=sweater&start=0&limit=6&sort=name%2Casc&total=0&api_key=nvnwhsk3pcamdu2hprsf3uws";
    
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    //NSURLConnection *urlConnection = [[NSURLConnection alloc] init];
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        [self handleJsonData:data];
        
    }];
}

- (void)handleJsonData:(NSData *)data {
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:nil error:nil];
//    NSArray *items = [json objectForKey:@"items"];
//    NSLog(@"urls :%@", items);
    [self initWebView:_webView0 withUrl:@"http://www.marieclaire.com/cm/marieclaire/images/fb/reese-witherspoon-covershoot-1011-10-xl7.jpg"];
    [self initWebView:_webView1 withUrl:@"http://www.elle.com/cm/elle/images/BQ/001-awang-lag-lg.jpg"];
    //http://www.ssense.com/women/product/alexander_wang/marled_slit_sleeve_pullover/25530
    [self initWebView:_webView2 withUrl:@"http://www.marieclaire.com/cm/marieclaire/images/Dl/cast-away-style-1211-18-xl.jpg"];
    [self initWebView:_webView3 withUrl:@"http://www.marieclaire.com/cm/marieclaire/images/4R/isabel-lucas-1111-13-xl.jpg"];
    [self initWebView:_webView4 withUrl:@"http://www.marieclaire.com/cm/marieclaire/images/qQ/pre-fall-review-0611-18-xl.jpg"];
    [self initWebView:_webView5 withUrl:@"http://www.marieclaire.com/cm/marieclaire/images/oK/shop-the-shoot-color-theory-7-xl.jpg"];
    
}
     
- (void)initWebView:(UIWebView *)aWebView withUrl:(NSString *)aUrl {
    NSURL *url = [NSURL URLWithString:aUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [aWebView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// THIS DOESN'T WORK!
- (IBAction)webView2DoubleTap:(id)sender {
    [self showMainView];
}

- (IBAction)webView2Swipe:(id)sender {
    [self showMainView];
}

- (void)showMainView {
    NSString *fullUrl = @"http://www.ssense.com/women/product/alexander_wang/marled_slit_sleeve_pullover/25530";
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_mainWebView loadRequest:urlRequest];
    _mainWebView.hidden = NO;
}
@end
