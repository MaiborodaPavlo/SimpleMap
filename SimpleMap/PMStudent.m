//
//  PMStudent.m
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMStudent.h"

@implementation PMStudent

static NSString *firstNames[] = {@"Абрам", @"Аваз", @"Августин", @"Авраам", @"Агап", @"Агапит", @"Агафон", @"Адам", @"Адриан", @"Азамат", @"Азат", @"Айдар", @"Айрат", @"Акакий", @"Аким", @"Алан", @"Александр", @"Алексей", @"Али", @"Алик", @"Алихан", @"Алмаз", @"Альберт", @"Амир", @"Амирам", @"Анар", @"Анастасий", @"Анатолий", @"Ангел", @"Андрей", @"Анзор", @"Антон", @"Анфим", @"Арам", @"Аристарх", @"Аркадий", @"Арман", @"Армен", @"Арсен", @"Арсений", @"Арслан", @"Артём", @"Артемий", @"Артур", @"Архип", @"Аскар", @"Асхан", @"Ахмет", @"Ашот", @"Сергей"};

static NSString *lastNames[] = {@"Абрамов", @"Авдеев", @"Агафонов", @"Аксёнов", @"Александров", @"Алексеев", @"Андреев", @"Анисимов", @"Антонов", @"Артемьев", @"Архипов", @"Афанасьев", @"Баранов", @"Белов", @"Белозёров", @"Белоусов", @"Беляев", @"Беляков", @"Беспалов", @"Бирюков", @"Блинов", @"Блохин", @"Бобров", @"Бобылёв", @"Богданов", @"Большаков", @"Борисов", @"Брагин", @"Буров", @"Быков", @"Васильев", @"Веселов", @"Виноградов", @"Вишняков", @"Владимиров", @"Власов", @"Волков", @"Воробьёв", @"Воронов", @"Воронцов", @"Гаврилов", @"Галкин", @"Герасимов", @"Голубев", @"Горбачёв", @"Горбунов", @"Гордеев", @"Горшков", @"Григорьев", @"Гришин"};

static int namesCount = 50;

static double cityLatitude = 49.9808100;
static double cityLongitude = 36.2527200;


+ (PMStudent *) randomStudent {
    
    PMStudent *student = [[PMStudent alloc] init];
    
    student.firstName = firstNames[arc4random() % namesCount];
    student.lastName = lastNames[arc4random() % namesCount];
    
    CLLocationCoordinate2D randomCoordinate;
    
    if (arc4random() % 2) {
        randomCoordinate.latitude = cityLatitude + (arc4random() % 1000001) / 1000000.f + arc4random() % 11;
        randomCoordinate.longitude = cityLongitude + (arc4random() % 1000001) / 1000000.f + arc4random() % 11;
    } else {
        randomCoordinate.latitude = cityLatitude - (arc4random() % 1000001) / 1000000.f - arc4random() % 11;
        randomCoordinate.longitude = cityLongitude - (arc4random() % 1000001) / 1000000.f - arc4random() % 11;
    }
    
    student.coordinate = randomCoordinate;
    
    return student;
    
}

@end
