//
//  MyprofileViewController.m
//  Pay-hub
//
//  Created by RSTI E-Services on 22/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

#import "MyprofileViewController.h"
#import "secondViewController.h"

@interface MyprofileViewController ()

@end

@implementation MyprofileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    secondViewController *modalViewController = [[secondViewController alloc] init];
    modalViewController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [self presentViewController:modalViewController animated:YES completion:nil];
    
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
