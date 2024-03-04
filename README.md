# ppsdk_flutter
Profile Passportのプラグイン。

## 初期化メソッドの実装

### iOS

1. AppDelegateにて以下を追加。

```
func application(_: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool 	{

    //通知機能を実装する場合に、PPSDK起動する前に、OSの通知delegateを登録
    UNUserNotificationCenter.current().delegate = self

    //PPSDKの初期化処理（必須）
    PPSDKManager.shared.initializeSDK(sdkDelegate: self, launchOptions: launchOptions as NSDictionary?)

    return true
}
```

2. info.plistに「ppsdk3_app_auth_key」追加