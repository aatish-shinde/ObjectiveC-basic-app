//
//  AboutVC.m
//  FavoritePlaces
//
//  Created by tonyj on 10/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutVC.h"

@implementation AboutVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	self.view.backgroundColor = [UIColor whiteColor];
	// Make a Label
	CGRect frame = CGRectMake(60, 40, 200, 21);
	UILabel *label = [[UILabel alloc] initWithFrame:frame];
	label.text = @"Plate Finder";
	label.backgroundColor = [UIColor clearColor];
	UIFont *font = [UIFont fontWithName:@"Marker Felt" size:24.0];
	label.font = font;
	label.shadowColor = [UIColor whiteColor];
	label.shadowOffset = CGSizeMake(1, 1);
	// let's do some affine transforms
	CGAffineTransform trans = label.transform;
	trans = CGAffineTransformRotate(trans, .25);
	trans = CGAffineTransformTranslate(trans, 80, 30);
	trans = CGAffineTransformScale(trans, 2.0, 0.8);
	    
    //
    /*
    if(UI_USER_INTERFACE_IDIOM() ==UIUserInterfaceIdiomPad){
        trans = CGAffineTransformTranslate(trans, 120, 450);
        trans = CGAffineTransformScale(trans, 4.50, 2.5);
        trans = CGAffineTransformRotate(trans, 1.1);
    }
    */
    //
    //label.transform = trans;
	//[self.view addSubview:label];

}

- (void)viewDidUnload
{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
}

- (void)viewDidDisappear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
}

- (void)viewWillAppear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
}

- (void)viewWillDisappear:(BOOL)animated{
    NSLog(@"%@ method called in class %@ on line #%d",NSStringFromSelector(_cmd),[self class],__LINE__);
}

#pragma mark -

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
