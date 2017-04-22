//
//  secondViewController.m
//  Pay-hub
//
//  Created by RSTI E-Services on 22/04/17.
//  Copyright © 2017 RSTI E-Services. All rights reserved.
//

#import "secondViewController.h"

@interface secondViewController ()
- (IBAction)CencelButton:(UIButton *)sender;


@end

@implementation secondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.opaque = YES;
    //self.view.backgroundColor = [UIColor lightGrayColor];
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

- (IBAction)CencelButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
