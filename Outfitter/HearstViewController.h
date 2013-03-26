//
//  HearstViewController.h
//  Outfitter
//
//  Created by Robby Abaya on 2/10/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HearstViewController : UIViewController

- (IBAction)backTap:(id)sender;
- (IBAction)webView2DoubleTap:(id)sender;
- (IBAction)webView2Swipe:(id)sender;
@property (weak, nonatomic) IBOutlet UIWebView *webView0;
@property (weak, nonatomic) IBOutlet UIWebView *webView1;
@property (weak, nonatomic) IBOutlet UIWebView *webView2;
@property (weak, nonatomic) IBOutlet UIWebView *webView3;
@property (weak, nonatomic) IBOutlet UIWebView *webView4;
@property (weak, nonatomic) IBOutlet UIWebView *webView5;
@property (weak, nonatomic) IBOutlet UIWebView *mainWebView;
@end
