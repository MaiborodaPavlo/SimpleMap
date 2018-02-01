//
//  PMStudent.h
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocation.h>

@interface PMStudent : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

+ (PMStudent *) randomStudent;

@end
