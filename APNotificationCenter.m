//
//  APNotificationCenter.m
//  ObservePattern
//
//  Created by LV on 16/4/10.
//  Copyright © 2016年 Wieye. All rights reserved.
//

#import "APNotificationCenter.h"
#import "APNotificationCenterProtocol.h"

static APNotificationCenter * _apNotificationCenter       = nil;
static NSMutableDictionary  * _subscriptionNameDictionary = nil;

@implementation APNotificationCenter

#pragma mark -
#pragma mark - Observer Pattern 

- (void)addObserve:(id <APNotificationCenterProtocol>)observer subscriptionName:(NSString *)name
{
    NSParameterAssert(observer);
    NSParameterAssert(name);
    
    NSHashTable * hashTable = [self existSubscriptionName:name];
    
    if (hashTable == nil)
    {
        hashTable = [NSHashTable weakObjectsHashTable];
        [_subscriptionNameDictionary setObject:hashTable forKey:name];
    }
    
    [hashTable addObject:observer];
}

- (void)removeObserve:(id <APNotificationCenterProtocol>)observer subscriptionName:(NSString *)name
{
    NSParameterAssert(observer);
    NSParameterAssert(name);
    
    NSHashTable * hashTable = [self existSubscriptionName:name];
    if (hashTable)
    {
        [_subscriptionNameDictionary removeObjectForKey:name];
    }
}

- (void)postData:(id)data toSubscriptionName:(NSString *)name
{
    NSParameterAssert(data);
    NSParameterAssert(name);
    
    NSHashTable * hasTable = [self existSubscriptionName:name];
    if (hasTable)
    {
        NSEnumerator * enumerator = [hasTable objectEnumerator];
        id <APNotificationCenterProtocol> customer = nil;
        while (customer = [enumerator nextObject])
        {
            if ([customer respondsToSelector:@selector(subscriptionMessage:subscriptionName:)])
            {
                [customer subscriptionMessage:data subscriptionName:name];
            }
        }
    }
}

//!> private method

- (NSHashTable *)existSubscriptionName:(NSString *)subscriptionName
{
    return [_subscriptionNameDictionary objectForKey:subscriptionName];
}

#pragma mark -
#pragma mark - Singleton Setting

- (id)init
{
    [NSException raise:@"APNotificationCenter"
                format:@"Cannot using init method to initlizate a APNotificationCenter Singleton"];
    
    return nil;
}

- (id)copyWithZone:(NSZone *)zone
{
    [NSException raise:@"APNotificationCenter"
                format:@"Cannot using Copy method to initlizate a APNotificationCenter Singleton"];
    
    return nil;
}

- (id)initInstance
{
    return [super init];
}

+ (APNotificationCenter *)defaultCenter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _apNotificationCenter       = [[APNotificationCenter alloc] initInstance];
        _subscriptionNameDictionary = [NSMutableDictionary dictionary];
    });
    return _apNotificationCenter;
}

@end
