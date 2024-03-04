
// PPGEODelegate ジオイベントを処理したい時に、実装
extension AppDelegate: PPGEODelegate {

    //ジオイベント

    /// - Returns : 通知処理する:

    /// true : 通知処理する（通知あればプッシュ、なければなし）

    /// false: 処理しない（通知があっても、プッシュしない）

    func onGeoEvent(geoInfo: PPGEOResult) -> Bool {

	// do something

        return true;

    }

}