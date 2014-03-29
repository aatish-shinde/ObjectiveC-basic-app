//
//  LandmarksTableVC.m
//  FavoritePlaces
//
//  Created by Student on 4/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LandmarksTableVC.h"


@implementation LandmarksTableVC

@synthesize landmarks, addButton, sortedRestaurants, locationManager, sortedArrayByDistance, restaurantArray, control;
NSNumber *str;
NMADRestaurant *rest;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    NSArray *itemArray = [NSArray arrayWithObjects: @"A-Z", @"Z-A", @"Distance", nil];
    
    UIFont *font = [UIFont boldSystemFontOfSize:12.0f];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                           forKey:UITextAttributeFont];
           
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:itemArray];
    segmentedControl.frame = CGRectMake(35, 5, 240, 30);
	segmentedControl.segmentedControlStyle = UISegmentedControlStylePlain;
	segmentedControl.selectedSegmentIndex = 0;
    
    [segmentedControl setTitleTextAttributes:attributes 
                                    forState:UIControlStateNormal];

    [segmentedControl addTarget:self
	                     action:@selector(sortAscending:)
	           forControlEvents:UIControlEventValueChanged];
    
        
    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];

    self.navigationItem.rightBarButtonItem = back;
        
    //[self.view addSubview:segmentedControl];
           
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    //self.sortedRestaurants = [self.restaurantDictionary objectForKey:@"restaurants"];
    
     //NSLog(@"sortedRestaurants Restaurants length %d", sortedRestaurants.count);
    
    if(self.sortedRestaurants.count==0){
        NSLog(@"landmarks");
        return [self.landmarks count];
    }
    else
    {
        
        self.landmarks = self.sortedRestaurants;
        return [self.sortedRestaurants count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.textLabel.text = [[landmarks objectAtIndex:indexPath.row] title];
    
    if(control==2){
        NSLog(@"control = %d",control);
        
         cell.detailTextLabel.text = [[landmarks objectAtIndex:indexPath.row] dist];
    }
    else{
        cell.detailTextLabel.text = [[landmarks objectAtIndex:indexPath.row] subtitle];
    }
  
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}

- (void) sortAscending:(id)sender{
    
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    
    if(segmentedControl.selectedSegmentIndex==0){
        self.control = segmentedControl.selectedSegmentIndex;
        
        NSLog(@"segmentedControl.selectedSegmentIndex %d",segmentedControl.selectedSegmentIndex);
        
        NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
        NSArray *sortedArray = [self.landmarks sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
    
       self.sortedRestaurants = [NSMutableArray arrayWithArray:sortedArray];
        
        //self.sortedRestaurants = [self.restaurantDictionary objectForKey:@"restaurants"];
        
        NSLog(@"sortedRestaurants Restaurants length %d", sortedRestaurants.count);
        
        [self.tableView reloadData];
    }
    else if(segmentedControl.selectedSegmentIndex==1){
        
        segmentedControl.selectedSegmentIndex = 1;
        self.control = segmentedControl.selectedSegmentIndex;
        
        NSLog(@"segmentedControl.selectedSegmentIndex %d",segmentedControl.selectedSegmentIndex);
        
        NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:NO];
        
        NSArray *sortedArray = [self.landmarks sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
                
        
        self.sortedRestaurants = [NSMutableArray arrayWithArray:sortedArray];
        
        //self.sortedRestaurants = [self.restaurantDictionary objectForKey:@"restaurants"];
        
        NSLog(@"sortedRestaurants Restaurants length %d", sortedRestaurants.count);
        
        [self.tableView reloadData];
    }
    else{
        
        segmentedControl.selectedSegmentIndex = 2;
        self.control = segmentedControl.selectedSegmentIndex;
            
        NSSortDescriptor *nameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distance" ascending:YES];      
        
        NSArray *sortedArray = [self.landmarks sortedArrayUsingDescriptors:[NSArray arrayWithObject:nameSortDescriptor]];
            
        self.sortedRestaurants = [NSMutableArray arrayWithArray:sortedArray];
        
        //NSLog(@"sortedRestaurants Restaurants length %d", sortedRestaurants.count);
        
        [self.tableView reloadData];
        
    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- ( void )tableView:( UITableView  *)tableView didSelectRowAtIndexPath:( NSIndexPath  *)indexPath
{
    NMADRestaurant  *landmark = [ self . landmarks   objectAtIndex :indexPath. row ];
    
    LandmarkDetailGroupedTableVC  *detailVC = [[ LandmarkDetailGroupedTableVC alloc ]initWithStyle:UITableViewStyleGrouped ];
    
    detailVC. title  = landmark. title;
    
    detailVC.restaurant  = landmark;
    
    NSLog(@"in LandmarksTableVC");
    
    [ self . navigationController   pushViewController :detailVC  animated : YES ];
    
    
    
}


@end
