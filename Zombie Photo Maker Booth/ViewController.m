//
//  ViewController.m
//  Zombie Photo Maker Booth
//
//  Created by Muhammad Luqman on 3/28/16.
//  Copyright © 2016 Muhammad Luqman. All rights reserved.
//

#import "ViewController.h"
#import "MakeZombieViewController.h"

@interface ViewController (){
    int i;
    UIImage *chosenImage;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self bannerViewLoad];
   // [self interstitialLoad];
    
    [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(loadBanner) userInfo:nil repeats:YES];
    
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
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
- (IBAction)btnCamera:(id)sender {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        [myAlertView show];
    }
    
    else{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    }
    
}
- (IBAction)btnGallery:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self performSegueWithIdentifier:@"MakeZombieSegue" sender:self];
    //self.backGroungImage.image = chosenImage;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"MakeZombieSegue"])
    {
        UIImage *myImages = (UIImage*)chosenImage;
        MakeZombieViewController* showViewController = segue.destinationViewController;
        showViewController.setImages = myImages;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//- (IBAction)save:(id)sender {
//    i++;
//        NSString *ImageName = [NSString stringWithFormat:@"%d.jpeg",i];
//        UIImage *image = [UIImage imageNamed:ImageName];
//        UIImageWriteToSavedPhotosAlbum(image, self,@selector(image:didFinishSavingWithError:contextInfo:), nil);
//   
//}
//- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
//{
//    if (error != NULL)
//    {
//        NSLog(@"Not Save");
//    }
//    else {
//        
//        NSLog(@"SucessFull Save");
//    }
//    
//}
//        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@" Error ! "
//                                                                       message:@"Image could not be saved.Please try again"
//                                                                preferredStyle:UIAlertControllerStyleAlert];
//
//        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
//                                                              handler:^(UIAlertAction * action) {}];
//
//        [alert addAction:defaultAction];
//        [self presentViewController:alert animated:YES completion:nil];


@end
