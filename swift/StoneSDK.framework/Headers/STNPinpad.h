//
//  STNPinpadProvider.h
//  StoneSDK
//
//  Created by Jaison Vieira on 25/08/17.
//  Copyright © 2017 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNPinpad : NSObject

@property (nonatomic, readonly, strong) NSString *name;
@property (nonatomic, readonly, strong) NSString *identifier;
@property (nonatomic, strong) NSString *alias;

@property (nonatomic, readonly, retain) id device;

-(instancetype)initWithDevice:(id)device;

@end
