
import UIKit
import FeedFeature


final class FeedErrorViewController: NSObject, FeedErrorView {
    
    @IBOutlet var view: ErrorView?
    
    func display(_ viewModel: FeedErrorViewModel) {
        if let errorMessage = viewModel.errorMessage {
            view?.show(message: errorMessage)
        } else {
            view?.hideMessage()
        }
    }
    
}
