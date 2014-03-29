//
//  GPF_4AppDelegate.h
//  GPF-4
//
//  Created by Bryan French on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapVC.h"
#import "NMADRestaurant.h"
#import "LandmarksTableVC.h"
#import <CoreLocation/CoreLocation.h>

@interface GPF_4AppDelegate : UIResponder <CLLocationManagerDelegate, UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,strong)NSMutableArray *restaurants;
@property(nonatomic,strong)UITabBarController *tabBarController;

@property(nonatomic,strong)CLLocationManager *locationManager;

// We'll make our ViewControllers ivars
@property(nonatomic,strong)MapVC *mapVC;

// private helper methods
- (void)loadData;

@end
