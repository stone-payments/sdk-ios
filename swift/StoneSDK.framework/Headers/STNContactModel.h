//
//  STNContactModel.h
//  StoneSDK
//
//  Created by Tatiana Magdalena on 05/12/17.
//  Copyright © 2017 Stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STNContactModel : NSObject

/// Contact name.
@property (nonatomic,strong) NSString *name;
/// Email address.
@property (nonatomic,strong) NSString *address;

@end
