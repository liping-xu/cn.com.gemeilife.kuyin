//
//  Context.h
//  Afanti
//
//  Created by JDY on 15/6/25.
//  Copyright (c) 2015年 52aft.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Context : NSObject
@property (nonatomic,assign)BOOL      isLogin;
@property (nonatomic,strong)NSArray *handicap;//盘口(5档)
@property (nonatomic, strong) NSMutableArray *conditionArray;
+(Context *)sharedInstance;
@end
