import 'dart:async';

import 'package:flutter/services.dart';
import 'package:ironsource_flutter_ads/android/model.dart';
import 'Ironsource_consts.dart';
export 'ironsource_banner.dart';

class IronSource {
  static const MethodChannel _channel = MethodChannel("com.spt.ironsource");
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

  static Future<Null> validateIntegration() async {
    await _channel.invokeMethod('validateIntegration');
  }

  static Future<Null> loadInterstitial() async {
    await _channel.invokeMethod('loadInterstitial');
  }

  static Future<Null> showInterstitial() async {
    await _channel.invokeMethod('showInterstitial');
  }

  static Future<bool> isInterstitialReady() async {
    return await _channel.invokeMethod('isInterstitialReady');
  }

  static Future<Null> activityResumed() async {
    await _channel.invokeMethod('onResume');
  }

  static Future<Null> activityPaused() async {
    await _channel.invokeMethod('onPause');
  }
}

abstract class IronSourceListener {
  Future<Null> _handle(MethodCall call) async {
    if (call.method == INTERSTITIAL_CLICKED)
      onInterstitialAdClicked();
    else if (call.method == INTERSTITIAL_CLOSED)
      onInterstitialAdClosed();
    else if (call.method == INTERSTITIAL_OPENED)
      onInterstitialAdOpened();
    else if (call.method == INTERSTITIAL_READY)
      onInterstitialAdReady();
    else if (call.method == INTERSTITIAL_SHOW_SUCCEEDED)
      onInterstitialAdShowSucceeded();
    else if (call.method == INTERSTITIAL_LOAD_FAILED)
      onInterstitialAdLoadFailed(IronSourceError(
          errorCode: call.arguments["errorCode"],
          errorMessage: call.arguments["errorMessage"]));
    else if (call.method == INTERSTITIAL_SHOW_FAILED)
      onInterstitialAdShowFailed(IronSourceError(
          errorCode: call.arguments["errorCode"],
          errorMessage: call.arguments["errorMessage"]));

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

  void onInterstitialAdClicked();

  void onInterstitialAdReady();

  void onInterstitialAdLoadFailed(IronSourceError error);

  void onInterstitialAdOpened();

  void onInterstitialAdClosed();

  void onInterstitialAdShowSucceeded();

  void onInterstitialAdShowFailed(IronSourceError error);

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
