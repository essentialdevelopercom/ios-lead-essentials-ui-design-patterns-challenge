
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
    var onErrorStateChange: Observer<String?>?
    
    func refreshFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            switch result {
            case let .success(feed):
                self?.onFeedLoad?(feed)
            case .failure:
                self?.onErrorStateChange?(Localized.Feed.loadError)
            }
            self?.onLoadingStateChange?(false)
        }
    }
    
}
