//
//  SplitViewController.m
//  Flickeri7a5-JJ
//
//  Created by JJ on 12/28/14.
//  Copyright (c) 2014 JJ. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController () <UISplitViewControllerDelegate>
@property (assign) id <UISplitViewControllerDelegate> delegate;
@end

@implementation SplitViewController

-(void)awakeFromNib
{
    self.delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)splitViewController:(UISplitViewController *)svc shouldHideViewController:(UIViewController *)vc inOrientation:(UIInterfaceOrientation)orientation
{
    return NO;
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
