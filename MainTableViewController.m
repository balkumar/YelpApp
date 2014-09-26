//
//  MainTableViewController.m
//  YelpApp
//
//  Created by Bal Kumar on 9/19/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import "MainTableViewController.h"
#import "YelpClient.h"
#import "SearchResultTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import <objc/runtime.h>
#import "FilterTableViewController.h"


NSString * const kYelpConsumerKey = @"vxKwwcR_NMQ7WaEiQBK_CA";
NSString * const kYelpConsumerSecret = @"33QCvh5bIF5jIHR5klQr7RtBDhQ";
NSString * const kYelpToken = @"uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV";
NSString * const kYelpTokenSecret = @"mqtKIxMIR4iBtBPZCmCLEb-Dz3Y";

@interface MainTableViewController ()
@property (nonatomic, strong) YelpClient *client;
@property (nonatomic, strong) NSArray *srchResultArray;
@property (strong, nonatomic)  UISearchBar *searchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;



@end

@implementation MainTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"Inside view did load");
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight= 125;
 
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchResultTableViewCell" bundle:nil] forCellReuseIdentifier:@"SearchResultTableViewCell"];
    

     // self.navigationItem.rightBarButtonItem = self.editButtonItem;

     self.searchBar = [[UISearchBar alloc] init];

    
    [self  navigationItem].titleView = self.searchBar;
    UIBarButtonItem * filterButton = [[UIBarButtonItem alloc] initWithTitle:@"Filter"
                                                                      style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                     action:@selector(goToFilterView)
                                      ];
    
    self.navigationItem.leftBarButtonItem = filterButton;
 
    
    NSUserDefaults *standardDefaults = [[NSUserDefaults alloc]init];
    if(standardDefaults){
        
        NSLog(@" filter 1 %@",[standardDefaults objectForKey:@"category"]);
        NSLog(@" filter 1 %@",[standardDefaults objectForKey:@"radius"]);
    }
    //load data
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret ];
    
    [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {

    
        
        
         NSData *  nsd =   (NSData *) response;
        
        
//          char* className = class_getName([nsd class]);
//        NSLog(@"CLASS  yourObject is a: %s", className);
//
          NSLog(@" GOT response 1111");
       
         NSDictionary *object = (NSDictionary *) response;//[NSJSONSerialization JSONObjectWithData:str options:0 error:nil];
         NSLog(@" !!  222");
        
        NSArray * tmpArr =object[@"businesses"];
        self.srchResultArray = tmpArr;//tmpArr[1];
        NSLog(@" !!  333 %ld", self.srchResultArray.count);

        [self.tableView reloadData];
        NSLog(@" After refreshing data");
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"errorrrrrrrr: %@", [error description]);
    }];
    
    [self.tableView reloadData];
    
    NSLog(@"before exiting view did load");
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
     NSLog(@"total cnt %ld", [self.srchResultArray count]);
    return  self.srchResultArray.count;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // You can register for Yelp API keys here: http://www.yelp.com/developers/manage_api_keys
        self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret];
        
        [self.client searchWithTerm:@"Thai" success:^(AFHTTPRequestOperation *operation, id response) {
           // NSLog(@"response: %@", response);
            self.srchResultArray = response;
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"error: %@", [error description]);
        }];
    }
    return self;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"index path :%ld",indexPath.row);
    
    SearchResultTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultTableViewCell"];
    // NSLog(@"***  2");
    
    NSDictionary *srchResultRow = self.srchResultArray[indexPath.row];
    NSLog(@"***  2.1");
    
    NSString *addr = (NSString * )[srchResultRow valueForKeyPath:@"location.address"];
    NSLog(@"***  2.22222");
  
//             char* className = class_getName([addr class]);
//            NSLog(@"CLASS  addr  is a: %s", className);
   
    NSArray *arr = (NSArray * )[srchResultRow valueForKeyPath:@"location.address"];
    NSString * addr1 =(NSString *) (NSString *) [arr objectAtIndex:0] ;
    NSLog(@"***  2.22222 %@",addr1 );
    cell.searchResultAddressLabel.text = addr1;
    
    
    NSString *name = [ NSString stringWithFormat:@"%ld. ",(long)indexPath.row +1  ];
    name = [name stringByAppendingString:srchResultRow[@"name"]];
   
    //name
    cell.searchResultTitle.text =name  ;
    // image url
    NSString *restaurantUrl =      srchResultRow[@"image_url"];
    NSLog(@"posterUrl %@",restaurantUrl);
    [cell.searchResultImageView setImageWithURL:[NSURL URLWithString:restaurantUrl]];

    // image url
    NSString *ratingUrl = srchResultRow[@"rating_img_url_small"];
    NSLog(@"ratingUrl %@",ratingUrl);
    [cell.searchResultRatingImageView setImageWithURL:[NSURL URLWithString:ratingUrl]];
    
    cell.searchResultCatLabel.text=@"Thai";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [self.searchBar resignFirstResponder];
}


-(void)filterPreferenceChange:(FilterTableViewController *)controller didClickonSearch:(NSString *)params
{
    
    NSLog(@"Finally got the params from other controller %@", params);
//    NSMutableDictionary* result = [@{} mutableCopy];
//    [[params componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL *stop) {
//        NSArray* components = [obj componentsSeparatedByString:@"="];
//        result[components[0]] = components[1];
//    }];
//    
//    [self getYelpResultsWithSearchText:@"" WithCategory:result[@"category"] withSortBy:[result[@"sortby"] integerValue] withRadius:[result[@"radius"] integerValue] withDeals:[result[@"deals"] integerValue]];
//    NSLog(@"%@", result);
    NSUserDefaults *standardDefaults = [[NSUserDefaults alloc]init];
    if(standardDefaults){
        
        NSLog(@" filter 1 %@",[standardDefaults objectForKey:@"category"]);
        NSLog(@" filter 1 %@",[standardDefaults objectForKey:@"radius"]);
    }
    
    
}


- (void)goToFilterView {
   
    [self.navigationController pushViewController:[[FilterTableViewController alloc]init]  animated:YES];
    NSLog(@"goto filter view");
}


- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
    NSUserDefaults *standardDefaults = [[NSUserDefaults alloc]init];
    NSString * catParam, * radParam ;
    
     if(standardDefaults){
     
        catParam =[standardDefaults objectForKey:@"category"];
        radParam =[standardDefaults objectForKey:@"radius"];
        
        NSLog(@" filter 1 %@",catParam);
        NSLog(@" filter 2 %@",radParam);
    }
    
   
    
      //   NSMutableDictionary* result = [@{} mutableCopy];
      //   [[params componentsSeparatedByString:@"&"] enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL *stop) {
    //        NSArray* components = [obj componentsSeparatedByString:@"="];
    //        result[components[0]] = components[1];
    //    }];
    //
    //    [self getYelpResultsWithSearchText:@"" WithCategory:result[@"category"] withSortBy:[result[@"sortby"] integerValue] withRadius:[result[@"radius"] integerValue] withDeals:[result[@"deals"] integerValue]];
    //    NSLog(@"%@", result);
    
    
    //load data
   
    if (catParam  != nil  || radParam != nil ) {
    
    self.client = [[YelpClient alloc] initWithConsumerKey:kYelpConsumerKey consumerSecret:kYelpConsumerSecret accessToken:kYelpToken accessSecret:kYelpTokenSecret ];
    
    [self.client searchWithTerm:catParam  success:^(AFHTTPRequestOperation *operation, id response) {
        
        
        
        NSLog(@" GOT response 1111");
        
        NSDictionary *object = (NSDictionary *) response;//[NSJSONSerialization JSONObjectWithData:str options:0 error:nil];
        NSLog(@" !!  222");
        
        NSArray * tmpArr =object[@"businesses"];
        self.srchResultArray = tmpArr;//tmpArr[1];
        NSLog(@" !!  333 %ld", self.srchResultArray.count);
        
        [self.tableView reloadData];
        NSLog(@" After refreshing data");
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"errorrrrrrrr: %@", [error description]);
    }];
    
    [self.tableView reloadData];
    
    }else{
        
        NSLog(@"PAram is nil");
        }
  //  [self resetDefaults];
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}


- (void)textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:self.searchBar afterDelay:0];
    }
}




- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar1
{
    [self.view endEditing:YES];
    [searchBar1 resignFirstResponder];
}


- (void)resetDefaults {
              NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
              NSDictionary * dict = [defs dictionaryRepresentation];
              for (id key in dict) {
                  [defs removeObjectForKey:key];
              }
              [defs synchronize];
}

@end

