//
//  ViewController.m
//  SpinnerDamo
//
//  Created by Maulik on 17/07/18.
//  Copyright © 2018 ligro. All rights reserved.
//

#import "ViewController.h"
#import "SpinnerView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:[SpinnerView SharedInstant]];
//    [[SpinnerView CurrentInstant] setSpinData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
