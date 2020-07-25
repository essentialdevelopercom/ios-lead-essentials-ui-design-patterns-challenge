//
// Copyright © 2020 Essential Developer. All rights reserved.
//

import UIKit

final class FeedErrorViewController: NSObject, FeedErrorView {
    @IBOutlet var view: ErrorView?

    func display(_ viewModel: FeedErrorViewModel) {
        view?.show(message: viewModel.message)
    }
}
