

import UIKit

protocol NoInternetViewContainer {
    func showNoInternetView()
    func removeNoInternetView()
}

extension NoInternetViewContainer where Self: UIViewController {
    var viewTag: Int { return 42 }
    func showNoInternetView() {
        removeNoInternetView()
        let view = NoInternetView(frame: self.view.frame)
        view.tag = viewTag
        self.view.addSubview(view)
    }
    func removeNoInternetView() {
        self.view.viewWithTag(viewTag)?.removeFromSuperview()
    }
}
