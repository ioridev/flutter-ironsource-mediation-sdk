#import "IronsourceFlutterAdsPlugin.h"
#import <ironsource_flutter_ads-Swift.h>

@implementation IronsourceFlutterAdsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [SwiftIronsourceFlutterAdsPlugin registerWithRegistrar:registrar];
    [IronsourceIntersitialPlugin registerWithRegistrar: registrar];
}
@end

@implementation IronSourceRewardedAdDelegate

- (id)initWithMethodChannel:(FlutterMethodChannel *)methodChannel {
    self = [super init];
    self.methodChannel = methodChannel;

    return self;
}

- (void)didClickRewardedVideo:(ISPlacementInfo *)placementInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
         [self.methodChannel invokeMethod:@"onRewardedVideoAdClicked" arguments: @{@"placementId": @"", @"placementName": [placementInfo placementName], @"rewardAmount": [placementInfo rewardAmount], @"rewardName": [placementInfo rewardName] }];
    });
}

- (void)didReceiveRewardForPlacement:(ISPlacementInfo *)placementInfo {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdRewarded" arguments: @{@"placementId": @"", @"placementName": [placementInfo placementName], @"rewardAmount": [placementInfo rewardAmount], @"rewardName": [placementInfo rewardName] }];
    });
}

- (void)rewardedVideoDidClose {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdClosed" arguments: nil];
    });
}

- (void)rewardedVideoDidEnd {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdEnded" arguments: nil];
    });
}

- (void)rewardedVideoDidFailToShowWithError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdShowFailed" arguments: @{@"errorCode": [NSNumber numberWithLong: [error code]], @"errorMessage": [error localizedDescription], @"info": [error userInfo]}];
    });
}

- (void)rewardedVideoDidOpen {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdOpened" arguments: nil];
    });
}

- (void)rewardedVideoDidStart {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAdStarted" arguments: nil];
    });
}

- (void)rewardedVideoHasChangedAvailability:(BOOL)available {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.methodChannel invokeMethod:@"onRewardedVideoAvailabilityChanged" arguments: [NSNumber numberWithBool:available]];
    });
}

@end
