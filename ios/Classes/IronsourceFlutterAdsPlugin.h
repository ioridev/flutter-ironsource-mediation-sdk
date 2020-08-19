#import "Flutter/Flutter.h"
#import <IronSource/IronSource.h>

@interface IronsourceFlutterAdsPlugin : NSObject<FlutterPlugin, ISRewardedVideoDelegate>
@property (nonatomic, strong) FlutterMethodChannel *methodChannel;
@property (nonatomic) bool hasRewardedVideo;
@end
