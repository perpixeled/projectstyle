//
//  ClosetViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "ClosetViewController.h"

@interface ClosetViewController ()

@end

@implementation ClosetViewController

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
    NSString *fullUrl = @"http://melissafeudi.com/drobeapp/closet.html";
    //	NSString *fullUrl = @"http://stylestalker.herokuapp.com/closets";
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
