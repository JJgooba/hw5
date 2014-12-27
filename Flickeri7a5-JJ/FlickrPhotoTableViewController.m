 //
//  FlickrPhotoTableViewController.m
//  Flickeri7a5-JJ
//
//  Created by JJ on 11/29/14.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "FlickrPhotoTableViewController.h"
#import "FlickrFetcher.h"
#import "ImageViewController.h"

@interface FlickrPhotoTableViewController ()

@end

@implementation FlickrPhotoTableViewController

-(void) setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSLog(@"photos were set");
    if (photos)
        [self.tableView reloadData]; // refresh tableView cells whenever the photos are refreshed
    else NSLog(@"photos was nil in setPhotos");
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{  //this method is only called from an iPad, so no need to check on which device you're using
    id detail = self.splitViewController.viewControllers[1]; //the detail pane
    [self prepareImageViewController:detail toDisplayPhoto:self.photos[indexPath.row]];
}

#pragma mark - UITableView data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.photos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Photo Details Cell" forIndexPath:indexPath];
    NSDictionary *photo = self.photos[indexPath.row];
    cell.textLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo valueForKeyPath:FLICKR_PHOTO_DESCRIPTION];
    if (!cell.textLabel.text)
        cell.textLabel.text = @"value not found!";
    // Configure the cell...
//    NSLog(@"self.photos count = %lu", (unsigned long)self.photos.count);
//    NSLog(@"I returned a cell in row %ld, col %ld with label %@", (long)indexPath.row, (long)indexPath.section, cell.textLabel.text);
    return cell;
}

#pragma mark - Generic Code

-(void) fetchPhotosForURL:(NSURL *)url
{
    
    //    NSURL *url = [FlickrFetcher URLforTopPlaces];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    /*
     NSData *jsonResults = [NSData dataWithContentsOfURL:url];
     NSDictionary *propertyListResults = [NSJSONSerialization JSONObjectWithData:jsonResults options:0 error:NULL];
     NSLog(@"TopPhotos results: %@", propertyListResults);
     */
    //    NSURLSession *session;
    __block NSDictionary *propertyListResults;
    [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data)
            propertyListResults = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        if (propertyListResults) {
            NSLog(@"TopPhotos results: %@", propertyListResults);
            NSArray *photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PLACES];
            if (!photos) photos = [propertyListResults valueForKeyPath:FLICKR_RESULTS_PHOTOS];
            self.photos = photos;
        }
        else
            NSLog(@"URL request returned nil and the error is %@", connectionError);
    }];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)prepareImageViewController:(ImageViewController *)ivc toDisplayPhoto:(NSDictionary *)photo
{
    ivc.imageURL = [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge];
    NSLog(@"fetching %@", [FlickrFetcher URLforPhoto:photo format:FlickrPhotoFormatLarge]);
    NSLog(@"for photo %@", photo);
    ivc.title = [photo valueForKeyPath:FLICKR_PHOTO_TITLE];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender]; // retrieve indexpath of the sending cell
    if (indexPath)
        if ([segue.identifier isEqualToString:@"Display Photo"])
            if ([segue.destinationViewController isKindOfClass:[ImageViewController class]])
                [self prepareImageViewController:segue.destinationViewController toDisplayPhoto:self.photos[indexPath.row]];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
