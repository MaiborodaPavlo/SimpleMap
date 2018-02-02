//
//  UIView+MKAnnotationView.h
//  SimpleMap
//
//  Created by Pavel on 02.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MKAnnotationView;

@interface UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView;

@end
