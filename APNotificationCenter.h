//
//  APNotificationCenter.h
//  ObservePattern
//
//  Created by LV on 16/4/10.
//  Copyright © 2016年 Wieye. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APNotificationCenterProtocol.h"

@interface APNotificationCenter : NSObject

+ (APNotificationCenter *)defaultCenter;

- (void)addObserve:(id <APNotificationCenterProtocol>)observer subscriptionName:(NSString *)name;

- (void)removeObserve:(id <APNotificationCenterProtocol>)observer subscriptionName:(NSString *)name;

- (void)postData:(id)data toSubscriptionName:(NSString *)name;

@end
