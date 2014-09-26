//
//  FilterTableViewController.h
//  YelpApp
//
//  Created by Bal Kumar on 9/21/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FilterTableViewController;

@protocol FilterTableViewControllerDelegate <NSObject>
- (void)filterPreferenceChange:(FilterTableViewController *)controller didClickonSearch:(NSString *)parms;
@end

@interface FilterTableViewController : UITableViewController
@property (nonatomic, weak) id <FilterTableViewControllerDelegate> delegate;

@end

