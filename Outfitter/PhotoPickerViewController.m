//
//  PhotoPickerViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/10/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "PhotoPickerViewController.h"

@interface PhotoPickerViewController ()

@end

@implementation PhotoPickerViewController

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
	UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
