//
// Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit

final class FeedErrorViewController: NSObject {
    @IBOutlet var view: ErrorView?
    
    var viewModel: FeedViewModel? {
        didSet { bind() }
    }

    private func bind() {
        viewModel?.onFeedFailed = { [weak self] message in
            self?.view?.show(message: message)
        }
    }
}
