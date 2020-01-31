//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void

    private let feedLoader: FeedLoader

    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var title: String {
        return NSLocalizedString("FEED_VIEW_TITLE",
                                 tableName: "Feed",
                                 bundle: Bundle(for: FeedViewModel.self),
                                 comment: "Title for the feed view")
    }

    var loadingErrorMessage: String {
        return NSLocalizedString("FEED_VIEW_CONNECTION_ERROR", tableName: "Feed", bundle: Bundle(for: FeedViewModel.self), comment: "Error message that is displayed, when loading image feed from server does not work.")
    }

    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?
    var onLoadingError: Observer<String?>?

    func loadFeed() {

        onLoadingError?(nil)
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in

            guard let self = self else { return }

            if let feed = try? result.get() {
                self.onFeedLoad?(feed)
            } else {
                self.onLoadingError?(self.loadingErrorMessage)
            }
            self.onLoadingStateChange?(false)
        }
    }
}

