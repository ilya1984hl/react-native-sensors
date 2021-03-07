//
//  Compass.m
//  RNSensors
//
//  Created by M on 04/03/2021.
//

#import "Compass.h"
#import "Utils.h"

@interface Compass() <CLLocationManagerDelegate> {
    float heading;
    CLLocation *currentLocation;
    CLLocationManager *locationManager;
    int logLevel;
}

@end

@implementation Compass

@synthesize bridge = _bridge;

RCT_EXPORT_MODULE();

- (id) init {
    self = [super init];
    NSLog(@"Compass");

    if (self) {
        self->locationManager = [[CLLocationManager alloc] init];
        self->locationManager.delegate = self;
        self->logLevel = 0;
    }
    return self;
}

+ (BOOL)requiresMainQueueSetup
{
    return NO;
}

RCT_EXPORT_METHOD(setLogLevel:(int) level) {
    if (level > 0) {
        NSLog(@"setLogLevel: %d", level);
    }

    self->logLevel = level;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    currentLocation = [locations lastObject];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    heading = newHeading.magneticHeading;
}

RCT_EXPORT_METHOD(getData:(RCTResponseSenderBlock) cb) {
   
    if (self->logLevel > 0) {
        //NSLog(<#NSString * _Nonnull format, ...#>);
    }

    cb(@[[NSNull null], @{
                 @"heading" : [NSNumber numberWithFloat: self->heading],
                 @"long" : [NSNumber numberWithDouble: self->locationManager.location.coordinate.longitude],
                 @"lat" : [NSNumber numberWithDouble: self->locationManager.location.coordinate.latitude],
                 @"altitude": [NSNumber numberWithDouble: self->locationManager.location.altitude]
             }]
       );
}


@end
