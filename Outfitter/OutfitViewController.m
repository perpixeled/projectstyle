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
#import "AppDelegate.h"

@interface OutfitViewController ()

@property (nonatomic, strong) NSArray *heads;
@property (nonatomic, strong) NSArray *tops;
@property (nonatomic, strong) NSArray *bottoms;
@property (nonatomic, strong) NSArray *shoes;
@property (nonatomic) int curHead;
@property (nonatomic) int curTop;
@property (nonatomic) int curBottom;
@property (nonatomic) int curShoes;
@property (nonatomic) int tappedCameraTag;
@property (nonatomic) BOOL isOverlayShowing;
@property (nonatomic) UIView *cameraOverlayView;
@property (nonatomic) UIToolbar *cameraToolbar;
@property (nonatomic) UIBarButtonItem *cancelCamera;
@property (nonatomic) UIButton *cameraClickButton;
@property (nonatomic) UIBarButtonItem *cameraClickBarButtonItem;
@property (nonatomic) UIImagePickerController *imagePickerController;
@property (nonatomic) NSMutableArray *firstToolbarArray;
@property (nonatomic) NSMutableArray *secondToolbarArray;
@property (nonatomic) UIBarButtonItem *retakeButton;
@property (nonatomic) UIBarButtonItem *doneButton;
@property (nonatomic) UIImageView *figureOverlayImageView;
@property (nonatomic) UIImageView *previewImageView;
@property (nonatomic) UIScrollView *previewScrollView;
@property (nonatomic) UIView *previewBackgroundView;
@property (nonatomic) UIImageView *previewContainerView;

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

- (IBAction)cameraClick:(id)sender {
    [_imagePickerController takePicture];
}

- (IBAction)cameraCancel:(id)sender {
    [_imagePickerController dismissViewControllerAnimated:YES completion:NULL];
}

- (IBAction)retake:(id)sender {
    [_figureOverlayImageView setHidden:NO];
    [_previewScrollView removeFromSuperview];
    [_previewBackgroundView removeFromSuperview];
    [_previewContainerView removeFromSuperview];
    
    [_cameraToolbar setItems:_firstToolbarArray animated:YES];
}

- (IBAction)done:(id)sender {
    ALAssetsLibrary *library=[[ALAssetsLibrary alloc] init];
    
    
    
    UIImage *rotatedImage = [[_previewImageView image] fixOrientation];
    
    [library writeImageToSavedPhotosAlbum:[rotatedImage CGImage]
                              orientation:ALAssetOrientationUp
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              [_imagePickerController dismissViewControllerAnimated:YES completion:NULL];
                          }];
    
    [self saveCroppedImage];
    [self hideOverlays];
}

- (IBAction)onShutterTap:(UIButton *)sender {
    _tappedCameraTag = sender.tag;
    
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
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.showsCameraControls = NO;
                
        _cameraOverlayView = [[UIView alloc] initWithFrame:[_imagePickerController.view frame]];
        _cameraToolbar = [[UIToolbar alloc] init];
        [_cameraToolbar setFrame:CGRectMake(0, _imagePickerController.view.frame.size.height - 95, 320, 95)];
        [_cameraToolbar setBackgroundImage:[UIImage imageNamed:@"cameratoolbar.png" ] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        
        _cancelCamera = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                         style:UIBarButtonItemStyleBordered target:self
                                                        action:@selector(cameraCancel:)];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];
        _cancelCamera.tintColor = [UIColor blackColor];
        
        _cameraClickButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _cameraClickButton.userInteractionEnabled = YES;
        [_cameraClickButton setFrame:CGRectMake(0, 0, 75, 77)];
        [_cameraClickButton setImage:[UIImage imageNamed:@"cameraclick.png"] forState:UIControlStateNormal];
        [_cameraClickButton addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];
        _cameraClickBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_cameraClickButton];
        
        _firstToolbarArray = [[NSMutableArray alloc] initWithObjects: _cancelCamera, spaceButton, _cameraClickBarButtonItem, spaceButton, nil];
        [_cameraToolbar setItems:_firstToolbarArray];
        
        _figureOverlayImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"figureoverlay.png"]];
        
        [_cameraOverlayView addSubview:_cameraToolbar];
        [_cameraOverlayView addSubview:_figureOverlayImageView];
        
        // creating overlayView
        UIImageView* figureOutlineView = [[UIImageView alloc] initWithFrame:_imagePickerController.view.frame];
        // letting png transparency be
        figureOutlineView.image = [UIImage imageNamed:@"figureoverlay.png"];
        [figureOutlineView.layer setOpaque:NO];
        figureOutlineView.opaque = NO;
        
        [_imagePickerController setCameraOverlayView:_cameraOverlayView];
        
        [self presentViewController:_imagePickerController animated:YES completion:NULL];
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
    
    _previewImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-0.05, -0.05, 320.05, 472.05)];
    _previewImageView.image = originalImage;
    _previewScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 472)];
    _previewScrollView.minimumZoomScale = 1.0;
    _previewScrollView.maximumZoomScale = 2.0;
    _previewScrollView.zoomScale = 2;
    _previewScrollView.delegate = self;
    _previewScrollView.bounces = YES;
    _previewScrollView.alwaysBounceHorizontal = YES;
    _previewScrollView.alwaysBounceVertical = YES;
    [_previewScrollView setShowsHorizontalScrollIndicator:NO];
    [_previewScrollView setShowsVerticalScrollIndicator:NO];
    [_previewScrollView addSubview:_previewImageView];
    _previewContainerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString
                                                                  stringWithFormat:@"cropSquare%d.png", _tappedCameraTag]]];
    _previewContainerView.userInteractionEnabled = NO;
    
    _previewBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 472)];
    _previewBackgroundView.backgroundColor = [UIColor blackColor];
    
    [_cameraOverlayView addSubview:_previewBackgroundView];
    [_cameraOverlayView addSubview:_previewScrollView];
    [_cameraOverlayView addSubview:_previewContainerView];
    
    [_figureOverlayImageView setHidden:YES];
    
//    UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"legs_crop.png"]];
//    _cameraOverlayView.backgroundColor = background;
    
    if (_secondToolbarArray == nil) {
        _retakeButton = [[UIBarButtonItem alloc] initWithTitle:@"Retake"
                                                         style:UIBarButtonItemStyleBordered target:self
                                                        action:@selector(retake:)];
        _retakeButton.tintColor = [UIColor blackColor];
        
        UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                     target:nil
                                                                                     action:nil];
        
        _doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                       style:UIBarButtonItemStyleBordered target:self
                                                      action:@selector(done:)];
        _doneButton.tintColor = [UIColor blackColor];
        
        
        _secondToolbarArray = [[NSMutableArray alloc] initWithObjects:_retakeButton, spaceButton, _doneButton, nil];
    }
    
    [_cameraToolbar setItems:_secondToolbarArray animated:YES];
    
//    NSLog(@"x = %f, y = %f, height = %f, width = %f",
//          _previewImageView.frame.origin.x,
//          _previewImageView.frame.origin.y,
//          _previewImageView.frame.size.height,
//          _previewImageView.frame.size.width
//          );
    
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
    }
    
//    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _previewImageView;
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    [scrollView setContentOffset:scrollView.contentOffset animated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated  {
    NSLog(@"%@", [[navigationController.viewControllers objectAtIndex:0] description]);
}

-(void)saveCroppedImage {
    CGRect grabRect = CGRectMake(10,191,300,188);
    
    //for retina displays
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        UIGraphicsBeginImageContextWithOptions(grabRect.size, NO, [UIScreen mainScreen].scale);
    } else {
        UIGraphicsBeginImageContext(grabRect.size);
    }
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(ctx, -grabRect.origin.x, -grabRect.origin.y);
    [[(AppDelegate *)[[UIApplication sharedApplication] delegate] window].layer renderInContext:ctx];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_bottomView setImage:viewImage];
    
//    CGRect visibleRect;
//    float scale = 1.0f/_previewScrollView.zoomScale;
//    visibleRect.origin.x = _previewScrollView.contentOffset.x * scale;
//    visibleRect.origin.y = _previewScrollView.contentOffset.y * scale;
//    visibleRect.size.width = _previewScrollView.bounds.size.width * scale;
//    visibleRect.size.height = _previewScrollView.bounds.size.height * scale;
//    
//    CGImageRef cr = CGImageCreateWithImageInRect([_previewImageView image].CGImage, visibleRect);
//    UIImage* cropped = [UIImage imageWithCGImage:cr];
//    [_bottomView setImage:cropped];
//    
//    CGImageRelease(cr);
    
//    -----
    
//    UIGraphicsBeginImageContext(_previewScrollView.bounds.size);
//    
//    [_previewScrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    
//    UIGraphicsEndImageContext();
//    
//    CGRect rect = CGRectMake(0,190,302,190);
//    CGImageRef imageRef = CGImageCreateWithImageInRect([viewImage CGImage], rect);
//    
//    UIImage *img = [UIImage imageWithCGImage:imageRef];
//    
//    [_bottomView setImage:img];
//    
//    CGImageRelease(imageRef);
}

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
