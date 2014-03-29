//
//  FavTableVC.h
//  GPF-4
//
//  Created by Student on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMADRestaurant.h"

@interface FavTableVC : UITableViewController

@property (nonatomic, strong) NSMutableArray *restaurants;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSMutableArray *arr;
@property (nonatomic, strong) NSMutableArray *restaurantsFav;

-(void) addToFavorites:(int)str;

@end
