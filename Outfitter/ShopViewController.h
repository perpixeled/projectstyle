//
//  ShopViewController.h
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopViewController : UIViewController

@property (nonatomic, assign) id delegate;
- (IBAction)backButtonTap:(UIBarButtonItem *)sender;
- (IBAction)gilt0DoubleTap:(id)sender;
- (IBAction)gilt0SingleTap:(id)sender;
- (IBAction)gilt0SwipeUp:(id)sender;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
