
import Foundation
import FeedFeature

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

final class FeedErrorPresenter {
    private let errorView: FeedErrorView
    
    init(errorView: FeedErrorView) {
        self.errorView = errorView
    }
    
    func didStartLoadingFeed() {
        errorView.display(FeedErrorViewModel(errorMessage: nil))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        errorView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
    }
}
