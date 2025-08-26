//
//  Context.m
//  Afanti
//
//  Created by JDY on 15/6/25.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import "Context.h"
static Context *shared;
@implementation Context
@synthesize isLogin,handicap;
+(Context *)sharedInstance
{
    @synchronized(self){
        if (!shared) {
            shared = [[Context alloc]init];
            shared.conditionArray = [[NSMutableArray alloc] init];
        }
    }
    return shared;
}
@end
