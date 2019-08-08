//
//  MakeZombieViewController.m
//  Zombie Photo Maker Booth
//
//  Created by Muhammad Luqman on 3/28/16.
//  Copyright © 2016 Muhammad Luqman. All rights reserved.
//

#import "MakeZombieViewController.h"
#import "myCollectionViewCell.h"
#import "ViewController.h"

@interface MakeZombieViewController (){

    NSInteger  indexOfRow;
    int CurrentX,CurrentY;
    CGFloat ImageMaxScal;
    CGFloat ImageMixScal;
    CGFloat ImageCurrentScal;
    UIImageView  *myIamges;
    int interstitialCounter;
}
@end

@implementation MakeZombieViewController

- (void)viewDidLoad {
    
    ImageCurrentScal = 1.0;
    ImageMaxScal = 2.0;
    ImageMixScal = 0.5;

    
    [super viewDidLoad];
    self.viewForCollectionView.hidden = YES;
    [self.imageZombie setImage:self.setImages];
    [self LaodArrayInGalleryIamges];
    
    [self bannerViewLoad];
    [UnityAds initialize: UnityID delegate:self];
   [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadBanner) userInfo:nil repeats:YES];
    
}

-(void)LaodArrayInGalleryIamges{
    
    _arrayForGalleryIamges = [NSMutableArray arrayWithObjects:@"sticker_1.png",@"sticker_2.png",@"sticker_3.png",@"sticker_4.png",@"sticker_5.png",@"sticker_6.png",@"sticker_7.png",@"sticker_8.png",@"sticker_9.png",@"sticker_10.png",@"sticker_11.png",@"sticker_12.png",@"sticker_13.png",@"sticker_14.png",@"sticker_15.png",@"sticker_16.png",@"sticker_17.png",@"sticker_18.png",@"sticker_19.png",@"sticker_20.png",@"sticker_21.png",@"sticker_22.png",@"sticker_23.png",@"sticker_24.png",@"sticker_25.png",@"sticker_26.png",@"sticker_27.png",@"sticker_28.png",@"sticker_26.png",@"sticker_30.png",nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)btnGallery:(id)sender {
    self.viewForCollectionView.hidden = NO;

}

- (IBAction)btnDelete:(id)sender {
    
    [self interstitialLoadCounter];
    
    self.dragObject.frame = CGRectMake(0, 0, 0, 0);
    
//    for (UIView *v in self.viewForSetImages.subviews) {
//        if ([v isKindOfClass:[UIImageView class]]) {
//            [v removeFromSuperview];
//        }
//    }
}
- (IBAction)btnSave:(id)sender {

    [self interstitialLoadCounter];

    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Save Image" delegate:self cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Save to Camera Roll",@"Twitter.!",@"FaceBook.!", @"Cancel", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheetStyle *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIGraphicsBeginImageContext(self.viewForSaveImage.bounds.size);
    [self.viewForSaveImage.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if (buttonIndex == 2)
    {
        if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
            SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
            
            [controller setInitialText:@"Somt Text..!"];
            [controller addImage:image1];
            
            [self presentViewController:controller animated:YES completion:Nil];
        }
        else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"UnSucess"
                                                                           message:@" Login his Account "
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
        
    }
    if (buttonIndex == 1)
    {
        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
        {
            SLComposeViewController *tweetSheet = [SLComposeViewController
                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
            [tweetSheet setInitialText:@"Somt Text..!"];
            
            [tweetSheet addImage:image1];
            
            [self presentViewController:tweetSheet animated:YES completion:nil];
        }
        
        else{
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"UnSucess"
                                                                           message:@"Login his Account "
                                                                    preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * action) {}];
            
            [alert addAction:defaultAction];
            [self presentViewController:alert animated:YES completion:nil];
            
        }
    }
    if (buttonIndex == 0)
    {
        UIImageWriteToSavedPhotosAlbum(image1, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error != NULL)
    {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@" Error ! "
                                                                       message:@"Image could not be saved.Please try again"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@" Success ! "
                                                                       message:@"Image was successfully saved in photoalbum"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (IBAction)btnBack:(id)sender {
    
    [self interstitialLoadCounter];

    [self.navigationController popViewControllerAnimated:YES];
    
}
- (IBAction)btnClose:(id)sender {
    
    [self interstitialLoadCounter];
    
    self.viewForCollectionView.hidden = YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _arrayForGalleryIamges.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    myCollectionViewCell *myCell = [collectionView
                                    dequeueReusableCellWithReuseIdentifier:@"MyCell"
                                    forIndexPath:indexPath];
    
    UIImage *image;
    long row = [indexPath row];
    image = [UIImage imageNamed:_arrayForGalleryIamges[row]];
    myCell.collectionCellImages.image = image;
    return myCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    indexOfRow = indexPath.row;
    //Load Images from Collection view
    [self LoadImagesFromCollectionView:indexOfRow];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
   // CGFloat screenhight = screenRect.size.height;
    float cellWidth = screenWidth /4;
    float cellHight = screenWidth /4;
    CGSize size = CGSizeMake(cellWidth, cellHight);
    return size;
}
-(void)LoadImagesFromCollectionView:(NSInteger)index{
    
    [self interstitialLoadCounter];

    //Add Image
    CGRect frame = CGRectMake(self.view.frame.size.width/15 , self.view.frame.size.height/5, self.view.frame.size.height/8, self.view.frame.size.height/8);
    myIamges = [[UIImageView alloc] initWithFrame:frame];
    [myIamges setImage:[UIImage imageNamed:_arrayForGalleryIamges[index]]];
    myIamges.tag = index;
    
    //Zoom In Image
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(scaleImage:)];
    [myIamges addGestureRecognizer:pin];
    [myIamges setUserInteractionEnabled:YES];
    [self.viewForSetImages addSubview:myIamges];
    self.viewForCollectionView.hidden = YES;
    
    UIRotationGestureRecognizer *rotationGestureRecognizer = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureDetected:)];
    [rotationGestureRecognizer setDelegate:self];
    [myIamges addGestureRecognizer:rotationGestureRecognizer];
    
}
-(void)scaleImage:(UIPinchGestureRecognizer*)pinRec{
    
    if (ImageCurrentScal * [pinRec scale] > ImageMixScal && ImageCurrentScal * [pinRec scale]< ImageMaxScal) {
        ImageCurrentScal = ImageCurrentScal * [pinRec scale];
        CGAffineTransform ZoomTrans = CGAffineTransformMakeScale(ImageCurrentScal, ImageCurrentScal);
        [[pinRec view]setTransform:ZoomTrans];
    }
    [pinRec setScale:1.0];
}

- (void)rotationGestureDetected:(UIRotationGestureRecognizer *)recognizer
{
    UIGestureRecognizerState state = [recognizer state];
    
    if (state == UIGestureRecognizerStateBegan || state == UIGestureRecognizerStateChanged)
    {
        CGFloat rotation = [recognizer rotation];
        [recognizer.self.view setTransform:CGAffineTransformRotate(recognizer.view.transform, rotation)];
        [recognizer setRotation:0];
    }
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count] == 1) {
        // one finger
        CGPoint touchPoint = [[touches anyObject] locationInView:self.viewForSetImages];
        
        for (UIImageView *iView in self.viewForSetImages.subviews) {
            
            if ([iView isMemberOfClass:[UIImageView class]]) {
                
                if (touchPoint.x > iView.frame.origin.x && touchPoint.x < iView.frame.origin.x + iView.frame.size.width &&
                    touchPoint.y > iView.frame.origin.y && touchPoint.y < iView.frame.origin.y + iView.frame.size.height)
                {
                    CurrentX = touchPoint.x - _touchOffset.x;
                    CurrentY = touchPoint.y - _touchOffset.y;
                    
                    self.dragObject = iView;
                    self.touchOffset = CGPointMake(touchPoint.x - iView.frame.origin.x,
                                                   touchPoint.y - iView.frame.origin.y);
                    self.homePosition = CGPointMake(iView.frame.origin.x,
                                                    iView.frame.origin.y);
                    [self.viewForCollectionView bringSubviewToFront:self.dragObject];
                    
                }
            }
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchPoint = [[touches anyObject] locationInView:self.viewForSetImages];
    CGRect newDragObjectFrame = CGRectMake(touchPoint.x - _touchOffset.x,
                                           touchPoint.y - _touchOffset.y,
                                           self.dragObject.frame.size.width,
                                           self.dragObject.frame.size.height);
    
    CurrentX = touchPoint.x - _touchOffset.x;
    CurrentY = touchPoint.y - _touchOffset.y;
        self.dragObject.frame = newDragObjectFrame;

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Touch end Current Position
    self.dragObject.frame = CGRectMake(CurrentX, CurrentY, self.dragObject.frame.size.width, self.dragObject.frame.size.height);
    
    //Touch end Previous position
    // CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
//       self.dragObject.frame = CGRectMake(self.homePosition.x, self.homePosition.y,
//                                       self.dragObject.frame.size.width,
//                                       self.dragObject.frame.size.height);
}

-(void)bannerViewLoad{
    
    NSLog(@"Google Mobile Ads SDK version: %@", [GADRequest sdkVersion]);
    
    self.bannerView.adUnitID = BannerID;
    self.bannerView.rootViewController = self;
    [self.bannerView loadRequest:[GADRequest request]];
}
-(void)loadBanner{
    [self.bannerView loadRequest:[GADRequest request]];
}

-(void)interstitialLoad{
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:IntertestialID];
    
    [self.interstitial presentFromRootViewController:self];
    [self.interstitial loadRequest:[GADRequest request]];
    self.interstitial.delegate = self;
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)ad
{
    [self.interstitial presentFromRootViewController:self];
}

-(void)loadUnityAdd{
    if (UnityAds.isReady) {
        [UnityAds show:self];
    }
}

-(void)interstitialLoadCounter{
    
    if (interstitialCounter == 3) {
        if (flagForUnityAd) {
            [self loadUnityAdd];
        }else{
            [self interstitialLoad];
        }
        flagForUnityAd = !flagForUnityAd;
        interstitialCounter = 0;
    }
    else{
        
        interstitialCounter++;
    }
}

- (void)unityAdsDidError:(UnityAdsError)error withMessage:(nonnull NSString *)message {
    
}

- (void)unityAdsDidFinish:(nonnull NSString *)placementId withFinishState:(UnityAdsFinishState)state{
    
}

- (void)unityAdsDidStart:(nonnull NSString *)placementId {
    
}

- (void)unityAdsReady:(nonnull NSString *)placementId {
    
}

@end
