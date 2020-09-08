//
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit

class FeedErrorViewController: NSObject {
    @IBOutlet weak var view: ErrorView?
    
    var viewModel: FeedViewModel? {
        didSet { bind() }
    }
    
    func hideError() {
        view?.hideMessage()
    }
    
    private func bind() {
        viewModel?.onFeedFailed = { [weak self] message in
            self?.view?.show(message: message)
        }
    }
}
