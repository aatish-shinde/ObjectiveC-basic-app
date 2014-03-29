//
//  NMADRestaurant.m
//  GPF-1
//
//  Created by Anthony Jefferson on 9/11/11.
//  Copyright 2011 Rochester Institute of Technology. All rights reserved.
//

#import "NMADRestaurant.h"

@implementation NMADRestaurant
@synthesize address,lastUpdate,location, name,plateName,phoneNumber,rating,restaurantID,url, coordinate, state, distance;

#pragma mark -
#pragma MKAnnotation methods

- (CLLocationCoordinate2D)coordinate{
    NSLog(@"coordinate called for %@", name);
    
    return coordinate;
}

- (id)initWithName:(NSString *)lName state:(NSString *)lState coordinate:(CLLocationCoordinate2D)lCoordinate{
    self = [super init];
    self.name = lName;
    self.state = lState;
    coordinate = lCoordinate;
    return self;
}


- (NSString *)title{
    return self.name;
}

- (NSString *)subtitle{
    return self.state;
}

-(NSString *) dist{
    
    NSString *aDist = [[NSString alloc] initWithFormat: @"%f", distance];
    
    return aDist;
}

#pragma mark - 
+ (id)restaurant{
    return [[NMADRestaurant alloc] init ];
}

- (id)init
{
    CLLocationCoordinate2D co = CLLocationCoordinate2DMake(0, 0);                                  
                                      
    return [self initWithID:0 name:@"TBD" address:@"TBD" url:@"TBD" rating:0.0 location:nil plateName:@"TBD" phoneNumber:@"TBD" lastUpdate:[NSDate date] state:@"TBD" coordinate:co distance:0.0];
}

- (id)initWithID:(int)r_id
            name:(NSString *)r_name
         address:(NSString *)r_address
             url:(NSString *)r_url
          rating:(float)r_rating
        location:(CLLocation *) r_location
       plateName:(NSString *)r_plateName
     phoneNumber:(NSString *)r_phoneNumber
      lastUpdate:(NSDate *)r_lastUpdate
           state:(NSString *)r_State
      coordinate:(CLLocationCoordinate2D)r_Coordinate
        distance:(float)r_distance
{
    self = [super init];
    self.restaurantID = r_id;
    self.address = r_address;
    self.name = r_name;
    self.url = r_url;
    self.rating = r_rating;
    self.location = r_location;
    self.plateName = r_plateName;
    self.phoneNumber = r_phoneNumber;
    
    self.lastUpdate = r_lastUpdate;
    self.state = r_State;
    coordinate = r_Coordinate;
    self.distance = r_distance;
    return self;
}


- (void)setRating:(float)value{
    if (value < 0 || value > 5.0) {
        NSLog(@"Bad value of %f in setRating - setting to 0.0",value);
        value = 0.0;
    }
    rating = value;
}


-(void)setRestaurantID:(int)value{
    if (value < 0) {
         NSLog(@"Bad value of %d in setRestaurantID - setting to 0",value);
        value = 0;
    }
    restaurantID = value;
}


- (NSString *)description{
    return [NSString stringWithFormat:@"address=%@, name=%@, rating=%f, restaurantID=%d, url=%@, location=%@, plateName=%@, phoneNumber=%@, lastUpdate=%@, distance=%f",address,name,rating,restaurantID,url,location,plateName,phoneNumber,lastUpdate, distance];
    
}

- (void)dealloc {
    NSLog(@"dealloc called for id=%d",restaurantID);
}

@end
