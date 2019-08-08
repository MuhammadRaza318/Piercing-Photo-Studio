//
//  MakeZombieViewController.h
//  Zombie Photo Maker Booth
//
//  Created by Muhammad Luqman on 3/28/16.
//  Copyright © 2016 Muhammad Luqman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "Constants.h"
@import UnityAds;

static BOOL flagForUnityAd;
@interface MakeZombieViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate,UIGestureRecognizerDelegate,GADBannerViewDelegate,GADInterstitialDelegate, UnityAdsDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageZombie;

@property (strong , nonatomic)UIImage *setImages;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnGallery:(id)sender;
- (IBAction)btnDelete:(id)sender;
- (IBAction)btnSave:(id)sender;


@property (nonatomic, strong) UIImageView *dragObject;
@property (nonatomic, assign) CGPoint touchOffset;
@property (nonatomic, assign) CGPoint homePosition;


@property (strong, nonatomic) NSMutableArray *arrayForGalleryIamges;
@property (weak, nonatomic) IBOutlet UIView *zombieView;
@property (weak, nonatomic) IBOutlet UIImageView *zombieImage;
- (IBAction)btnClose:(id)sender;
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (weak, nonatomic) IBOutlet UIView *viewForCollectionView;

@property (weak, nonatomic) IBOutlet UIView *viewForSetImages;

@property (weak, nonatomic) IBOutlet UIView *viewForSaveImage;

@property (weak, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *interstitial;

@end
