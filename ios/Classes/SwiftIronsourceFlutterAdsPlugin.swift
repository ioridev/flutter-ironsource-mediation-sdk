import Flutter
import UIKit

public class SwiftIronsourceFlutterAdsPlugin: NSObject, FlutterPlugin {
    enum Method: String {
        case initialize
        case getAdvertiserId
        case activityResumed
        case activityPaused
        case validateIntegration
        case setUserId
        case isRewardedVideoAvailable
        case showRewardedVideo
    }

    var defaultChannel = FlutterMethodChannel()

    private var delegate = IronSourceRewardedAdDelegate()
    private var hasRewardedVideo: Bool?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let instance = SwiftIronsourceFlutterAdsPlugin()
        instance.defaultChannel = FlutterMethodChannel(name: "com.karnadi.ironsource", binaryMessenger: registrar.messenger())
        
        registrar.addMethodCallDelegate(instance, channel: instance.defaultChannel)

        registrar.register(
            IronSourceBannerFactory(messeneger: registrar.messenger()),
            withId: "com.karnadi.ironsource/banner"
        )
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let method = Method(rawValue: call.method) else {
            result(FlutterMethodNotImplemented)
            return
        }

        switch method {
            case .initialize:
                if let dictionary = call.arguments as? [String: Any], let appKey = dictionary["appKey"] as? String {
                    self.delegate = IronSourceRewardedAdDelegate(methodChannel: defaultChannel)
                    IronSource.setRewardedVideoDelegate(delegate)
                    ISSupersonicAdsConfiguration.configurations()?.useClientSideCallbacks = true
                    IronSource.initWithAppKey(appKey, adUnits: [IS_REWARDED_VIDEO, IS_BANNER, IS_INTERSTITIAL])
                }
                result(true)
            
            case .getAdvertiserId:
                result(IronSource.advertiserId())
            
            case .activityResumed:
                // IronSource iOS SDK には該当するメソッドがないため実装は無し
                result(true)
            
            case .activityPaused:
                // IronSource iOS SDK には該当するメソッドがないため実装は無し
                result(true)
            
            case .validateIntegration:
                ISIntegrationHelper.validateIntegration()
                result(true)
            
            case .setUserId:
                if let dictionary = call.arguments as? [String: Any], let userID = dictionary["userId"] as? String {
                    IronSource.setUserId(userID)
                }
                result(true)
            
            case .isRewardedVideoAvailable:
                result(hasRewardedVideo ?? IronSource.hasRewardedVideo())
            
            case .showRewardedVideo:
                if let viewController = UIApplication.shared.keyWindow?.rootViewController {
                    IronSource.showRewardedVideo(with: viewController)
                }
                result(true)
        }
    }
}
