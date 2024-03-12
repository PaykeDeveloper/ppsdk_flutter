package jp.co.payke.ppsdk_flutter.ppsdk_flutter

class PPSDKFirebaseMessagingService : FirebaseMessagingService() {

    override fun onMessageReceived(remoteMessage: RemoteMessage) {
        super.onMessageReceived(remoteMessage)
        if (PPNoticeManager.onMessageReceived(this, remoteMessage)) {

        // PPSDK3以外の通知
        } else {
        }
    }

    override fun onDeletedMessages() {
        Log.d("PPSDK機能", "onDeletedMessages")
        PPNoticeManager.onDeletedMessages(applicationContext)
    }

    override fun onMessageSent(s: String) {
        Log.d("PPSDK機能", "onMessageSent")
        PPNoticeManager.onMessageSent(s, applicationContext)
    }

    override fun onSendError(s: String, e: Exception) {
        Log.d("PPSDK機能", "onSendError")
        PPNoticeManager.onSendError(s, e, applicationContext)
    }

    override fun onNewToken(s: String) {
        Log.d("PPSDK機能", "onNewToken")
        //【PPSDKメソッド】SDK側のデバイストークンを更新
        PPNoticeManager.onNewToken(applicationContext)
    }

    // 通知表示前確認メッセージ処理
    // 【引数】
    // context: Context?
    // notice: PPNotice・・・通知情報
    // channel String・・・通知チャンネル名
    // 【返り値】
    // Boolean・・・通知表示処理継続フラグ
    // true:SDK側で通知表示処理が必要, false:SDK側で通知表示処理が不要
    override fun noticeWillPush(context: Context?, notice: PPNotice, channel: String?): Boolean {
        // 通知情報
        Log.d("PPSDK機能", "通知受信(通知データ): ${notice.data}")
        Log.d("PPSDK機能", "通知受信(通知ID): ${notice.id}")
        Log.d("PPSDK機能", "通知受信(通知メッセージ): ${notice.message}")
        Log.d("PPSDK機能", "通知受信(通知タイトル): ${notice.title}")
        Log.d("PPSDK機能", "通知受信(通知URL): ${notice.url}")

        return true
    }

    // 通知タップ時確認メッセージ処理
    // 【引数】
    // context: Context?
    // notice: PPNotice・・・通知情報
    // 【返り値】
    // Boolean・・・通知に含まれるURLへの処理継続フラグ
    // true:SDK側で通知に含まれるURLへの処理が必要, false:SDK側で通知に含まれるURLへの処理が不要
    override fun noticeDidClick(context: Context?, notice: PPNotice): Boolean {

        // 通知情報
        Log.d("PPSDK機能", "通知タップ(通知データ): ${notice.data}")
        Log.d("PPSDK機能", "通知タップ(通知ID): ${notice.id}")
        Log.d("PPSDK機能", "通知タップ(通知メッセージ): ${notice.message}")
        Log.d("PPSDK機能", "通知タップ(通知タイトル): ${notice.title}")
        Log.d("PPSDK機能", "通知タップ(通知URL): ${notice.url}")

        return true

    }
}