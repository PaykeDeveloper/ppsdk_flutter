package jp.co.payke.mobile.ppsdk_flutter


class PPSDKGeoReceiver : PPGEOReceiver() {
    //ジオ検知イベント受信処理
    //【引数】
    // context: Context?
    // geoInfo: PPGEOResult・・・ジオ検知情報
    //【返り値】
    // Boolean・・・ローカル通知継続フラグ
    // true:ローカル通知処理を行う, false:ローカル通知処理を行わない
    override fun onGeoEvent(context: Context?, geoInfo: PPGEOResult): Boolean {

        //ジオ検知情報
        Log.d("PPSDK機能","ジオ検知(ジオID): ${geoInfo.geoId}")
        Log.d("PPSDK機能","ジオ検知(ジオ名): ${geoInfo.geoName}")
        Log.d("PPSDK機能","ジオ検知(イベント): ${geoInfo.geoEvent.value}")

        for(tag in geoInfo.geoTags){
            Log.d("PPSDK機能","ジオタグ(タグID): ${tag.geoTagId}")
            Log.d("PPSDK機能","ジオタグ(タグ名): ${tag.geoTagName}")
            Log.d("PPSDK機能","ジオタグ(タグイベント): ${tag.geoTagEvent}")
        }
        return true
    }
}