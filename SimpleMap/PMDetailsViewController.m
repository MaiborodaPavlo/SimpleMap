//
//  PMDetailsViewController.m
//  SimpleMap
//
//  Created by Pavel on 02.02.2018.
//  Copyright © 2018 Pavel Maiboroda. All rights reserved.
//

#import "PMDetailsViewController.h"

@interface PMDetailsViewController ()

@end

@implementation PMDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UITableViewCell *cell in self.infoCollection) {
        
        if ([cell.textLabel.text isEqualToString: @"Name"]) {
            cell.detailTextLabel.text = self.name;
        } else if ([cell.textLabel.text isEqualToString: @"Gender"]) {
            cell.detailTextLabel.text = self.gender;
        } else {
            cell.detailTextLabel.text = self.birth;
        }
    }
    
    for (UITableViewCell *cell in self.addressCollection) {
        
        if ([cell.textLabel.text isEqualToString: @"Country"]) {
            cell.detailTextLabel.text = self.country;
        } else if ([cell.textLabel.text isEqualToString: @"City"]) {
            cell.detailTextLabel.text = self.city;
        } else {
            if (self.address != NULL) {
                cell.detailTextLabel.text = self.address;
            } else {
                cell.detailTextLabel.text = @"Address not found";
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
