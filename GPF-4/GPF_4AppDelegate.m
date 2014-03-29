//
//  GPF_4AppDelegate.m
//  GPF-4
//
//  Created by Bryan French on 12/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NMADRestaurant.h"

#define kGPF_DATA_FILE_NAME @"data"
#define kGPF_RESTAURANT_ID_KEY @"restaurantID"
#define kGPF_RESTAURANT_NAME_KEY @"name"
#define kGPF_RESTAURANT_STREET_KEY @"street"
#define kGPF_RESTAURANT_CITY_KEY @"city"
#define kGPF_RESTAURANT_STATE_KEY @"state"
#define kGPF_RESTAURANT_ZIP_KEY @"zip"
#define kGPF_RESTAURANT_AREACODE_KEY @"areaCode"
#define kGPF_RESTAURANT_PHONENUMBER_KEY @"phoneNumber"
#define kGPF_RESTAURANT_LATITUDE_KEY @"latitude"
#define kGPF_RESTAURANT_LONGITUDE_KEY @"longitude"
#define kGPF_RESTAURANT_URL_KEY @"url"
#define kGPF_RESTAURANT_LASTUPDATE_KEY @"lastUpdate"
#define kGPF_RESTAURANT_PLATENAME_KEY @"plateName"
#import "GPF_4AppDelegate.h"
#import "AboutVC.h"
#import "LandmarksTableVC.h"
#import "FavTableVC.h"

@implementation GPF_4AppDelegate

@synthesize window = _window,restaurants,tabBarController,mapVC, locationManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self loadData];
    
    // create tab bar
    self.tabBarController = [[UITabBarController alloc] init];
    
    
    // create map
    self.mapVC = [[MapVC alloc] initWithNibName:nil bundle:nil];
    self.mapVC.title = @"Map";
    self.mapVC.restaurants = restaurants;
    
    // GPF-4A
    // YOU DO - create Restaurants UITableViewController subclass
    
    LandmarksTableVC *landmarkTableVC = [[LandmarksTableVC alloc] initWithNibName:nil bundle:nil];
    landmarkTableVC.landmarks = restaurants;
    //landmarkTableVC.title = @"Restaurants";
    
    FavTableVC *favTableVC = [[FavTableVC alloc] initWithNibName:nil bundle:nil];
    favTableVC.restaurants = restaurants;
    favTableVC.title = @"Favorites";
    
    
    
    //part 4
    UINavigationController *landmarksNavController = [[UINavigationController alloc] initWithRootViewController:landmarkTableVC]; 
        
    //landmarksNavController.navigationItem.
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [button addTarget:self action:@selector(sortAscending) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    landmarksNavController.navigationItem.leftBarButtonItem = left;
    
    //add navigation controller for favourites
   UINavigationController *favNavController = [[UINavigationController alloc] initWithRootViewController:favTableVC]; 
    
    // GPF-4B
    // YOU DO - create AboutVC subclass
    // YOU DO - create Favorites UITableViewController subclass
    AboutVC *aboutVC = [[AboutVC alloc] initWithNibName:nil bundle:nil];
    aboutVC.title = @"About";
    
    // icons
    UITabBarItem *mapItem = [[UITabBarItem alloc] initWithTitle:@"Map" image:[UIImage imageNamed:@"72-pin.png"] tag:0];
    UITabBarItem *aboutItem = [[UITabBarItem alloc] initWithTitle:@"About" image:[UIImage imageNamed:@"eye.png"] tag:0];
    UITabBarItem *landmark = [[UITabBarItem alloc] initWithTitle:@"Restaurants" image:[UIImage imageNamed:@"59-flag.png"] tag:0];
    
    UITabBarItem *favorites = [[UITabBarItem alloc] initWithTitle:@"Favourites" image:[UIImage imageNamed:@"48-fork-and-knife.png"] tag:0];
    
    //
    mapVC.tabBarItem = mapItem;
    aboutVC.tabBarItem = aboutItem;
    landmarkTableVC.tabBarItem = landmark;
    favTableVC.tabBarItem = favorites;
    
    NSArray *viewControllers = [NSArray arrayWithObjects:mapVC, aboutVC, landmarksNavController, favNavController, nil];
    tabBarController.viewControllers = viewControllers;
    [self.window addSubview:tabBarController.view];
    
    [self.window makeKeyAndVisible];

    
    return YES;
}

- (void)loadData{
    // load data
    NSString *path = [[NSBundle mainBundle] pathForResource:kGPF_DATA_FILE_NAME ofType:@"plist"];
    NSDictionary *tempDictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    NSArray *tempArray = [tempDictionary objectForKey:@"restaurants"];
    
    // create restaurants ivar
    self.restaurants = [NSMutableArray array];
    
    self.locationManager = [[CLLocationManager alloc] init];
    // we release here because retainCount is now 2
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // default
    self.locationManager.distanceFilter = kCLDistanceFilterNone; // default
    
    [locationManager startUpdatingLocation];
    
    CLLocation *firstLocation = [locationManager location];
    
    for (id dict in tempArray) {
        //  NSLog(@"dict=%@",dict);
        
        int restaurantID = [[dict objectForKey:kGPF_RESTAURANT_ID_KEY] integerValue];
        NSString *name = [dict objectForKey:kGPF_RESTAURANT_NAME_KEY];
        
        // build address
        NSString *street = [dict objectForKey:kGPF_RESTAURANT_STREET_KEY];
        NSString *city = [dict objectForKey:kGPF_RESTAURANT_CITY_KEY];
        NSString *state = [dict objectForKey:kGPF_RESTAURANT_STATE_KEY];
        NSString *zip = [dict objectForKey:kGPF_RESTAURANT_ZIP_KEY];
        NSString *address = [NSString stringWithFormat:@"%@ %@,%@ %@",street,city,state,zip];
        
        // build phone number
        NSString *areaCode = [dict objectForKey:kGPF_RESTAURANT_AREACODE_KEY];
        NSString *phoneNumber = [dict objectForKey:kGPF_RESTAURANT_PHONENUMBER_KEY];
        NSString *fullPhoneNumber = [NSString stringWithFormat:@"(%@)%@",areaCode,phoneNumber];
        
        // build location
        float latitude = [[dict objectForKey:kGPF_RESTAURANT_LATITUDE_KEY] floatValue];
        float longitude = [[dict objectForKey:kGPF_RESTAURANT_LONGITUDE_KEY] floatValue];
        CLLocation *secondLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
        
        NSString *url = [dict objectForKey:kGPF_RESTAURANT_URL_KEY];
        NSDate *lastUpdate = [dict objectForKey:kGPF_RESTAURANT_LASTUPDATE_KEY];
        NSString * plateName = [dict objectForKey:kGPF_RESTAURANT_PLATENAME_KEY];
        
        CLLocationDistance restDistance = [secondLocation distanceFromLocation:firstLocation];
        
        float distance = restDistance / 1000.0;
        
        NSLog(@"Distance between 2 points %f",distance);

        //NSNumber *aDist = [[NSNumber alloc] initWithFormat: @"%f", distance];
        
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);
               
        // Create NMADRestaurant objects
        
        NMADRestaurant *r = [[NMADRestaurant alloc] initWithID:restaurantID
                                                          name:name
                                                       address:address 
                                                           url:url 
                                                        rating:0 
                                                      location:secondLocation 
                                                     plateName:plateName 
                                                   phoneNumber:fullPhoneNumber 
                                                    lastUpdate:lastUpdate
                                                         state:state
                                                    coordinate:coordinate
                                                      distance:distance];
        
        // log it out to make sure it's a good restaurant
        NSLog(@"r=%@\n\n",r);
        // add to  self.restaurants array
        [self.restaurants addObject:r];
    }
    
    NSLog(@"there are %d landmarks",[self.restaurants count]);
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
