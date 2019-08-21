//
//  ViewController.m
//  PopAction
//
//  Created by Jiawei Dong on 2019/8/20.
//  Copyright © 2019 Jiawei Dong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *but = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [but setTitle:@"123123123" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
}
- (IBAction)action:(id)sender {
    ViewController *newObj = [ViewController new];
    [self.navigationController pushViewController:newObj animated:YES];
}

- (void)loadView{
    NSLog(@"123");
    [super loadView];
}


@end
