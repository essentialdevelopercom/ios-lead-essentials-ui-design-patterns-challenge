
import Foundation
import FeedFeature

protocol FeedRefreshView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

final class FeedRefreshPresenter {
    private let refreshView: FeedRefreshView
    private let errorView: FeedErrorView
    
    init(refreshView: FeedRefreshView, errorView: FeedErrorView) {
        self.refreshView = refreshView
        self.errorView = errorView
    }
    
    func didStartLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: true))
        errorView.display(FeedErrorViewModel(errorMessage: nil))
    }
    
    func didFinishLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        refreshView.display(FeedLoadingViewModel(isLoading: false))
        errorView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
    }
}
