//
//  SecondViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "RunwayViewController.h"

@interface RunwayViewController ()

@end

@implementation RunwayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *fullUrl = @"http://melissafeudi.com/drobeapp/runway.html";
    //	NSString *fullUrl = @"http://stylestalker.herokuapp.com/runways";
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
