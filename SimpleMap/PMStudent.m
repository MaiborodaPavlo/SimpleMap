//
//  PMStudent.m
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMStudent.h"
#import "NSDate+RandomDate.h"

@implementation PMStudent

static NSString *firstManNames[] = {@"Абрам", @"Аваз", @"Августин", @"Авраам", @"Агап", @"Агапит", @"Агафон", @"Адам", @"Адриан", @"Азамат", @"Азат", @"Айдар", @"Айрат", @"Акакий", @"Аким", @"Алан", @"Александр", @"Алексей", @"Али", @"Алик", @"Алихан", @"Алмаз", @"Альберт", @"Амир", @"Амирам", @"Анар", @"Анастасий", @"Анатолий", @"Ангел", @"Андрей", @"Анзор", @"Антон", @"Анфим", @"Арам", @"Аристарх", @"Аркадий", @"Арман", @"Армен", @"Арсен", @"Арсений", @"Арслан", @"Артём", @"Артемий", @"Артур", @"Архип", @"Аскар", @"Асхан", @"Ахмет", @"Ашот", @"Сергей"};

static NSString *firstWomanNames[] = {@"Юнона", @"Ульяна", @"Лариса", @"Эмилия", @"Ника", @"Полина", @"Ефросинья", @"Изольда", @"Каролина", @"Алла", @"Виктория", @"Клара", @"Марта", @"Ксения", @"Лада", @"Дарья", @"Марфа", @"Алиса", @"Таисия", @"Елена", @"Доминика", @"Василиса", @"Лиана", @"Регина", @"Евдокия", @"Лидия", @"Светлана", @"Ярослава", @"Зинаида", @"Арина", @"Стела", @"Розалия", @"Валентина", @"Нина", @"Берта", @"Маргарита", @"Анфиса", @"Дина", @"Рада", @"Анисья", @"Надежда", @"Екатерина", @"Алина", @"Варвара", @"Эльвира", @"Римма", @"Ирина", @"Агния", @"Зоя", @"Софья"};

static NSString *lastManNames[] = {@"Абрамов", @"Авдеев", @"Агафонов", @"Аксёнов", @"Александров", @"Алексеев", @"Андреев", @"Анисимов", @"Антонов", @"Артемьев", @"Архипов", @"Афанасьев", @"Баранов", @"Белов", @"Белозёров", @"Белоусов", @"Беляев", @"Беляков", @"Беспалов", @"Бирюков", @"Блинов", @"Блохин", @"Бобров", @"Бобылёв", @"Богданов", @"Большаков", @"Борисов", @"Брагин", @"Буров", @"Быков", @"Васильев", @"Веселов", @"Виноградов", @"Вишняков", @"Владимиров", @"Власов", @"Волков", @"Воробьёв", @"Воронов", @"Воронцов", @"Гаврилов", @"Галкин", @"Герасимов", @"Голубев", @"Горбачёв", @"Горбунов", @"Гордеев", @"Горшков", @"Григорьев", @"Гришин"};

static NSString *lastWomanNames[] = {@"Салехова", @"Маланова", @"Завражина", @"Другакова", @"Луговая", @"Онегина", @"Ягофарова", @"Ельчукова", @"Усилова", @"Приказчикова", @"Корнейчук", @"Обухова", @"Бичурина", @"Пыжалова", @"Потрепалова", @"Ясырева", @"Зууфина", @"Бибикова", @"Ваенга", @"Яковкина", @"Радченко", @"Ярощука", @"Кирхенштейна", @"Ютилова", @"Кудяева", @"Антимонова", @"Герцая", @"Янкова", @"Семянина", @"Унтилова", @"Коротченко", @"Порсева", @"Салтанова", @"Коржукова", @"Мяукина", @"Маркина", @"Лапина", @"Елизарова", @"Углицкая", @"Деменок", @"Пономарёва", @"Бормотова", @"Кокорина", @"Сафошкина", @"Павленко", @"Чемерис", @"Гусарова", @"Цой", @"Уланова", @"Кудрова"};

static int namesCount = 50;

static double cityLatitude = 49.9808100;
static double cityLongitude = 36.2527200;


+ (PMStudent *) randomStudent {
    
    PMStudent *student = [[PMStudent alloc] init];

    student.dateOfBirthday = [[NSDate new] randomDateForStudent];
    
    student.gender = arc4random() % 2;
    
    if (student.gender) {
        student.image = [UIImage imageNamed:@"Images/woman_30.png"];
        student.firstName = firstWomanNames[arc4random() % namesCount];
        student.lastName = lastWomanNames[arc4random() % namesCount];

    } else {
        student.image = [UIImage imageNamed:@"Images/man_30.png"];
        student.firstName = firstManNames[arc4random() % namesCount];
        student.lastName = lastManNames[arc4random() % namesCount];
    }
    
    CLLocationCoordinate2D randomCoordinate;
    
    if (arc4random() % 2) {
        randomCoordinate.latitude = cityLatitude + (arc4random() % 1000001) / 100000000.f;
        randomCoordinate.longitude = cityLongitude + (arc4random() % 1000001) / 100000000.f;
    } else {
        randomCoordinate.latitude = cityLatitude - (arc4random() % 1000001) / 100000000.f;
        randomCoordinate.longitude = cityLongitude - (arc4random() % 1000001) / 100000000.f;
    }
    
    student.coordinate = randomCoordinate;
    student.title = [NSString stringWithFormat: @"%@ %@", student.firstName, student.lastName];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle: NSDateFormatterShortStyle];
    student.subtitle = [dateFormatter stringFromDate: student.dateOfBirthday];
    
    return student;
}

@end
