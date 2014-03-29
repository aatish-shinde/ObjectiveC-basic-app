//
//  LandmarksTableVC.h
//  FavoritePlaces
//
//  Created by Student on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LandmarkDetailGroupedTableVC.h"

@interface LandmarksTableVC : UITableViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@property (nonatomic, strong) NSMutableArray *landmarks;

@property (nonatomic, strong) UIBarButtonItem * addButton;

@property (nonatomic, strong) NSMutableArray *sortedRestaurants;

@property(nonatomic,strong)CLLocationManager *locationManager;

@property (nonatomic, strong) NSMutableArray *sortedArrayByDistance;

@property (nonatomic,strong) NMADRestaurant *restaurantArray;

@property(nonatomic, assign) int control;

@end
