//
//  SearchResultTableViewCell.m
//  YelpApp
//
//  Created by Bal Kumar on 9/20/14.
//  Copyright (c) 2014 Y.CORP.YAHOO.COM\bal. All rights reserved.
//

#import "SearchResultTableViewCell.h"

@implementation SearchResultTableViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




//- (void)reloadData {
////    
////    @interface SearchResultTableViewCell : UITableViewCell
////    @property (weak, nonatomic) IBOutlet UIImageView *searchResultImageView;
////    @property (weak, nonatomic) IBOutlet UILabel *searchResultTitle;
////    @property (weak, nonatomic) IBOutlet UIImageView *searchResultRatingImageView;
////    @property (weak, nonatomic) IBOutlet UILabel *searchResultDistLabel;
////    @property (weak, nonatomic) IBOutlet UILabel *searchResultAddressLabel;
////    @property (weak, nonatomic) IBOutlet UILabel *searchResultCatLabel;
//
//    
//    
//    self.searchResultTitle.text = _restaurant.name;
// //   self.reviewsLabel.text = [[NSString alloc] initWithFormat:@"%d reviews", _restaurant.reviewCount];
//    self.searchResultAddressLabel.text = _restaurant.displayAddress;
//    self.searchResultCatLabel.text = _restaurant.categories;
//   // [self.searchResultImageView setImageWithURL:_restaurant.imageURL withAnimationDuration:0.5];
//  //  [self.searchResultRatingImageView setImageWithURL:_restaurant.ratingImageURL withAnimationDuration:0.5];
//}

@end
