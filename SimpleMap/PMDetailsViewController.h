//
//  PMDetailsViewController.h
//  SimpleMap
//
//  Created by Pavel on 02.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PMDetailsViewController : UITableViewController

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *gender;
@property (strong, nonatomic) NSString *birth;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *address;


@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *infoCollection;
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *addressCollection;

@end
