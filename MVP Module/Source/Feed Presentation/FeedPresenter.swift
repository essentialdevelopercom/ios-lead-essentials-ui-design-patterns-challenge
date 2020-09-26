//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView: FeedErrorView {
	func display(_ viewModel: FeedViewModel)
}

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
    
    private var errorMessage: String {
        Localized.Feed.loadError
    }
	
	init(feedView: FeedView, loadingView: FeedLoadingView) {
		self.feedView = feedView
		self.loadingView = loadingView
	}
    
	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
        feedView.display(FeedErrorViewModel(errorMessage: nil))
	}
	
	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
	
	func didFinishLoadingFeed(with error: Error) {
        feedView.display(FeedErrorViewModel(errorMessage: errorMessage))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
