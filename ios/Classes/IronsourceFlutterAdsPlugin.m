#import "IronsourceFlutterAdsPlugin.h"

@implementation IronsourceFlutterAdsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    IronsourceFlutterAdsPlugin *instance = [[IronsourceFlutterAdsPlugin alloc] init];
    instance.methodChannel = [FlutterMethodChannel methodChannelWithName:@"com.karnadi.ironsource" binaryMessenger: registrar.messenger];
    [registrar addMethodCallDelegate:instance channel:instance.methodChannel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSString *callMethod = call.method;
    if ([@"initialize" isEqualToString: call.method]) {
        NSString *appKey = call.arguments[@"appKey"];
        [IronSource setRewardedVideoDelegate:self];
        [[ISSupersonicAdsConfiguration configurations] setUseClientSideCallbacks:@YES];
        [IronSource initWithAppKey:appKey adUnits:@[IS_REWARDED_VIDEO]];
        result(@YES);
    } else if ([@"getAdvertiserId" isEqualToString:callMethod]) {
        result([IronSource advertiserId]);
    } else if ([@"activityResumed" isEqualToString:callMethod]) {
        // IronSource iOS SDK には該当するメソッドがないため実装は無し
        result(@YES);
    } else if ([@"activityPaused" isEqualToString:callMethod]) {
        // IronSource iOS SDK には該当するメソッドがないため実装は無し
        result(@YES);
    } else if ([@"validateIntegration" isEqualToString:callMethod]) {
        [ISIntegrationHelper validateIntegration];
        result(@YES);
    } else if ([@"setUserId" isEqualToString:callMethod]) {
        NSString *userID = call.arguments[@"userId"];
        [IronSource setUserId:userID];
        result(@YES);
    } else if ([@"isRewardedVideoAvailable" isEqualToString:callMethod]) {
        NSNumber *hasRewardedVideo = [NSNumber numberWithBool:self.hasRewardedVideo];
        if (hasRewardedVideo != nil) {
            result(hasRewardedVideo);
        } else {
            result([NSNumber numberWithBool:[IronSource hasRewardedVideo]]);
        }
    }
    else if ([@"showRewardedVideo" isEqualToString:callMethod]) {
        UIViewController *viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
        if (viewController != nil) {
            [IronSource showRewardedVideoWithViewController:viewController];
            result(@YES);
            return;
        }
        
        result(@NO);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

#pragma mark - ISRewardedVideoDelegate
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
        self.hasRewardedVideo = available;
        [self.methodChannel invokeMethod:@"onRewardedVideoAvailabilityChanged" arguments: [NSNumber numberWithBool:available]];
    });
}

@end
