//
//  main.m
//  weatherForecast
//
//  Created by 堀之内英典 on 2015/03/30.
//  Copyright (c) 2015年 堀之内英典. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    int retVal;
    @autoreleasepool {
#ifdef DEBUG
        @try{
#endif
            retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
#ifdef DEBUG
        }
        @catch (NSException *exception){
            NSLog(@"%@",[exception callStackSymbols]);
            @throw exception;
        }
#endif
        //return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    return retVal;
}
