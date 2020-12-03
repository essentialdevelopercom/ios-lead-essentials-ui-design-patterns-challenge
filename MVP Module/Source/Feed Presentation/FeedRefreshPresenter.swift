
import Foundation
import FeedFeature

protocol FeedRefreshView {
    func display(_ viewModel: FeedLoadingViewModel)
    func display(_ viewModel: FeedErrorViewModel)
}

final class FeedRefreshPresenter {
    private let refreshView: FeedRefreshView
    
    init(refreshView: FeedRefreshView) {
        self.refreshView = refreshView
    }
    
    func didStartLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: true))
        refreshView.display(FeedErrorViewModel(errorMessage: nil))
    }
    
    func didFinishLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        refreshView.display(FeedLoadingViewModel(isLoading: false))
        refreshView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
    }
}
