package jp.co.payke.mobile.ppsdk_flutter

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** PPSDKFlutterPlugin */
class PPSDKFlutterPlugin: FlutterPlugin, MethodCallHandler {

  enum class PPSDKMethods(val method: String) {
    STARTPPSDK("startPPSDK"),
    SERVICESTOP("serviceStop"),
    SETGEOSERVICEENABLED("setGeoServiceEnabled"),
    UPDATELOCATIONANDCHECKIN("updateLocationAndCheckIn"),
    SETBEACONSERVICEENABLED("setBeaconServiceEnabled"),
    //GETBEACONSERVICEENABLED("getBeaconServiceEnabled"),
    GETPPUID("getPPUID"),
    REGISTERUSERSEGMENT("registerUserSegment"),
    GETUSERSEGMENTWITHKEY("getUserSegmentWithKey"),
    GETALLUSERSEGMENTS("getAllUserSegments"),
    CLEARALLUSERSEGMENT("clearAllUserSegment"),
    SETPUSHMEMBERID("setPushMemberId"),
    GETPUSHMEMBERID("getPushMemberId"),
    SETLOGLINKID("setLogLinkId"),
    GETDEVICETOKEN("getDeviceToken"),
    SHOWUSERINFORMATIONDISCLOSURE("showUserInformationDisclosure")
  }

  private lateinit var channel : MethodChannel
  private lateinit var activity : Activity
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ppsdk_flutter")
    channel.setMethodCallHandler(this)

    // contextを取得
    applicationContext = flutterPluginBinding.applicationContext
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    val method = PPSDKMethods.valueOf(call.method);
    when(method) {
      PPSDKMethods.STARTPPSDK -> startPPSDK(call.arguments as Map<String, Object>)
      PPSDKMethods.SERVICESTOP -> serviceStop()
      PPSDKMethods.SETGEOSERVICEENABLED -> setGeoServiceEnabled(call.arguments as Boolean)
      PPSDKMethods.UPDATELOCATIONANDCHECKIN -> updateLocationAndCheckIn()
      PPSDKMethods.SETBEACONSERVICEENABLED -> setBeaconServiceEnabled(call.arguments as Boolean)
      //PPSDKMethods.GETBEACONSERVICEENABLED -> getBeaconServiceEnabled()
      PPSDKMethods.GETPPUID -> getPPUID()
      PPSDKMethods.REGISTERUSERSEGMENT -> registerUserSegment(call.arguments["key"] as String, call.arguments["value"] as String)
      PPSDKMethods.GETUSERSEGMENTWITHKEY -> getUserSegmentWithKey(call.arguments as String)
      PPSDKMethods.GETALLUSERSEGMENTS -> getAllUserSegments()
      PPSDKMethods.CLEARALLUSERSEGMENT -> clearAllUserSegment()
      PPSDKMethods.SETPUSHMEMBERID -> setPushMemberId(call.arguments as String)
      PPSDKMethods.GETPUSHMEMBERID -> getPushMemberId()
      PPSDKMethods.SETLOGLINKID -> setLogLinkId(call.arguments as String)
      PPSDKMethods.GETDEVICETOKEN -> getDeviceToken()
    }
    // if (call.method == "getPlatformVersion") {
    //   result.success("Android ${android.os.Build.VERSION.RELEASE}")
    // } else {
    //   result.notImplemented()
    // }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }
  
  fun startPPSDK(startOption: Map<String, Object>): Boolean {
    PPSDKManager.sharedManager(applicationContext).serviceStart(this, startOption){	code, message ->
      Log.d("PPSDK機能", "PPSDKサービス起動結果 code:$code, message:$message")
    }
  }

  fun serviceStop() {
    PPSDKManager.sharedManager(applicationContext).serviceStop()
  }

  fun setGeoServiceEnabled(flag: Boolean) {
    // 位置情報サービスを有効にする
    // 下記のメソッドを、ジオサービスの有効・無効を切り替えたいタイミングで呼び出してください。
    // applicationContext : Application Context
    // flag : true(起動), false(停止)
    PPSDKManager.sharedManager(applicationContext).setGeoServiceFlag(flag)
  }

  fun updateLocationAndCheckIn() {
    // 位置情報を更新してチェックインする
    //activity : メソッドを実装したActivityクラス
    //option : チェックイン制御用パラメータを設定するオプション ※未実装のためnull
    PPSDKManager.sharedManager(applicationContext).updateLocationAndCheckIn(this, null)
    { code, message, result ->
        Log.d("PPSDK機能","チェックイン結果 code: ${code}, message:${message}, result:${result}")
      if(null != result) {
        Log.d("PPSDK機能", "チェックイン位置情報: ${result.location}")

        for (inGeo in result.inGeoList) {
          Log.d("PPSDK機能", "チェックインジオ情報(ジオID): ${inGeo.geoId}")
          Log.d("PPSDK機能", "チェックインジオ情報(ジオ名): ${inGeo.geoName}")
          Log.d("PPSDK機能", "チェックインジオ情報(ジオ状態): ${inGeo.geoState}")
          Log.d("PPSDK機能", "チェックインジオ情報(ジオチェックイン時間): ${inGeo.geoCheckInTime}")
          Log.d("PPSDK機能", "チェックインジオ情報(ジオ種別): ${inGeo.geoKind}")
          Log.d("PPSDK機能", "チェックインジオ情報(中心点座標 ※サークルのみ): ${inGeo.centerCoordinate}")
          Log.d("PPSDK機能", "チェックインジオ情報(半径 ※サークルのみ): ${inGeo.geoRadius}")
          Log.d("PPSDK機能", "チェックインジオ情報(頂点座標配列 ※ポリゴンのみ): ${inGeo.apexCoordinates}")
          Log.d("PPSDK機能", "チェックインジオ情報(ジオタグリスト): ${inGeo.geoTags}")
        }
      }
    }
  }

  fun setBeaconServiceEnabled(flag: Boolean) {
    // ビーコンサービスを有効にする
    // 下記のメソッドを、ビーコンサービスの有効・無効を切り替えたいタイミングで呼び出してください。
    // applicationContext : Application Context
    // flag : true(起動), false(停止)
    PPSDKManager.sharedManager(applicationContext).setBeaconServiceFlag(flag)
  }


  // fun getBeaconServiceEnabled() {
  //   // ビーコンサービスの有効状態を取得する
  // }

  fun getPPUID() {
    PPSDKManager.sharedManager(applicationContext).getPPUUID()
  }

  fun registerUserSegment(key: String, value: String) {
    PPSDKManager.sharedManager(applicationContext).setUserSegmentWithKey(key, value)
  }

  fun getUserSegmentWithKey(key: String) {
    PPSDKManager.sharedManager(applicationContext).getUserSegmentWithKey(key)
  }

  fun getAllUserSegments(): Map<String, String> {
    return PPSDKManager.sharedManager(applicationContext).getUserSegmentHash()
  }

  fun clearAllUserSegment() {
    PPSDKManager.sharedManager(applicationContext).clearUserSegment()
  }

  fun setPushMemberId(pushMemberId: String) {
    PPSDKManager.sharedManager(applicationContext).setPushMemberId(pushMemberId)
  }

  fun getPushMemberId(): String {
    return PPSDKManager.sharedManager(applicationContext).getPushMemberId()
  }

  fun setLogLinkId(logLinkId: String) {
    PPSDKManager.sharedManager(applicationContext).setLogLinkId(logLinkId)
  }

  // androidのみ
  fun getDeviceToken() {
    return PPSDKManager.sharedManager(applicationContext).getDeviceToken()
  }

  /// SDK利用による個別情報開示の同意を得る際、以下の処理を記述します。
  /// 下記のメソッドを、SDK開始前に呼び出してください。
  /// controller : 表示元コントローラ
  /// type : 個別情報開示表示タイプ(PP3CUserInformationDisclosureType)
  ///    webView     : webView画面表示
  ///    dialog      : ダイアログ画面表示
  ///    lowerHalf   : 下半分画面表示
  /// option : 条件
  /// callback: コールバック
  fun showUserInformationDisclosure() {
    PPSDKManager.sharedManager(activity.applicationContext).showUserInformationDisclosure(activity, PP3CUserInformationDisclosureType.WebView, HashMap()){
      // 個別情報開示画面クローズ後の処理
    }
  }
}
