
// PPNoticeDelegate 通知イベントを処理したい時に、実装

extension AppDelegate: PPNoticeDelegate {

    //プッシュ通知前確認

    /// - Returns: プッシュ通知　継続:true、中止:false

    func noticeWillPush(notice: PPNotice) -> Bool {

	// do something

        return true;

    }



    //通知クリック時確認

    /// - Returns: クリックされた通知のURLへの処理　継続:true、中止:false

    func noticeDidClick(notice: PPNotice) -> Bool {

	// do something

        return true;

    }

}