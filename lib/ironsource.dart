import 'dart:async';

import 'package:flutter/services.dart';

import 'package:ironsource_flutter_ads/models.dart';

import 'Ironsource_consts.dart';

class IronSource {
  static const MethodChannel _channel = MethodChannel("com.karnadi.ironsource");
  static IronSourceListener _listener;
  static IronSourceListener getListener() {
    return _listener;
  }

  static Future<Null> initialize(
      {final String appKey, final IronSourceListener listener}) async {
    _listener = listener;
    _channel.setMethodCallHandler(_listener._handle);
    await _channel.invokeMethod('initialize', {'appKey': appKey});
  }

  static Future<Null> shouldTrackNetworkState(bool state) async {
    await _channel.invokeMethod('shouldTrackNetworkState', {'state': state});
  }

  static Future<Null> validateIntegration() async {
    await _channel.invokeMethod('validateIntegration');
  }

  static Future<Null> setUserId(String userId) async {
    await _channel.invokeMethod('setUserId', {'userId': userId});
  }

  static Future<String> getAdvertiserId() async {
    return await _channel.invokeMethod('getAdvertiserId');
  }

  static Future<Null> loadInterstitial() async {
    await _channel.invokeMethod('loadInterstitial');
  }

  static Future<Null> showInterstitial() async {
    await _channel.invokeMethod('showInterstitial');
  }

  static Future<Null> showRewardedVideol() async {
    await _channel.invokeMethod('showRewardedVideo');
  }

  static Future<Null> activityResumed() async {
    await _channel.invokeMethod('activityResumed');
  }

  static Future<Null> activityPaused() async {
    await _channel.invokeMethod('activityPaused');
  }

  static Future<bool> isRewardedVideoAvailable() async {
    return await _channel.invokeMethod('isRewardedVideoAvailable');
  }
}

abstract class IronSourceListener {
  Future<Null> _handle(MethodCall call) async {
//    Rewarded
    if (call.method == ON_REWARDED_VIDEO_AD_CLICKED)
      onRewardedVideoAdClicked(Placement(
          placementId: call.arguments["placementid"],
          placementName: call.arguments["placementName"],
          rewardAmount: call.arguments["rewardAmount"],
          rewardName: call.arguments["rewardName"]));
    else if (call.method == ON_REWARDED_VIDEO_AD_CLOSED)
      onRewardedVideoAdClosed();
    else if (call.method == ON_REWARDED_VIDEO_AD_ENDED)
      onRewardedVideoAdEnded();
    else if (call.method == ON_REWARDED_VIDEO_AD_OPENED)
      onRewardedVideoAdOpened();
    else if (call.method == ON_REWARDED_VIDEO_AD_REWARDED)
      onRewardedVideoAdRewarded(Placement(
          placementId: call.arguments["placementid"],
          placementName: call.arguments["placementName"],
          rewardAmount: call.arguments["rewardAmount"],
          rewardName: call.arguments["rewardName"]));
    else if (call.method == ON_REWARDED_VIDEO_AD_SHOW_FAILED)
      onRewardedVideoAdShowFailed(
        IronSourceError(
            errorCode: call.arguments["errorCode"],
            errorMessage: call.arguments["errorMessage"]),
      );
    else if (call.method == ON_REWARDED_VIDEO_AVAILABILITY_CHANGED)
      onRewardedVideoAvailabilityChanged(call.arguments);
    else if (call.method == ON_REWARDED_VIDEO_AD_STARTED)
      onRewardedVideoAdStarted();
  }

  //  Rewarded video
  void onRewardedVideoAdOpened();

  void onRewardedVideoAdClosed();

  void onRewardedVideoAvailabilityChanged(bool available);

  void onRewardedVideoAdStarted();

  void onRewardedVideoAdEnded();

  void onRewardedVideoAdRewarded(Placement placement);

  void onRewardedVideoAdShowFailed(IronSourceError error);

  void onRewardedVideoAdClicked(Placement placement);
}
