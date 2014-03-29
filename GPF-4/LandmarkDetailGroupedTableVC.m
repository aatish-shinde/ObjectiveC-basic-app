//
//  LandmarkGroupedTableVC.m
//  FavoritePlaces
//
//  Created by Bryan French on 1/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LandmarkDetailGroupedTableVC.h"

#define LANDMARK_NAME_SECTION  0
#define LANDMARK_CITY_SECTION  1
#define LANDMARK_COORDINATES_SECTION  2
#import "FavTableVC.h"
//#import "UrlViewController.h"

@implementation LandmarkDetailGroupedTableVC


@synthesize restaurant;

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
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // one section each for name, state, and coordinate
    return   7 ;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // each section will have only one row
    
    NSInteger inte = 1;
    
    switch  (section) {
            
        case 0 :
            inte = 2 ;
            break ;
        
        default :
            inte = 1;
            break;
    }
    
    return inte;
            
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
      
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSLog(@"display : %d",indexPath.section);
    
    // Configure the cell...
    
    switch  (indexPath. section ) {
        case   LANDMARK_NAME_SECTION :{
            
            if(indexPath.row==0){
                cell. textLabel . text  = self . restaurant . name ;
            }
            else if(indexPath.row==1){
                cell. textLabel . text  = self . restaurant . address ;
            }
            
        }
        break ;
            
        case   LANDMARK_CITY_SECTION :
            cell. textLabel . text  =  self . restaurant . state ;
            break ;
            
        case   LANDMARK_COORDINATES_SECTION :
        { 
            float  latitude =  self . restaurant . coordinate . latitude ;
            float  longitude =  self . restaurant . coordinate . longitude ;
            
            cell. textLabel . text  = [ NSString stringWithFormat : @"latitude: %f, longitude:%f" ,latitude,longitude];
        }
            break ;
        
        case 3:
        {
            //NSString * s1 = @"Call";
            //NSString * s2 = self.restaurant.phoneNumber;
            
            cell.textLabel.text = self.restaurant.phoneNumber; //[s1 stringByAppendingFormat:@" %s", s2];
        }
            break;

        case 4:
            cell.textLabel.text = self.restaurant.url;
            break;
            
        case 5:
            cell.textLabel.text = @"Show on Map";
            break;
            
        case 6:
            cell.textLabel.text = @"Add to Favorites";
            break;
                    
        default :
            NSLog ( @"Should not be here!!" );
            break ;
    }  // end switch
    
    // tell the textLabel of the cell to use at many lines as it needs
    cell. textLabel . numberOfLines  =  0 ;
    return  cell;
}  // end cellForRowAtIndexPath

// D) What is the title of each section?

// This delegate method is called once for each section
- ( NSString  *)tableView:( UITableView  *)tableView titleForHeaderInSection:( NSInteger )section{
    
    NSString  *title;
    switch  (section) {
        case   LANDMARK_NAME_SECTION :
            title =  @"Restaurant Name" ;
            break ;
            
        case   LANDMARK_CITY_SECTION :
            title =  @"Restaurant State" ;
            break ;
            
        case   LANDMARK_COORDINATES_SECTION :
            title =  @"Restaurant Coordinates" ;
            break ;
                 
        default :
            NSLog ( @"Should not be here!!" );
            break ;
    }  // end switch
    return  title;
    
}  // end titleForHeaderInSection

// How tall is each row?
// This delegate method is called once per row
- ( CGFloat )tableView:( UITableView  *)tableView heightForRowAtIndexPath:( NSIndexPath  *)indexPath{
    if  (indexPath. section  ==  2 ) {
        return   88.0 ;
    }  else  {
        return    44.0 ;
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

- ( void )tableView:( UITableView  *)tableView didSelectRowAtIndexPath:
( NSIndexPath  *)indexPath
{
    NSString  *msg;
    switch  (indexPath. section ) {
        case   LANDMARK_NAME_SECTION :
            msg =  @"You tapped Restaurant Name" ;
            break ;
            
        case   LANDMARK_CITY_SECTION :
            msg =  @"You tapped Restaurant State" ;
            break ;
            
        case   LANDMARK_COORDINATES_SECTION :
            msg =  @"You tapped Restaurant Coordinates" ;
            break ;
            
        case 3 :{
            
            
            NSURL *phoneNumberURL = [NSURL URLWithString:@"tel:8483330484"];
            [[UIApplication sharedApplication] openURL:phoneNumberURL];
        }
            
        case 4:{
            
            //NSDictionary *story = [self.landmarks objectAtIndex:[indexPath row]]; 
            
            NSURL *url = [NSURL URLWithString:self.restaurant.url];
            [[UIApplication sharedApplication] openURL:url];

        }
        break ;
        case 6:
        {
                                   
            FavTableVC  *favTableVC = [[ FavTableVC alloc ]init];
            
            [favTableVC addToFavorites:self.restaurant.restaurantID];
            
            /*FavTableVC  *favTableVC = [[ FavTableVC alloc ]init];
            
            NSMutableArray * array = [NSMutableArray arrayWithCapacity:100];
            
            [array addObject:self.restaurant.name];
            
            favTableVC.name = self.restaurant.name;
            
            favTableVC.restaurants  = array;*/
            
            msg =  @"Restaurant added to favorites";
                       
        }

        default :
            NSLog (@"Should not be here!!");
            break ;
    }  // end switch
    
    UIAlertView  * alert = [[ UIAlertView   alloc ]  initWithTitle : @""   message :msg  delegate : self   cancelButtonTitle : @"OK" otherButtonTitles : nil ]; 
    [alert  show ];
}
@end
