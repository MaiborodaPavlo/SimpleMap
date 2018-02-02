//
//  ViewController.m
//  SimpleMap
//
//  Created by Pavel on 01.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "ViewController.h"
#import "PMStudent.h"
#import <MapKit/MapKit.h>
#import "UIView+MKAnnotationView.h"
#import "PMDetailsViewController.h"
#import "PMMeatingAnnotation.h"

@interface ViewController () <MKMapViewDelegate, UIPopoverPresentationControllerDelegate>

@property (strong, nonatomic) NSMutableArray *studentsArray;
@property (strong, nonatomic) CLGeocoder *geoCoder;

@property (strong, nonatomic) UIPopoverPresentationController *popover;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.studentsArray = [NSMutableArray array];
    NSInteger count = arc4random() % 31 + 10;
    
    for (int i = 0; i < count; i++) {
        [self.studentsArray addObject: [PMStudent randomStudent]];
    }
    
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                               target: self
                                                                               action: @selector(actionAdd:)];
    
    UIBarButtonItem *addMeatingButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                                               target: self
                                                                               action: @selector(actionAddMeating:)];
    
    self.navigationItem.rightBarButtonItems = @[addButton, addMeatingButton];
    
    self.geoCoder = [[CLGeocoder alloc] init];
}

- (void)dealloc
{
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hekp Methods



#pragma mark - Actions

- (void) actionAddMeating: (UIBarButtonItem *) sender {
    
    PMMeatingAnnotation *annotation = [[PMMeatingAnnotation alloc] init];
    
    annotation.title = @"Meating";
    annotation.subtitle = @"Subtitle";
    annotation.coordinate = self.mapView.region.center;
    
    [self.mapView addAnnotation: annotation];
    
}

- (void) actionAdd: (UIBarButtonItem *) sender {
    
    for (PMStudent *student in self.studentsArray) {
        [self.mapView addAnnotation: student];
    }
    
    //ZOOM
    MKMapRect zoomRect = MKMapRectNull;
    
    for (id <MKAnnotation> annotation in self.mapView.annotations) {
        
        CLLocationCoordinate2D location = annotation.coordinate;
        MKMapPoint center = MKMapPointForCoordinate(location);
        
        static double delta = 2000;
        
        MKMapRect rect = MKMapRectMake(center.x - delta, center.y - delta, delta * 2, delta * 2);
        
        zoomRect = MKMapRectUnion(zoomRect, rect);
    }
    
    zoomRect = [self.mapView mapRectThatFits: zoomRect];
    
    [self.mapView setVisibleMapRect: zoomRect
                        edgePadding: UIEdgeInsetsMake(20, 20, 20, 20)
                           animated: YES];
}

- (void) actionDescription: (UIButton *) sender {
    
    MKAnnotationView *annotationView = [sender superAnnotationView];

    if (!annotationView) {
        return;
    }
    
    CLLocationCoordinate2D coordinate = annotationView.annotation.coordinate;
    CLLocation *location = [[CLLocation alloc] initWithLatitude: coordinate.latitude
                                                      longitude: coordinate.longitude];
    
    if ([self.geoCoder isGeocoding]) {
        [self.geoCoder cancelGeocode];
    }
    
    PMDetailsViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier: @"PMDetailsViewController"];
    
    vc.preferredContentSize = CGSizeMake(300, 350);
    vc.modalPresentationStyle = UIModalPresentationPopover;
    self.popover = vc.popoverPresentationController;
    self.popover.delegate = self;
    self.popover.sourceView = sender;
    self.popover.sourceRect = sender.frame;
    
    [self.geoCoder reverseGeocodeLocation: location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
        } else {
            if ([placemarks count] > 0) {
                
                CLPlacemark *placeMark = [placemarks firstObject];
                
                vc.city = [NSString stringWithFormat:@"%@", placeMark.locality];
                vc.country = [NSString stringWithFormat:@"%@", placeMark.country];
                if (placeMark.thoroughfare != NULL && placeMark.subThoroughfare != NULL) {
                    vc.address = [NSString stringWithFormat:@"%@, %@", placeMark.thoroughfare, placeMark.subThoroughfare];
                } else if(placeMark.thoroughfare != NULL) {
                    vc.address = [NSString stringWithFormat:@"%@", placeMark.thoroughfare];
                }
            } else {
                NSLog(@"No Placemarks found");
            }
        }
        
        vc.name = annotationView.annotation.title;
        vc.birth = annotationView.annotation.subtitle;
        
        for (PMStudent *student in self.studentsArray) {
            if ([student isEqual: annotationView.annotation]) {
                vc.gender = student.gender ? @"Female" : @"Male";
            }
        }
        
        [self presentViewController: vc animated: YES completion: nil];
        
    }];
}

#pragma mark - MKMapViewDelegate

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass: [MKUserLocation class]]) {
        return nil;
    } else if ([annotation isKindOfClass: [PMStudent class]]) {
        
        static NSString *identifier = @"Annotation";
        
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: identifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: identifier];
            annotationView.image = [(PMStudent *)annotation image];
            annotationView.canShowCallout = YES;
        } else {
            annotationView.annotation = annotation;
        }
        
        UIButton *descriptionButton = [UIButton buttonWithType: UIButtonTypeDetailDisclosure];
        [descriptionButton addTarget: self action: @selector(actionDescription:) forControlEvents: UIControlEventTouchUpInside];
        annotationView.rightCalloutAccessoryView = descriptionButton;
        
        return annotationView;
    } else {
        
        static NSString *identifier = @"Meating";
        
        MKAnnotationView *annotationView = (MKAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier: identifier];
        
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: identifier];
            annotationView.image = [UIImage imageNamed: @"Images/meating.png"];
            
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    }
}

- (void)mapView:(MKMapView *)mapView annotationView: (MKAnnotationView *) view didChangeDragState:(MKAnnotationViewDragState) newState fromOldState: (MKAnnotationViewDragState) oldState {
    
    if (newState == MKAnnotationViewDragStateEnding) {
        
        [view setDragState: MKAnnotationViewDragStateNone animated: YES];
    }
}

#pragma mark - UIPopoverPresentationControllerDelegate

- (void) popoverPresentationControllerDidDismissPopover: (UIPopoverPresentationController *) popoverPresentationController {
    
    self.popover = nil;
}

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController *) controller {
    
    return UIModalPresentationNone;
}
@end
