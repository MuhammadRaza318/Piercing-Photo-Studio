//
//  ViewController.h
//  Zombie Photo Maker Booth
//
//  Created by Muhammad Luqman on 3/28/16.
//  Copyright © 2016 Muhammad Luqman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,GADBannerViewDelegate,GADInterstitialDelegate>

- (IBAction)btnCamera:(id)sender;
- (IBAction)btnGallery:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *backGroungImage;

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;


//- (IBAction)save:(id)sender;
@end

