//
//  UIView+MKAnnotationView.m
//  SimpleMap
//
//  Created by Pavel on 02.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "UIView+MKAnnotationView.h"
#import <MapKit/MKAnnotationView.h>

@implementation UIView (MKAnnotationView)

- (MKAnnotationView *) superAnnotationView {
    
    if ([self isKindOfClass: [MKAnnotationView class]]) {
        return (MKAnnotationView *)self;
    }
    
    if (!self.superview) {
        return nil;
    }
    
    return [self.superview superAnnotationView];
    
}

@end
