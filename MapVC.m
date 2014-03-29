//
//  MapVC.m
//  GPF-4
//
//  Created by tonyj on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapVC.h"
#import "NMADRestaurant.h"

@implementation MapVC
@synthesize mapView,spinner,restaurants,locationManager;
#pragma mark -
#pragma mark Initialization
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        // ** Location Manager Stuff **
        self.locationManager = [[CLLocationManager alloc] init];
        // we release here because retainCount is now 2
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // default
        self.locationManager.distanceFilter = kCLDistanceFilterNone; // default
        
        // ** MapView Stuff **
        // We already set map properties like .delegate in Nib
        // Nothing else to do here
        
        // ** Spinner Stuff **
        // We already set spinner properties like .hidesWhenStopped in Nib
        // Nothing else to do here
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
#pragma mark -

#pragma mark Action Methods
-(IBAction)startUpdatingLocation{
    NSLog(@"startUpdatingLocation called");
    [self.locationManager startUpdatingLocation];
    [self.spinner startAnimating];
    
}
#pragma mark -


#pragma mark CLLocationManagerDelegate Methods
// These are messages that the locationManager will send to its delegate (mapVC, this object)
// Look them up under "CLLocationManagerDelegate" in help

// YOU DO - implement didUpdateToLocation:
//   Log to console
//   Zoom to user's currrent location
//    stop locationManager and spinner

- (IBAction)mapSatelliteSegmentControlTapped:(id)sender
{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    NSLog(@"mapSatelliteSegmentControlTapped");
    
    switch (segmentedControl.selectedSegmentIndex)
    {
        case 0: //satellite
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1 : //Standard
            self.mapView.mapType = MKMapTypeSatellite;
            NSLog(@"MKMapTypeSatellite");
            break;

        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:  //Map 
            self.mapView.mapType = MKMapTypeStandard;
            break;
    }
}



- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
	NSLog(@"locationManager failed with error=%@",error);
	// stop updating
    [self.locationManager stopUpdatingLocation];
    [self.spinner stopAnimating];
    
    // Show Alert
    NSString *msg = [NSString stringWithFormat:@"Location Manager Failed! error=%@",error];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alert show];
	
}

#pragma mark -


#pragma mark MKMapViewDelegate Methods
// These are messages that the mapView will send to its delegate (mapVC, this object)
// Look them up under "MKMapViewDelegate" in help
// This delegate method is called once for every annotation that is created.
// If no view is returned by this method, then only the default pin is seen by the user
- (MKAnnotationView *)mapView:(MKMapView *)mv viewForAnnotation:(id <MKAnnotation>)annotation{
	MKAnnotationView *view = nil;
	if(annotation != mv.userLocation) {
		// if it's NOT the user's current location pin, create the annotation
        NMADRestaurant *restaurantAnnotation = (NMADRestaurant*)annotation;
		// Look for an existing view to reuse
		view = [mv dequeueReusableAnnotationViewWithIdentifier:@"restaurantAnnotation"];
		// If an existing view is not found, create a new one
		if(view == nil) {
			view = [[MKPinAnnotationView alloc] initWithAnnotation:restaurantAnnotation
                                                    reuseIdentifier:@"restaurantAnnotation"];
		}
		
		// Now we have a view for the annotation, so let's set some properties
		[(MKPinAnnotationView *)view setPinColor:MKPinAnnotationColorRed];
		[(MKPinAnnotationView *)view setAnimatesDrop:YES];
		[view setCanShowCallout:YES];
		
		// Now create buttons for the annotation view
		// The 'tag' properties are set so that we can identify which button was tapped later
		UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
		leftButton.tag = 0;
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		rightButton.tag = 1;
		
		// Add buttons to annotation view
		[view setLeftCalloutAccessoryView:leftButton];
		[view setRightCalloutAccessoryView:rightButton];
	}
	
	// send this annotation view back to MKMapView so it can add it to the pin 
	return view;
}

// This method is called when one of the two buttons added to the annotation view is tapped
- (void)mapView:(MKMapView *)mv annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
	NMADRestaurant *restaurantAnnotation = (NMADRestaurant *)[view annotation];
	switch ([control tag]) {
		case 0: // left button
		{
            NSURL *url = [NSURL URLWithString:restaurantAnnotation.url];
            [[UIApplication sharedApplication] openURL:url];
		}
            break;
            
		case 1: // right button
		{
            // build a maps url. This will launch the Maps app on the hardware, and the google maps website in the simulator
            CLLocationCoordinate2D coordinate = locationManager.location.coordinate; 
            NSString *url = [NSString stringWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%@",coordinate.latitude,coordinate.longitude,[restaurantAnnotation.address stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
            
            NSLog(@"trying to open url=%@",url);
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString: url]];		
        }
            break;
            
		default:
            NSLog(@"Should not be here in calloutAccessoryControlTapped, tag=%d!",[control tag]);
            break;
	}
}

#pragma mark -



#pragma mark -


#pragma mark - View lifecycle

- (void)viewDidLoad
{   
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"viewDidLoad called");
    [self.mapView addAnnotations:self.restaurants];
    [self startUpdatingLocation];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
#pragma mark -
@end
