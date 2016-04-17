//
//  APNotificationCenterProtocol.h
//  ObservePattern
//
//  Created by LV on 16/4/10.
//  Copyright © 2016年 Wieye. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APNotificationCenterProtocol <NSObject>

- (void)subscriptionMessage:(id)message subscriptionName:(NSString *)subscriptionName;

@end
