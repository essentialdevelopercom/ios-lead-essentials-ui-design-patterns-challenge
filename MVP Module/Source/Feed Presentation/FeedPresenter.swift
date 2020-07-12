//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
    private let errorView: FeedErrorView
	
	init(feedView: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
        self.errorView = errorView
	}

	static var title: String {
		return NSLocalizedString("FEED_VIEW_TITLE",
			tableName: "Feed",
			bundle: Bundle(for: FeedPresenter.self),
			comment: "Title for the feed view")
	}
    
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
        let message = NSLocalizedString("LOADING_FEED_ERROR_MESSAGE",
                                        tableName: "Feed",
                                        bundle: Bundle(for: FeedPresenter.self),
                                        comment: "Error message when feed load fails")
        
        loadingView.display(FeedLoadingViewModel(isLoading: false))
        errorView.display(FeedErrorViewModel(message: message))
	}
}
