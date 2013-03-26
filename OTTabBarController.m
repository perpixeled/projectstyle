//
//  OTTabBarController.m
//  Outfitter
//
//  Created by Les Pozdena on 2/26/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "OTTabBarController.h"

@interface OTTabBarController ()

@end

@implementation OTTabBarController

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
    
    float topInset = 5.0f;
    
    NSEnumerator *e = [self.tabBar.items objectEnumerator];
    id object;
    while (object = [e nextObject]) {
        [object setImageInsets:UIEdgeInsetsMake(topInset, 0.0f, -topInset, 0.0f)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
