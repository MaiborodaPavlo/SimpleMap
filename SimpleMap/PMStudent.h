//
//  PMStudent.h
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

typedef enum {
    PMGenderMale,
    PMGenderFemale
} PMGender;

@interface PMStudent : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (assign, nonatomic) NSDate *dateOfBirthday;
@property (assign, nonatomic) PMGender gender;

@property (assign, nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@property (strong, nonatomic) UIImage *image;

@property (assign, nonatomic) double distance;

+ (PMStudent *) randomStudent;

@end
