//
//  FeedErrorViewAdapter.swift
//  MVP
//
//  Created by Valentin Kalchev (Zuant) on 14/12/20.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation
 
final class FeedErrorViewAdapter: FeedErrorView {
    private weak var controller: FeedViewController?
    init(controller: FeedViewController) {
        self.controller = controller
    }
    
    func display(_ viewModel: FeedErrorViewModel) {
        controller?.display(viewModel)
    }
}
