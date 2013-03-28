//
//  FirstViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import "OutfitViewController.h"
#import "ShopViewController.h"

@interface OutfitViewController ()

@property (nonatomic, strong) NSArray *heads;
@property (nonatomic, strong) NSArray *tops;
@property (nonatomic, strong) NSArray *bottoms;
@property (nonatomic, strong) NSArray *shoes;
@property (nonatomic) int curHead;
@property (nonatomic) int curTop;
@property (nonatomic) int curBottom;
@property (nonatomic) int curShoes;
@property (nonatomic) BOOL isOverlayShowing;

@end

@implementation OutfitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _heads = @[@"head1.png", @"head2.png", @"head3.png", @"head4.png"];
    _tops = @[ @"torso3.png", @"torso1.png", @"torso2.png", @"touro5.jpg"];
    _bottoms = @[@"bottom2.png", @"bottom4.png", @"bottom5.png",@"bottom.png", @"bottom6.png"];
    _shoes = @[@"shoes2.png", @"shoes3.png", @"shoe4.png", @"shoes5.png"];
    _curHead = 0;
    _curTop = 0;
    _curBottom = 0;
    _curShoes = 0;
    
    _headOverlay.hidden = YES;
    _topOverlay.hidden = YES;
    _bottomOverlay.hidden = YES;
    _shoesOverlay.hidden = YES;
    _isOverlayShowing = NO;
    
    UIImage *topImage = [UIImage imageNamed:_heads[_curHead]];
    [_topView initWithImage:topImage];
    
    UIImage *middleImage = [UIImage imageNamed:_tops[_curTop]];
    [_middleView initWithImage:middleImage];
    
    UIImage *bottomImage = [UIImage imageNamed:_bottoms[_curBottom]];
    [_bottomView initWithImage:bottomImage];
    
    UIImage *shoes = [UIImage imageNamed:_shoes[_curShoes]];
    [_shoesView initWithImage:shoes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShutterTap:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:imagePickerController animated:YES completion:nil];
    imagePickerController.showsCameraControls = YES;
}

- (IBAction)headRightSwipeRecognizer:(UISwipeGestureRecognizer *)recognizer {
    _curHead= ++_curHead % [_heads count];
    [self displayImageFromArray:_heads withIndex:_curHead forImageView:_topView];
}

- (IBAction)headLeftSwipeRecognizer:(UISwipeGestureRecognizer *)sender {
    _curHead = --_curHead;
    if( _curHead < 0 ) {
        _curHead = [_heads count]-1;
    }
    [self displayImageFromArray:_heads withIndex:_curHead forImageView:_topView];
}

- (void)displayImageFromArray:(NSArray *)imageArray withIndex:(NSInteger)anIndex forImageView:(UIImageView *)anImageView {
    UIImage *newImage = [UIImage imageNamed:imageArray[anIndex]];
    [anImageView initWithImage:newImage];
}
- (IBAction)headDoubleTapRecognizer:(UITapGestureRecognizer *)sender {
    if( _isOverlayShowing ) {
        [self hideOverlays];
    } else {
        _headOverlay.hidden = NO;
        [_headContainer bringSubviewToFront:_headOverlay];
        _isOverlayShowing = YES;
    }
}

- (IBAction)onHeadShutterClick:(id)sender {
    
}

- (IBAction)topDoubleTapRecognizer:(id)sender {
    if( _isOverlayShowing ) {
        [self hideOverlays];
    } else {
        _topOverlay.hidden = NO;
        [_topContainer bringSubviewToFront:_topOverlay];
        _isOverlayShowing = YES;
    }
}

- (IBAction)bottomDoubleTapRecognizer:(UITapGestureRecognizer *)sender {
    if( _isOverlayShowing ) {
        [self hideOverlays];
    } else {
        _bottomOverlay.hidden = NO;
        [_bottomContainer bringSubviewToFront:_bottomOverlay];
        _isOverlayShowing = YES;
    }
}

- (IBAction)shoesDoubleTap:(UITapGestureRecognizer *)sender {
    if( _isOverlayShowing ) {
        [self hideOverlays];
    } else {
        _shoesOverlay.hidden = NO;
        [_shoesContainer bringSubviewToFront:_shoesOverlay];
        _isOverlayShowing = YES;
    }
}

- (IBAction)topShopTap:(id)sender {
    [self hideOverlays];
//    // Create the root view controller for the navigation controller
//    // The new view controller configures a Cancel and Done button for the
//    // navigation bar.
//    ShopViewController *addController = [[ShopViewController alloc] init];
//    
//    // Configure the RecipeAddViewController. In this case, it reports any
//    // changes to a custom delegate object.
//    addController.delegate = self;
//    
//    // Create the navigation controller and present it.
//    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
//    [self presentViewController:navigationController animated:YES completion: nil];
}

- (IBAction)topInspirationTap:(id)sender {
    [self hideOverlays];
}

- (IBAction)topRightSwipe:(UISwipeGestureRecognizer *)sender {
    _curTop= ++_curTop % [_tops count];
    [self displayImageFromArray:_tops withIndex:_curTop forImageView:_middleView];
}

- (IBAction)topLeftSwipe:(UISwipeGestureRecognizer *)sender {
    _curTop = --_curTop;
    if( _curTop < 0 ) {
        _curTop = [_tops count]-1;
    }
    [self displayImageFromArray:_tops withIndex:_curTop forImageView:_middleView];
}

- (IBAction)bottomRightSwipe:(id)sender {
    _curBottom= ++_curBottom % [_bottoms count];
    [self displayImageFromArray:_bottoms withIndex:_curBottom forImageView:_bottomView];
}

- (IBAction)bottomLeftSwipe:(UISwipeGestureRecognizer *)sender {
    _curBottom = --_curBottom;
    if( _curBottom < 0 ) {
        _curBottom = [_bottoms count]-1;
    }
    [self displayImageFromArray:_bottoms withIndex:_curBottom forImageView:_bottomView];
}

- (IBAction)shoeRightSwipe:(UISwipeGestureRecognizer *)sender {
    _curShoes= ++_curShoes % [_shoes count];
    [self displayImageFromArray:_shoes withIndex:_curShoes forImageView:_shoesView];
}

- (IBAction)shoeLeftSwipe:(UISwipeGestureRecognizer *)sender {
    _curShoes = --_curShoes;
    if( _curShoes < 0 ) {
        _curShoes = [_shoes count]-1;
    }
    [self displayImageFromArray:_shoes withIndex:_curShoes forImageView:_shoesView];
}

- (void)hideOverlays {
    _headOverlay.hidden = YES;
    _topOverlay.hidden = YES;
    _bottomOverlay.hidden = YES;
    _shoesOverlay.hidden = YES;
    _isOverlayShowing = NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showGilt"]) {
        ShopViewController *destViewController = segue.destinationViewController;
        destViewController.delegate = self;
    }
}

- (void)onGiltClick:(NSInteger)index {
    UIImage *newImage = [UIImage imageNamed:@"shop_gilt_select.jpg"];
    _middleView.contentMode = UIViewContentModeScaleAspectFit;
    [_middleView initWithImage:newImage];
}
@end
