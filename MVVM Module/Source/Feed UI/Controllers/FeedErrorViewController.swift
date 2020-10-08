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
        viewModel?.onErrorStateChange = { [weak self] message in
            if let message = message {
                self?.view?.show(message: message)
            }
        }
    }
}
