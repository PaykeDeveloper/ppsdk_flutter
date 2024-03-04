// PPBeaconDelegate ビーコンイベントをアプリ側で処理をしたいときに実装
extension AppDelegate : PPBeaconDelegate {

    // ビーコン検知イベント受信処理

    // 【引数】

    // beaconInfo: PPBeaconResult・・・ビーコン検知情報

    //【返り値】

    // Bool・・・通知処理の継続判定

    // true:ローカル通知処理を行う, false:ローカル通知処理を行わない

    func onBeaconEvent(beaconInfo: PPBeaconResult) -> Bool {

        // アプリ側で実装する

        return true

    }

}