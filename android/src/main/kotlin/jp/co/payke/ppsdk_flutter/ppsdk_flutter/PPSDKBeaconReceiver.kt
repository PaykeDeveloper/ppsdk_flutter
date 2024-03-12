
package jp.co.payke.mobile.ppsdk_flutter



class PPSDKBeaconReceiver: PPBeaconReceiver() {
    // ビーコン検知イベント受信処理
    // 【引数】
    // context: Context
    // beaconInfo: PPBeaconResult・・・ビーコン検知情報
    //【返り値】
    // Boolean・・・ローカル通知継続フラグ
    // true:ローカル通知処理を行う, false:ローカル通知処理を行わない
    override fun onBeaconEvent(context: Context, beaconInfo: PPBeaconResult): Boolean {
        //ビーコン検知情報
        Log.d("PPSDK機能","ビーコン検知(ビーコンID): ${beaconInfo.beaconId}")
        Log.d("PPSDK機能","ビーコン検知(ビーコン名): ${beaconInfo.beaconName}")
        Log.d("PPSDK機能","ビーコン検知(UUID): ${beaconInfo.beaconUuid}")
        Log.d("PPSDK機能","ビーコン検知(Major): ${beaconInfo.beaconMajor}")
        Log.d("PPSDK機能","ビーコン検知(Minor): ${beaconInfo.beaconMinor}")
        Log.d("PPSDK機能","ビーコン検知(電波強度): ${beaconInfo.beaconRssi}")
        Log.d("PPSDK機能","ビーコン検知(イベント): ${beaconInfo.beaconEvent.value}")
        Log.d("PPSDK機能","ビーコン検知(滞在時間): ${beaconInfo.beaconDwellTime}")
        Log.d("PPSDK機能","ビーコン検知(検知開始日時): ${beaconInfo.beaconAtTime}")
        Log.d("PPSDK機能","ビーコン検知(検知最終更新日時): ${beaconInfo.beaconLastUpdateTime}")
        Log.d("PPSDK機能","ビーコン検知(座標): ${beaconInfo.beaconCoordinate}")

        for(tag in beaconInfo.beaconTags) {
            Log.d("PPSDK機能","ビーコンタグ(タグID): ${tag.beaconTagId}")
            Log.d("PPSDK機能","ビーコンタグ(タグ名): ${tag.beaconTagName}")
            Log.d("PPSDK機能","ビーコンタグ(タグイベント): ${tag.beaconTagEvent.value}")
            Log.d("PPSDK機能","ビーコンタグ(タグ滞在時間): ${tag.beaconTagDwellTime}")
            Log.d("PPSDK機能","ビーコンタグ(タグ開始時間): ${tag.beaconTagAtTime}")
            Log.d("PPSDK機能","ビーコンタグ(タグ検知最終更新日時): ${tag.beaconTagLastUpdateTime}")

        }
        return true
    }
}