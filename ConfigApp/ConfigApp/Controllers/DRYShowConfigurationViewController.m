//
//  DRYShowConfigurationViewController.m
//  ConfigApp
//
//  Created by Michael Seghers on 24/02/14.
//  Copyright (c) 2014 Michael Seghers. All rights reserved.
//

#import "DRYShowConfigurationViewController.h"

@interface DRYShowConfigurationViewController ()

@end

@implementation DRYShowConfigurationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    UILabel *valueFromConfigurationFileLabel = [[UILabel alloc] init];
    valueFromConfigurationFileLabel.translatesAutoresizingMaskIntoConstraints = NO;
    valueFromConfigurationFileLabel.text = [self readValueFromConfigurationFile];
    valueFromConfigurationFileLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:valueFromConfigurationFileLabel];

    
    NSDictionary *views = NSDictionaryOfVariableBindings(valueFromConfigurationFileLabel);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[valueFromConfigurationFileLabel]-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[valueFromConfigurationFileLabel]-|" options:0 metrics:nil views:views]];
    
}
    
- (NSString *) readValueFromConfigurationFile {
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"Configuration" ofType:@"plist"];
    NSDictionary *configDictionary = [NSDictionary dictionaryWithContentsOfFile:configPath];
    return configDictionary[@"configParameter"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
