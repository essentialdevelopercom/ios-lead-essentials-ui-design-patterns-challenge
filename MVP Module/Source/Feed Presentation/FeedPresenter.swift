//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedErrorView {
    func display(error: String?)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
    private let feedErrorView: FeedErrorView
	
    init(feedView: FeedView, loadingView: FeedLoadingView, feedErrorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
        self.feedErrorView = feedErrorView
	}
    
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
        feedErrorView.display(error: .none)
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
		loadingView.display(FeedLoadingViewModel(isLoading: false))
        feedErrorView.display(error: Localized.Feed.errorMessage)
	}
}
