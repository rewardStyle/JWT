//
//  JWTDecriptedViewController.h
//  JWTDesktop
//
//  Created by Lobanov Dmitry on 25.09.16.
//  Copyright © 2016 JWT. All rights reserved.
//

@import Cocoa;
@import JWT;

@interface JWTDecriptedViewController : NSViewController

@property (strong, nonatomic, readwrite) JWTBuilder *builder;
@property (strong, nonatomic, readwrite) JWTCodingResultType *resultType;

@end
