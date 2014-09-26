//
//  FilterTableViewCell.h
//  YelpApp
//
//  Created by Bal Kumar on 9/21/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FilterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FilterLabel;
@property (weak, nonatomic) IBOutlet UISwitch *FilterEnabled;

@end
