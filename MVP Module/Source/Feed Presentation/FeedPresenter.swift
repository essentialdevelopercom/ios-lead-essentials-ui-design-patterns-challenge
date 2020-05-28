//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
    private let feedView: FeedView
    private let errorView: FeedErrorView
    private let loadingView: FeedLoadingView
    
    init(feedView: FeedView, errorView: FeedErrorView, loadingView: FeedLoadingView) {
        self.feedView = feedView
        self.errorView = errorView
        self.loadingView = loadingView
    }
    
    static var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
             tableName: "Feed",
             bundle: Bundle(for: FeedPresenter.self),
             comment: "Title for the feed view")
    }
        
    private var feedLoadError: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR",
             tableName: "Feed",
             bundle: Bundle(for: FeedPresenter.self),
             comment: "Error message displayed when we can't load the image feed from the server")
    }

    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        errorView.display(FeedErrorViewModel(message: feedLoadError))
        loadingView.display(FeedLoadingViewModel(isLoading: false))
    }
}
