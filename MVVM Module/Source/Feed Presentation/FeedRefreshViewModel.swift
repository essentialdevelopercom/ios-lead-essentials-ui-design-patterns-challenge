
import Foundation
import FeedFeature


final class FeedRefreshViewModel {
    
    typealias Observer<T> = (T) -> Void
    
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?
    var onFeedError: Observer<String>?
    
    func refreshFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.onFeedLoad?(feed)
            case .failure:
                self?.onFeedError?(Localized.Feed.loadError)
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
}
