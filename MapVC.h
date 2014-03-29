//
//  MapVC.h
//  GPF-4
//
//  Created by tonyj on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapVC : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>
@property(nonatomic,strong)IBOutlet MKMapView *mapView;
@property(nonatomic,strong)IBOutlet UIActivityIndicatorView *spinner;
@property(nonatomic,strong)NSMutableArray *restaurants;
@property(nonatomic,strong)CLLocationManager *locationManager;
-(IBAction)startUpdatingLocation;

-(IBAction)mapSatelliteSegmentControlTapped:(id)sender;

@end
