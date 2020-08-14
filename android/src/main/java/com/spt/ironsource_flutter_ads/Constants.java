package com.spt.ironsource_flutter_ads;

 class Constants {

  static final String INIT = "initialize";
  static final String LOAD_INTERSTITIAL = "loadInterstitial";
  static final String SHOW_INTERSTITIAL = "showInterstitial";
  static final String IS_INTERSTITIAL_READY = "isInterstitialReady";


  static final String MAIN_CHANNEL = "com.spt.ironsource";
  static final String BANNER_CHANNEL = MAIN_CHANNEL + "/bannerAd";
  static final String INTERSTITIAL_CHANNEL = MAIN_CHANNEL + "/interstitialAd";

  //    Interstitial Listener
  static final String INTERSTITIAL_OPENED = "onInterstitialAdOpened";
  static final String INTERSTITIAL_READY = "onInterstitialAdReady";
  static final String INTERSTITIAL_CLOSED = "onInterstitialAdClosed";
  static final String INTERSTITIAL_LOAD_FAILED = "onInterstitialAdLoadFailed";
  static final String INTERSTITIAL_SHOW_FAILED = "onInterstitialAdShowFailed";
  static final String INTERSTITIAL_SHOW_SUCCEEDED = "onInterstitialAdShowSucceeded";
  static final String INTERSTITIAL_CLICKED = "onInterstitialAdClicked";

  //    Listener
  static final String ON_REWARDED_VIDEO_AD_OPENED = "onRewardedVideoAdOpened";
  static final String ON_REWARDED_VIDEO_AD_CLOSED = "onRewardedVideoAdClosed";
  static final String ON_REWARDED_VIDEO_AVAILABILITY_CHANGED = "onRewardedVideoAvailabilityChanged";
  static final String ON_REWARDED_VIDEO_AD_STARTED = "onRewardedVideoAdStarted";
  static final String ON_REWARDED_VIDEO_AD_ENDED = "onRewardedVideoAdEnded";
  static final String ON_REWARDED_VIDEO_AD_REWARDED = "onRewardedVideoAdRewarded";
  static final String ON_REWARDED_VIDEO_AD_SHOW_FAILED = "onRewardedVideoAdShowFailed";
  static final String ON_REWARDED_VIDEO_AD_CLICKED = "onRewardedVideoAdClicked";

  // Banner listener const
  static final String BANNER_LOADED = "onBannerAdLoaded";
  static final String BANNER_CLICKED = "onBannerAdClicked";
  static final String BANNER_SCREEN_PRESENTED = "onBannerAdScreenPresented";
  static final String BANNER_SCREEN_DISMISSED = "onBannerAdScreenDismissed";
  static final String BANNER_LEFT_APPLICATION = "onBannerAdLeftApplication";
  static final String BANNER_LOAD_FAILED = "onBannerAdLoadFailed";

}
