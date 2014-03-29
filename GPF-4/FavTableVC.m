//
//  FavTableVC.m
//  GPF-4
//
//  Created by Student on 4/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FavTableVC.h"
#import "LandmarkDetailGroupedTableVC.h"

@implementation FavTableVC
@synthesize restaurants, name, arr, restaurantsFav;

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
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.restaurantsFav = [NSMutableArray array];
    
        
    [self.tableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animate
{
    if(editing)
    {
        NSLog(@"editMode on");
    }
    else
    {
        NSLog(@"Done leave editmode");
    }
    
    [super setEditing:editing animated:animate];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) 
    {
                
        NSLog(@"deleted : ");
        
        //[self.restaurantsFav removeObjectAtIndex:indexPath.row];
        
        //[[NSUserDefaults standardUserDefaults] :@"favourites" ]; 
                
        NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"favourites"]];
                        
        NSLog(@"indexPath.row %d",indexPath.row);
        
        NSLog(@"self.arr %d",arr.count);
        
        NSLog(@"print array %@",arr);
        
        
        
        [array removeObjectAtIndex:indexPath.row];
         
        
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"favourites"];
        
        //NSLog(@"array count %d",self.arr.count);
        
        [self.tableView reloadData];       
    }
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
    [self.tableView reloadData];
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
  
    // Return the number of rows in the section.
           
    arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"favourites"];
    
    [[self restaurantsFav]removeAllObjects];
    
    for(str in arr){
        
        //NSLog(@"Restaurants ID %s", [restaurants objectAtIndex:str.intValue]);
        for(rest in restaurants){
            //NSLog(@"Compare the ids %d", rest.restaurantID);
            if(str.intValue==rest.restaurantID){
                
                //NSLog(@"My fav restaurant : %d", rest.restaurantID);
                NSLog(@"r=%@\n\n",rest);
                
                [self.restaurantsFav addObject: rest];
            }
        }
        
    }
    

     NSLog(@"restaurant count = %d",self.restaurantsFav.count);
    
    return self.restaurantsFav.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //NSLog(@"Restaurant title %@", [[restaurantsFav objectAtIndex:indexPath.row] title]);
    
    cell.textLabel.text = [[restaurantsFav objectAtIndex:indexPath.row] title];
        
    cell.detailTextLabel.text = [[restaurantsFav objectAtIndex:indexPath.row] subtitle];    
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


-(void) addToFavorites:(int)restaurantID{
    
    // NSLog(@"restaurantID %d", restaurantID);
    
    
    //NSMutableArray *favorite;
    NSMutableArray *array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] arrayForKey:@"favourites"]];
    
    if (![array containsObject:[NSNumber numberWithInt:restaurantID]]) {
                
        [array addObject:[NSNumber numberWithInt:restaurantID]];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"favourites"];
                    
              
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
    NMADRestaurant  *landmark = [ restaurantsFav  objectAtIndex :indexPath. row ];
    
    LandmarkDetailGroupedTableVC  *detailVC = [[ LandmarkDetailGroupedTableVC alloc ]initWithStyle:UITableViewStyleGrouped ];
    
    detailVC. title  = landmark. title;
    
    detailVC.restaurant  = landmark;
    
    [ self . navigationController   pushViewController :detailVC  animated : YES ];
    
}


@end
