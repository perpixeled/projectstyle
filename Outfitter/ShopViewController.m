//
//  ShopViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "ShopViewController.h"
#import "OutfitViewController.h"

@interface ShopViewController ()

@end

@implementation ShopViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTap:(UIBarButtonItem *)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)gilt0DoubleTap:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    OutfitViewController *outfitViewController = (OutfitViewController *)self.delegate;
    [outfitViewController onGiltClick:1];
}

- (IBAction)gilt0SingleTap:(id)sender {
//    NSString *fullUrl = @"http://www.gilt.com/sale/women/the-easy-sweater/product/152112580-sea-bleu-penelope-reverse-seam-linen-crewneck";
//    NSURL *url = [NSURL URLWithString:fullUrl];
//    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
//    [_webView loadRequest:urlRequest];
//    
//    _webView.hidden = NO;
}

- (IBAction)gilt0SwipeUp:(id)sender {
    NSString *fullUrl = @"http://www.gilt.com/sale/women/the-easy-sweater/product/152112580-sea-bleu-penelope-reverse-seam-linen-crewneck";
    NSURL *url = [NSURL URLWithString:fullUrl];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:urlRequest];
    
    _webView.hidden = NO;
}

@end
