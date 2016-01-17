//
//  ViewController.m
//  MapMyPoints
//
//  Created by Omar Faruqe on 2016-01-16.
//  Copyright © 2016 Omar Faruqe. All rights reserved.
//
#import "MapKit/MapKit.h"
#import "ViewController.h"

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) MKPointAnnotation *cuswgAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *ubcAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *uoftAnnotaion;
@property (strong, nonatomic) MKPointAnnotation *currentAnnotation;
@property (weak, nonatomic) IBOutlet UISwitch *switchField;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL mapIsMoving;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.locationManager = [[CLLocationManager alloc]init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.mapIsMoving = NO;
    [self addAnnotaions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)luciTapped:(id)sender {
    [self centerMap:self.cuswgAnnotaion];
}
- (IBAction)wiclTapped:(id)sender {
    [self centerMap:self.ubcAnnotaion];
}
- (IBAction)gradientTapped:(id)sender {
    [self centerMap:self.uoftAnnotaion];
}
- (IBAction)switchChanged:(id)sender {
    if(self.switchField.isOn) {
        self.mapView.showsUserLocation = YES;
        [self.locationManager startUpdatingLocation];
    }
    else {
        self.mapView.showsUserLocation = NO;
        [self.locationManager stopUpdatingLocation];
        
    }
    
}

- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    self.currentAnnotation.coordinate = locations.lastObject.coordinate;
    
    if (self.mapIsMoving == NO) {
        [self centerMap:self.currentAnnotation];
    }

    
}
- (void) centerMap: (MKPointAnnotation *) centerPoint {
    [self.mapView setCenterCoordinate:centerPoint.coordinate animated:YES];
}
- (void) addAnnotaions {
    self.cuswgAnnotaion = [[MKPointAnnotation alloc] init];
    self.cuswgAnnotaion.coordinate = CLLocationCoordinate2DMake(45.4937771,-73.5861662);
    self.cuswgAnnotaion.title = @"Concordia University, SGW Campus, Montreal, QC, CA";
    
    self.ubcAnnotaion = [[MKPointAnnotation alloc] init];
    self.ubcAnnotaion.coordinate = CLLocationCoordinate2DMake(49.2606052,-123.2481826);
    self.ubcAnnotaion.title = @"The University of British Columbia, Vancouver, BC, CA";
    
    self.uoftAnnotaion = [[MKPointAnnotation alloc] init];
    self.uoftAnnotaion.coordinate = CLLocationCoordinate2DMake(43.5478681,-79.6631328);
    self.uoftAnnotaion.title = @"University of Toronto, Mississauga Campus, ON, CA";
    
    self.currentAnnotation = [[MKPointAnnotation alloc] init];
    self.currentAnnotation.coordinate = CLLocationCoordinate2DMake(0, 0);
    self.currentAnnotation.title = @"My Location";
    
    [self.mapView addAnnotations:@[self.cuswgAnnotaion, self.ubcAnnotaion, self.uoftAnnotaion]];
    
}

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
        self.mapIsMoving = NO;
}

@end
