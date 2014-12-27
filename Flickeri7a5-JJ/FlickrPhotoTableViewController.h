//
//  FlickrPhotoTableViewController.h
//  Flickeri7a5-JJ
//
//  Created by JJ on 11/29/14.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlickrPhotoTableViewController : UITableViewController
@property (strong, nonatomic) NSArray *photos; // of Flickr photo NSDictionary
-(void) fetchPhotosForURL:(NSURL *)url;
@end
