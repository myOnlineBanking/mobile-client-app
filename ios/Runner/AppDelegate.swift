import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyCVzK60GFCWg6_7Qxa1G_-QjWZ_Y99WZBM")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
