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
        self->locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        if (@available(iOS 8.0, *)) {
            [self->locationManager requestWhenInUseAuthorization];
        } else {
            // Fallback on earlier versions
        }
        [self->locationManager startUpdatingLocation];
        
        if([CLLocationManager headingAvailable] == YES)
        {
            [self->locationManager startUpdatingHeading];
        }
        else
        {
            if (self->logLevel > 0) {
                NSLog(@"Heading isn't available");
            }
        }
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
    self->currentLocation = [locations lastObject];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    self->heading = newHeading.magneticHeading;
}

RCT_EXPORT_METHOD(getData:(RCTResponseSenderBlock) cb) {
   
    if (self->logLevel > 0) {
        //NSLog(<#NSString * _Nonnull format, ...#>);
    }

    cb(@[[NSNull null], @{
                 @"heading" : [NSNumber numberWithFloat: self->heading],
                 @"long" : [NSNumber numberWithDouble: self->currentLocation.coordinate.longitude],
                 @"lat" : [NSNumber numberWithDouble: self->currentLocation.coordinate.latitude],
                 @"altitude": [NSNumber numberWithDouble: self->currentLocation.altitude]
             }]
       );
}


@end
