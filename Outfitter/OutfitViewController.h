//
//  FirstViewController.h
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface OutfitViewController : UIViewController <UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (IBAction)onShutterTap:(id)sender;
- (IBAction)headRightSwipeRecognizer:(UISwipeGestureRecognizer *)sender;
- (IBAction)headLeftSwipeRecognizer:(UISwipeGestureRecognizer *)sender;
- (IBAction)headDoubleTapRecognizer:(UITapGestureRecognizer *)sender;
- (IBAction)onHeadShutterClick:(id)sender;
- (IBAction)topDoubleTapRecognizer:(id)sender;
- (IBAction)bottomDoubleTapRecognizer:(UITapGestureRecognizer *)sender;
- (IBAction)shoesDoubleTap:(UITapGestureRecognizer *)sender;
- (IBAction)topShopTap:(id)sender;
- (IBAction)topInspirationTap:(id)sender;
- (IBAction)topRightSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)topLeftSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)bottomRightSwipe:(id)sender;
- (IBAction)bottomLeftSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)shoeRightSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)shoeLeftSwipe:(UISwipeGestureRecognizer *)sender;
- (IBAction)cameraClick:(id)sender;
- (IBAction)cameraCancel:(id)sender;
- (IBAction)retake:(id)sender;
- (IBAction)done:(id)sender;
- (void)onGiltClick:(NSInteger)index;
@property (weak, nonatomic) IBOutlet UIImageView *topView;
@property (weak, nonatomic) IBOutlet UIImageView *middleView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomView;
@property (weak, nonatomic) IBOutlet UIImageView *shoesView;
@property (weak, nonatomic) IBOutlet UIView *headOverlay;
@property (weak, nonatomic) IBOutlet UIView *headContainer;
@property (weak, nonatomic) IBOutlet UIView *topContainer;
@property (weak, nonatomic) IBOutlet UIView *topOverlay;
@property (weak, nonatomic) IBOutlet UIView *bottomContainer;
@property (weak, nonatomic) IBOutlet UIView *bottomOverlay;
@property (weak, nonatomic) IBOutlet UIView *shoesOverlay;
@property (weak, nonatomic) IBOutlet UIView *shoesContainer;
//@property (weak, nonatomic) IBOutlet UIImageView *figureOverlay;
//@property (weak, nonatomic) IBOutlet UIToolbar *cameraToolbar;
@end
