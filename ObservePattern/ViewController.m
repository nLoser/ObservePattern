//
//  ViewController.m
//  ObservePattern
//
//  Created by LV on 16/4/10.
//  Copyright © 2016年 Wieye. All rights reserved.
//

#import "ViewController.h"
#import "APNotificationCenter.h"

@interface ViewController ()<APNotificationCenterProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[APNotificationCenter defaultCenter] addObserve:self subscriptionName:@"MABI"];
    [[APNotificationCenter defaultCenter] postData:@[@"这个社会是咋啦",@"你说呢"] toSubscriptionName:@"MABI"];
    
    
}

- (void)subscriptionMessage:(id)message subscriptionName:(NSString *)subscriptionName
{
    NSLog(@"%@ - %@",message,subscriptionName);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
