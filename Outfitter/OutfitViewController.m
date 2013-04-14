//
//  FirstViewController.m
//  Outfitter
//
//  Created by Robby Abaya on 2/9/13.
//  Copyright (c) 2013 Robby Abaya. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "OutfitViewController.h"
#import "ShopViewController.h"
#import "UIImage+fixOrientation.h"

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
    [_topView setImage:topImage];
    
    UIImage *middleImage = [UIImage imageNamed:_tops[_curTop]];
    [_middleView setImage:middleImage];
    
    UIImage *bottomImage = [UIImage imageNamed:_bottoms[_curBottom]];
    [_bottomView setImage:bottomImage];
    
    UIImage *shoes = [UIImage imageNamed:_shoes[_curShoes]];
    [_shoesView setImage:shoes];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShutterTap:(id)sender {
    UIActionSheet *cameraQuery = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:@"Photo Album", @"Camera", nil];
    cameraQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [cameraQuery showInView:[self.view window]];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *choice = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if ([choice isEqualToString:@"Photo Album"]) {
        [self startMediaBrowserFromViewController: self usingDelegate: self];
    }
    
    if ([choice isEqualToString:@"Camera"]) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.showsCameraControls = YES;
        
//        UIView *cameraOverlayView = (UIView *)[[[NSBundle mainBundle] loadNibNamed:@"CameraOverlayView" owner:nil options:nil] lastObject];
        
        // creating overlayView
        UIImageView* figureOutlineView = [[UIImageView alloc] initWithFrame:imagePickerController.view.frame];
        // letting png transparency be
        figureOutlineView.image = [UIImage imageNamed:@"figureoverlay.png"];
//        figureOutlineView.image = [UIColor colorWithPatternImage:[UIImage imageNamed:@"figureoverlay.png"]];
        [figureOutlineView.layer setOpaque:NO];
        figureOutlineView.opaque = NO;
        
        imagePickerController.cameraOverlayView = figureOutlineView;
        
        NSLog(@"x = %f, y = %f, height = %f, width = %f",
              imagePickerController.cameraOverlayView.frame.origin.x,
              imagePickerController.cameraOverlayView.frame.origin.y,
              imagePickerController.cameraOverlayView.frame.size.height,
              imagePickerController.cameraOverlayView.frame.size.width
              );
        
        [self presentViewController:imagePickerController animated:YES completion:NULL];
    }
}

- (BOOL)startMediaBrowserFromViewController: (UIViewController*) controller
							   usingDelegate: (id <UIImagePickerControllerDelegate,
											   UINavigationControllerDelegate>) delegate {
    
    if (([UIImagePickerController isSourceTypeAvailable:
		  UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
		|| (delegate == nil)
		|| (controller == nil))
        return NO;
    
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    // Displays saved pictures from photo library
    mediaUI.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    mediaUI.allowsEditing = YES;
    
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:YES completion:NULL];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    UIImage *originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImage *editedImage, *imageToUse;
    
    // start handling a photo that was just taken
    
    ALAssetsLibrary *library=[[ALAssetsLibrary alloc] init];
    
    UIImage *rotatedImage = [originalImage fixOrientation];
    
//    UIImage *rotatedImage = [[UIImage alloc] initWithCGImage: originalImage.CGImage
//                                                         scale: 1.0
//                                                   orientation: UIImageOrientationRight];
    
//    switch ((ALAssetOrientation)[originalImage imageOrientation]) {
//        case UIDeviceOrientationPortrait:
//        default:
//            newOrientation = ALAssetOrientationRight; //3 instead ofALAssetOrientationUp;
//            break;
//        case UIDeviceOrientationPortraitUpsideDown:
//            newOrientation = ALAssetOrientationLeft; //2 insted of ALAssetOrientationDown;
//            break;
//        case UIDeviceOrientationLandscapeLeft:
//            newOrientation = ALAssetOrientationUp; //0 instead of ALAssetOrientationLeft;
//            break;
//        case UIDeviceOrientationLandscapeRight:
//            newOrientation = ALAssetOrientationDown; //1 instead of ALAssetOrientationRight;
//            break;
//    }
    
    [library writeImageToSavedPhotosAlbum:[rotatedImage CGImage]
                              orientation:ALAssetOrientationUp
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              NSLog(@"completion block");
                          }];
    
    // end handling a photo that was just taken
    
    // Handle a still image picked from a photo album
    // can probably determine whether an image was just taken or not by counting how recent it is based on tiff data
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        editedImage = (UIImage *) [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (editedImage) {
            imageToUse = editedImage;
        } else {
            imageToUse = originalImage;
        }
        
        // Do something with imageToUse
            NSLog(@"got here 2013");
    }
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated  {
    NSLog(@"%@", [[navigationController.viewControllers objectAtIndex:0] description]);
}

//+ (UIImage*)unrotateImage:(UIImage*)image {
//    CGSize size = image.size;
//    UIGraphicsBeginImageContext(size);
//    [image drawInRect:CGRectMake(0,0,size.width ,size.height)];
//    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newImage;
//}


// stole this method from CropDemo by John Nichols
- (UIImage *)imageByCropping:(UIImage *)image toRect:(CGRect)rect
{
    if (UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(rect.size,
                                               /* opaque */ NO,
                                               /* scaling factor */ 0.0);
    } else {
        UIGraphicsBeginImageContext(rect.size);
    }
    
    // stick to methods on UIImage so that orientation etc. are automatically
    // dealt with for us
    [image drawAtPoint:CGPointMake(-rect.origin.x, -rect.origin.y)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
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
    [anImageView setImage:newImage];
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
    [_middleView setImage:newImage];
}
@end
