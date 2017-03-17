//
//  XBPZIconFontOCViewController.m
//  iOSDiversityCollection
//
//  Created by YamonMac2 on 17/3/17.
//  Copyright © 2017年 xiaobengpeizhang. All rights reserved.
//

#import "XBPZIconFontOCViewController.h"

@interface XBPZIconFontOCViewController ()

@end

@implementation XBPZIconFontOCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 200, 300, 30)];
    label.text = @"\U0000f023";
    label.font = [UIFont fontWithName:@"FontAwesome"
                                 size:24.0];
    [self.view addSubview:label];
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
