import UIKit
import MorningBearKit
import MorningBearUI

import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        // Configure SDKs
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        
        
        return true
    }

}
