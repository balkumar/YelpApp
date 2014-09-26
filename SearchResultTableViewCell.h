//
//  SearchResultTableViewCell.h
//  YelpApp
//
//  Created by Bal Kumar on 9/20/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SearchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *searchResultImageView;
@property (weak, nonatomic) IBOutlet UILabel *searchResultTitle;
@property (weak, nonatomic) IBOutlet UIImageView *searchResultRatingImageView;
@property (weak, nonatomic) IBOutlet UILabel *searchResultDistLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchResultAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *searchResultCatLabel;
 
- (void)reloadData ;

@end
