#import "Flutter/Flutter.h"
#import "IronSource/IronSource.h"

@interface IronsourceFlutterAdsPlugin : NSObject<FlutterPlugin>
@end

@interface IronSourceRewardedAdDelegate : NSObject<ISRewardedVideoDelegate>
@property (nonatomic, strong) FlutterMethodChannel *methodChannel;
- (id)initWithMethodChannel:(FlutterMethodChannel *)methodChannel;
@end
