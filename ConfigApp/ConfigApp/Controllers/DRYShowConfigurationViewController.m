//
//  DRYShowConfigurationViewController.m
//  ConfigApp
//
//  Created by Michael Seghers on 24/02/14.
//  Copyright (c) 2014 Michael Seghers. All rights reserved.
//

#import "DRYShowConfigurationViewController.h"

@interface DRYShowConfigurationViewController () {
    NSDictionary *_infoDictionary;
}
    
@end

@implementation DRYShowConfigurationViewController
    
- (id)init {
    self = [super init];
    if (self) {
        _infoDictionary = [[NSBundle mainBundle] infoDictionary];
    }
    return self;
}
    
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
    
- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UILabel *valueFromConfigurationFileLabel = [self createInfoLabel];
    valueFromConfigurationFileLabel.text = [self readValueFromConfigurationFile];
    UILabel *appVersionLabel = [self createInfoLabel];
    appVersionLabel.text = [NSString stringWithFormat:@"App bundle version: %@", _infoDictionary[@"CFBundleVersion"]];
    UILabel *bundleIdLabel = [self createInfoLabel];
    bundleIdLabel.text = [NSString stringWithFormat:@"App bundle identifier: %@", _infoDictionary[@"CFBundleIdentifier"]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(valueFromConfigurationFileLabel, appVersionLabel, bundleIdLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[valueFromConfigurationFileLabel]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[appVersionLabel]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[bundleIdLabel]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[valueFromConfigurationFileLabel]-[appVersionLabel]-[bundleIdLabel]-|" options:0 metrics:nil views:views]];
    
#if defined (CONFIGURATION_AdHoc) || defined (CONFIGURATION_Debug)
    self.view.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:0.5];
#endif
    
}
    
- (UILabel *) createInfoLabel {
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentCenter;
    label.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label];
    return label;
}
    
- (NSString *) readValueFromConfigurationFile {
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"Configuration" ofType:@"plist"];
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:path];
    return config[@"configParameter"];
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
    
@end
