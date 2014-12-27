//
//  RecentlyViewedFlickrTableViewController.m
//  Flickeri7a5-JJ
//
//  Created by JJ on 11/29/14.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "RecentlyViewedFlickrTableViewController.h"
#import "FlickrFetcher.h"

@interface RecentlyViewedFlickrTableViewController ()

@end

@implementation RecentlyViewedFlickrTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super fetchPhotosForURL:[FlickrFetcher URLforRecentGeoreferencedPhotos]];
    NSLog(@"recent");
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
