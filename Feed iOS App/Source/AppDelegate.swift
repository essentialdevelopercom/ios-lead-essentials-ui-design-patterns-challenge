//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import UIKit
import MVP
import MVVM
import MVC

@UIApplicationMain
public final class AppDelegate: UIResponder, UIApplicationDelegate {
	public var window: UIWindow?

	public func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow()
		window?.rootViewController = makeRootViewController()
		window?.makeKeyAndVisible()
		return true
	}

	private func makeRootViewController() -> UIViewController {
		let tabBar = UITabBarController()
		tabBar.viewControllers = [mvc(), mvvm(), mvp()]
		return tabBar
	}

	private func mvc() -> UIViewController {
		let view = UINavigationController(
			rootViewController: MVC.FeedUIComposer.feedComposedWith(
				feedLoader: AlwaysFailingLoader(delay: 1.5),
				imageLoader: AlwaysFailingLoader(delay: 1.5)))
		view.tabBarItem.title = "MVC"
		return view
	}

	private func mvvm() -> UIViewController {
		let view = UINavigationController(
			rootViewController: MVVM.FeedUIComposer.feedComposedWith(
				feedLoader: AlwaysFailingLoader(delay: 1.5),
				imageLoader: AlwaysFailingLoader(delay: 1.5)))
		view.tabBarItem.title = "MVVM"
		return view
	}

	private func mvp() -> UIViewController {
		let view = UINavigationController(
			rootViewController: MVP.FeedUIComposer.feedComposedWith(
				feedLoader: AlwaysFailingLoader(delay: 1.5),
				imageLoader: AlwaysFailingLoader(delay: 1.5)))
		view.tabBarItem.title = "MVP"
		return view
	}
}
