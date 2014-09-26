//
//  FilterTableViewController.m
//  YelpApp
//
//  Created by Bal Kumar on 9/21/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import "FilterTableViewController.h"
#import "MainTableViewController.h"

@interface FilterTableViewController ()
@property (strong, nonatomic) IBOutlet UITableView *filterTable;

@property (strong, nonatomic) NSArray * filterSectionTitle;


@property(strong, nonatomic) NSDictionary * category;
@property(strong, nonatomic) NSDictionary * radius;

@property(strong, nonatomic) NSArray * catValues;
@property(strong, nonatomic) NSArray * radiusValues;

@property (strong, nonatomic) NSIndexPath * catSelectionPath;
@property (strong, nonatomic) NSIndexPath * radiusSelectionPath;



@end

@implementation FilterTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Filters";
    self.filterTable.delegate = self;
    self.filterTable.dataSource = self;

    
    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleDone target:self action:@selector(cancelSearch)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStyleDone target:self action:@selector(filterResult)];
   
    UINib *filterTabViewCellNib =[UINib nibWithNibName:@"FilterTableViewCell" bundle:nil];
    [self.tableView registerNib:filterTabViewCellNib forCellReuseIdentifier:@"FilterTableViewCell"];
    UINib *seeAllTabViewCellNib =[UINib nibWithNibName:@"SeeAllTableViewCell" bundle:nil];
    [self.tableView registerNib:seeAllTabViewCellNib forCellReuseIdentifier:@"SeeAllTableViewCell"];
    
     ///
    
    self.catSelectionPath = [NSIndexPath indexPathForRow:0 inSection:0];
    self.radiusSelectionPath =[NSIndexPath indexPathForRow:0 inSection:1];
    
    self.filterSectionTitle =@[@"Category", @"radius"];
    
    
    //Category Filter
    NSArray *keysCat = [NSArray arrayWithObjects:@"thai",@"indian",@"chinese",@"italian", nil];
    self.catValues = [NSArray arrayWithObjects:@"Thai", @"Indian", @"Chinese",@"italian", nil];
    self.category= [NSDictionary dictionaryWithObjects:keysCat forKeys:self.catValues];
    //Radius Filter
    NSArray *keysRadius = [NSArray arrayWithObjects:@"1609.34",@"3218.69",@"4828.03", @"6437.38", nil];
    self.radiusValues = [NSArray arrayWithObjects:@"1 mile", @"2 miles", @"3 miles", @"4 miles", nil];
    self.radius  =[NSDictionary dictionaryWithObjects:keysRadius forKeys:self.radiusValues];
 
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   
    NSLog(@"in section%ld",section);
    
    return [self.filterSectionTitle objectAtIndex:section];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [self.filterSectionTitle count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    NSInteger numberofRows = 0;
    switch (section) {
        case 0:
            numberofRows =  [self.category count];
            break;
        case 1:
            numberofRows =  [self.radius count];
            break;
        default:
            numberofRows = 0;
            break;
    }
    // NSLog(@"Number of row returned [%d] with section [%d]", numberofRows, section);
    return numberofRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    if(indexPath.section ==0){
        NSString *category = [self.catValues  objectAtIndex:indexPath.row];
        cell.textLabel.text = category;
        if([self.category isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    } else if(indexPath.section == 1){
        NSString *radius = [self.radiusValues objectAtIndex:indexPath.row];
        cell.textLabel.text = radius;
        if([self.radiusSelectionPath isEqual:indexPath])
        {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }
        else
        {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }  else{
        NSLog(@"Invalid section");
    }
    
    return cell;
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
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Uncheck the previous checked row
    if(indexPath.section == 0) {
        if(self.catSelectionPath)
        {
            UITableViewCell* uncheckCell = [tableView
                                            cellForRowAtIndexPath:self.catSelectionPath];
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        }
        if([self.catSelectionPath isEqual:indexPath])
        {
            self.catSelectionPath = nil;
        }
        else
        {
            UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.catSelectionPath = indexPath;
        }
    }else if(indexPath.section == 1){
        if(self.radiusSelectionPath)
        {
            UITableViewCell* uncheckCell = [tableView
                                            cellForRowAtIndexPath:self.radiusSelectionPath];
            uncheckCell.accessoryType = UITableViewCellAccessoryNone;
        }
        if([self.radiusSelectionPath isEqual:indexPath])
        {
            self.radiusSelectionPath = nil;
        }
        else
        {
            UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
            self.radiusSelectionPath = indexPath;
        }
    } else {
        NSLog(@"Invalid section");
    }
}
 


-(void) filterResult   {
    NSLog(@"inside filter result ");
   
    NSString *queryParams = [NSString stringWithFormat:@"c%@ategory=%@&radius=", self.category[self.catValues[self.catSelectionPath.row]], self.radius[self.radiusValues[self.radiusSelectionPath.row]]];
    
    NSLog(@"Query params =%@", queryParams);
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject:self.category[self.catValues[self.catSelectionPath.row]] forKey:@"category" ];
        [standardUserDefaults setInteger:[self.radius[self.radiusValues[self.radiusSelectionPath.row]] integerValue] forKey:@"radius"];
   
    
     [self.delegate filterPreferenceChange:self didClickonSearch:queryParams];
     [self.navigationController popViewControllerAnimated:YES];
//    
}

-(void) cancelSearch {
        NSLog(@"inside cancel search ");
       [self.navigationController popViewControllerAnimated:YES];
    
}







@end
