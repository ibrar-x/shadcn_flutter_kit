import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  private let markdownLinkChannelName = "shadcn_flutter_kit/markdown_link_opener"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: markdownLinkChannelName,
        binaryMessenger: controller.binaryMessenger
      )
      channel.setMethodCallHandler { [weak self] call, result in
        guard call.method == "openLink" else {
          result(FlutterMethodNotImplemented)
          return
        }
        guard
          let arguments = call.arguments as? [String: Any],
          let urlString = arguments["url"] as? String,
          !urlString.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
          result(false)
          return
        }
        self?.openLink(urlString, result: result)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func openLink(_ urlString: String, result: @escaping FlutterResult) {
    guard let url = URL(string: urlString) else {
      result(false)
      return
    }

    DispatchQueue.main.async {
      UIApplication.shared.open(url, options: [:]) { success in
        result(success)
      }
    }
  }
}
