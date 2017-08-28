//
//  RSGCDTest.m
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSThreadSafeDictionary.h"

@interface RSGCDTest : XCTestCase

@property (nonatomic, strong) dispatch_queue_t serial_queue;
@property (nonatomic, strong) dispatch_queue_t concurrent_queue;

@end

@implementation RSGCDTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    self.serial_queue = dispatch_queue_create("com.serial_queue.rs", DISPATCH_QUEUE_SERIAL);
    self.concurrent_queue = dispatch_queue_create("com.concurrent_queue.rs", DISPATCH_QUEUE_CONCURRENT);
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

#pragma mark - dispatch_async & dispatch_sync

- (void)test_serial_async {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSInteger count = 10;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (NSInteger idx = 0; idx < count; idx++) {
        // dispatch_async 执行串行队列中的任务时，总是使用同一个异步线程
        dispatch_async(self.serial_queue, ^{
            NSLog(@"index: %@", @(idx));
            NSLog(@"current thread: %@", [NSThread currentThread]);
            dispatch_semaphore_signal(sem);
        });
    }
    for (NSInteger idx = 0; idx < count; idx++) {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
    NSLog(@"Running on main thread");
}

- (void)test_concurrent_async {
    NSInteger count = 10;
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (NSInteger idx = 0; idx < count; idx++) {
        // dispatch_async 执行并行队列中的任务时，每次都会开辟一个新的线程（开辟的线程总量是有限制的）
        dispatch_async(self.concurrent_queue, ^{
            NSLog(@"index: %@", @(idx));
            NSLog(@"current thread: %@", [NSThread currentThread]);
            dispatch_semaphore_signal(sem);
        });
    }
    for (NSInteger idx = 0; idx < count; idx++) {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
    NSLog(@"Running on main thread");
}

- (void)test_current_thread {
    dispatch_async(self.serial_queue, ^{
        NSLog(@"dispatch_async serial_queue - thread: %@", [NSThread currentThread]);
    });
    
    dispatch_sync(self.serial_queue, ^{
        NSLog(@"dispatch_sync serial_queue - thread: %@", [NSThread currentThread]);
    });
    
    NSLog(@"Running on main thread: %@", [NSThread currentThread]);
}

- (void)test_priority {
    dispatch_queue_t serialDispatchQueue=dispatch_queue_create("com.test.queue", NULL);
    dispatch_queue_t dispatchgetglobalqueue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
    dispatch_set_target_queue(serialDispatchQueue, dispatchgetglobalqueue);
    dispatch_async(serialDispatchQueue, ^{
        NSLog(@"我优先级低，先让让");
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"我优先级高,我先block");
    });
}

- (void)test_suspend_resume {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(self.concurrent_queue, ^{
        for (int i=0; i<100; i++)
        {
            NSLog(@"%i",i);
            if (i==50)
            {
                NSLog(@"-----------------------------------");
                dispatch_suspend(self.concurrent_queue);
                sleep(3);
                dispatch_async(dispatch_get_main_queue(), ^{
                    dispatch_resume(self.concurrent_queue);
                });
            }
            dispatch_semaphore_signal(sem);
        }
    });
    
    for (NSInteger idx = 0; idx < 100; idx++) {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
}

#pragma mark - dispatch_barrier

- (void)test_barrier {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    for (NSInteger idx = 0; idx < 10; idx++) {
        dispatch_async(self.concurrent_queue, ^{
            NSLog(@"index: %@", @(idx));
        });
    }
    
    for (NSInteger idx = 0; idx < 10000; idx++) {
        dispatch_barrier_async(self.concurrent_queue, ^{
            if (idx == 10000 - 1) {
                NSLog(@"barrier finished");
                NSLog(@"current thread: %@", [NSThread currentThread]);
            }
        });
    }
    
    NSLog(@"Running on main thread");
    
    for (NSInteger idx = 10; idx < 20; idx++) {
        dispatch_async(self.concurrent_queue, ^{
            NSLog(@"index: %@", @(idx));
            dispatch_semaphore_signal(sem);
        });
    }
    for (NSInteger idx = 0; idx < 10; idx++) {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
}

#pragma mark - thread safe

- (void)test_unsafe_dict {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dispatch_async(self.concurrent_queue, ^{
        for (NSInteger idx = 0; idx < 1000; idx++) {
            dict[@(idx)] = @(idx);
        }
        dispatch_semaphore_signal(sem);
    });
    dispatch_async(self.concurrent_queue, ^{
        for (NSInteger idx = 0; idx < 1000; idx++) {
            dict[@(idx)] = @(1);
        }
        dispatch_semaphore_signal(sem);
    });
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
}

- (void)test_safe_dict {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    RSThreadSafeDictionary *dict = [[RSThreadSafeDictionary alloc] init];
    for (NSInteger idx = 0; idx < 10; idx++) {
        [dict setObject:@(idx) forKey:@(idx) block:^(RSThreadSafeDictionary *dict, id key, id object) {
            NSLog(@"loop a - set %@ for key: %@", object, key);
            [dict objectForKey:key block:^(RSThreadSafeDictionary *dict, id key, id object) {
                NSLog(@"loop a-sub - dict[%@] = %@", key, object);
                dispatch_semaphore_signal(sem);
            }];
            dispatch_semaphore_signal(sem);
        }];
    }
    for (NSInteger idx = 0; idx < 10; idx++) {
        [dict objectForKey:@(idx) block:^(RSThreadSafeDictionary *dict, id key, id object) {
            NSLog(@"loop middle - dict[%@] = %@", key, object);
            dispatch_semaphore_signal(sem);
        }];
    }
    for (NSInteger idx = 0; idx < 10; idx++) {
        [dict setObject:@(1) forKey:@(idx) block:^(RSThreadSafeDictionary *dict, id key, id object) {
            NSLog(@"loop b - set 1 for key: %@", key);
            [dict objectForKey:key block:^(RSThreadSafeDictionary *dict, id key, id object) {
                NSLog(@"loop b-sub - dict[%@] = %@", key, object);
                dispatch_semaphore_signal(sem);
            }];
            dispatch_semaphore_signal(sem);
        }];
    }
    for (NSInteger idx = 0; idx < 50; idx++) {
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    }
    NSLog(@"dict: %@", dict.dict);
}

#pragma mark - semaphore

- (void)test_concurrent_limit {
    NSInteger count = 50;
    NSInteger maxConcurrentCount = 8;
    dispatch_semaphore_t g_sem = dispatch_semaphore_create(0);
    dispatch_semaphore_t sem = dispatch_semaphore_create(maxConcurrentCount);
    for (NSInteger idx = 0; idx < count; idx++) {
        [self addTaskWithSemaphore:sem complete:^{
            NSLog(@"task %@ complete", @(idx));
            dispatch_semaphore_signal(g_sem);
        }];
    }
    for (NSInteger idx = 0; idx < count; idx++) {
        dispatch_semaphore_wait(g_sem, DISPATCH_TIME_FOREVER);
    }
}

- (void)addTaskWithSemaphore:(dispatch_semaphore_t)sem complete:(void(^)(void))complete {
    dispatch_async(self.concurrent_queue, ^{
        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
        sleep(2);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            complete();
            dispatch_semaphore_signal(sem);
        });
    });
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
