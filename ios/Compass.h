//
//  Compass.h
//  RNSensors
//
//  Created by M on 04/03/2021.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

NS_ASSUME_NONNULL_BEGIN

@interface Compass : RCTEventEmitter <RCTBridgeModule> {
}

- (void) isAvailableWithResolver:(RCTPromiseResolveBlock) resolve
         rejecter:(RCTPromiseRejectBlock) reject;
- (void) setLogLevel:(int) level;
- (void) getData:(RCTResponseSenderBlock) cb;
- (void) startUpdates;
- (void) stopUpdates;

@end

NS_ASSUME_NONNULL_END
