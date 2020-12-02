
import Foundation
import FeedFeature

protocol FeedRefreshView {
    func display(_ viewModel: FeedLoadingViewModel)
}

final class FeedRefreshPresenter {
    private let refreshView: FeedRefreshView
    
    init(refreshView: FeedRefreshView) {
        self.refreshView = refreshView
    }
    
    func didStartLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: true, errorMessage: nil))
    }
    
    func didFinishLoadingFeed() {
        refreshView.display(FeedLoadingViewModel(isLoading: false, errorMessage: nil))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        refreshView.display(FeedLoadingViewModel(isLoading: false, errorMessage: Localized.Feed.loadError))
    }
}
