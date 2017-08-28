//
//  RSThreadSafeDictionary.h
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSThreadSafeDictionary;

typedef void(^RSThreadSafeDictionaryBlock)(RSThreadSafeDictionary *dict, id key, id object);

@interface RSThreadSafeDictionary : NSObject

@property (nonatomic, strong) NSMutableDictionary *dict;
@property (nonatomic, strong) dispatch_queue_t concurrent_queue;

- (void)objectForKey:(id)aKey block:(RSThreadSafeDictionaryBlock)block;
- (void)setObject:(id)anObject forKey:(id)aKey block:(RSThreadSafeDictionaryBlock)block;

@end
