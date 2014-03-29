//
//  NMADRestaurant.h
//  GPF-1
//
//  Created by Anthony Jefferson on 9/11/11.
//  Copyright 2011 Rochester Institute of Technology. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface NMADRestaurant : NSObject<MKAnnotation>

@property(nonatomic,copy)NSString *state;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
-(NSString*)title;
-(NSString*)subtitle;
-(NSString*)dist;
//- (id)initWithName:(NSString *)lName state:(NSString *)lState coordinate:(CLLocationCoordinate2D)lCoordinate;


@property(nonatomic,copy)NSString *address;
@property(nonatomic,strong)NSDate *lastUpdate;
@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *plateName;
@property(nonatomic,copy)NSString *phoneNumber;
@property(nonatomic,assign)float rating;
@property(nonatomic,assign)int restaurantID;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,assign)float distance;

+ (id)restaurant;
- (id)initWithID:(int)r_id
            name:(NSString *)r_name
         address:(NSString *)r_address
             url:(NSString *)r_url
          rating:(float)r_rating
        location:(CLLocation *) r_location
       plateName:(NSString *)r_plateName
phoneNumber:(NSString *)r_phoneNumber
      lastUpdate:(NSDate *)r_lastUpdate
state:(NSString *)lState
coordinate:(CLLocationCoordinate2D)lCoordinate 
distance:(float)r_distance;

@end
