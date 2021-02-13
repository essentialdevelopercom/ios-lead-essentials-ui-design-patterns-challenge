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
    func display(_ errorViewModel: FeedErrorViewModel)
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
        feedErrorView.display(FeedErrorViewModel(message: .none))
		loadingView.display(FeedLoadingViewModel(isLoading: true))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
        feedErrorView.display(FeedErrorViewModel(message: Localized.Feed.errorMessage))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
