//
//  ViewController.m
//  CYLDispatchSemaphoreTest
//
//  Created by http://weibo.com/luohanchenyilong/ (微博@iOS程序犭袁) on 15/9/6.
//  Copyright (c) 2015年 https://github.com/ChenYilong . All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1ull * NSEC_PER_SEC);//等待一秒
    //dispatch_time_t time = DISPATCH_TIME_FOREVER;//永久等待
    NSLog(@"begin==");
    /*
     *
     如果 semphore 的值等于0，就阻塞1秒钟，才会往下照常进行；
     如果大于等于1则往下进行并将 semphore 进行减1处理。
     *
     */
    long result = dispatch_semaphore_wait(semaphore, time);
    if (result == 0) {
        /*
         *
         *由子Dispatch Semaphore的计数值达到大于等于1
         *或者在待机中的指定时间内
         *Dispatch Semaphore的计数值达到大于等于1
         所以Dispatch Semaphore的计数值减去1
         可执行需要进行排他控制的处理
         *
         */
        NSLog(@"result == 0 ==>not time out");
        dispatch_semaphore_signal(semaphore);//使用signal以确保编译器release掉dispatch_semaphore_t时的值与初始值一致， 否则会EXC_BAD_INSTRUCTION ,见http://is.gd/EaJgk5
    } else {
        /*
         *
         *由于Dispatch Semaphore的计数值为0
         .因此在达到指定时间为止待机
         *
         */
        NSLog(@"result != 0 ==> timeout");
        
    }
}

@end
