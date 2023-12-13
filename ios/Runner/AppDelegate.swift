import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
       let batteryChannel = FlutterMethodChannel(name: "com.flutter.epic/epic",
                                                 binaryMessenger: controller.binaryMessenger)
      
                 batteryChannel.setMethodCallHandler({
                 [weak self] (call: FlutterMethodCall, result:  FlutterResult) -> Void in
                 
                 // Note: this method is invoked on the UI thread.
                     if (call.method == "printy"){
                        var bridge = ViewModel()
                        
                        guard let args = call.arguments else { return }
                        
                        let myArgs = args as? [String: Any]
                        
                        let sb = UIStoryboard(name: "AR", bundle: nil)
                        let nav = sb.instantiateViewController(withIdentifier: "AR") as! ViewController
                        //self.controller?.showViewController(nav, sender: nil)
//                        if let vc = nav.children.first as? ViewController {
//                          //  vc.bodyTitle = "AR BITCH"
//                        }
                      
                        nav.url = myArgs?["image"] as? String ?? ""
                        var dims = [Float]( repeating: 0.0,count: 2)
                        dims[0]  = (myArgs?["dimX"] as? NSString ?? "1.0").floatValue
                        dims[1] = (myArgs?["dimY"] as? NSString ?? "1.0").floatValue
                        nav.dims = dims
                        
                        nav.tilesInUnit = (myArgs?["tilesUnit"] as? NSString ?? "1.0").floatValue
                        nav.productNameS = myArgs?["name"] as? String ?? ""
                        nav.productBrandS = myArgs?["brand"] as? String ?? ""
                        nav.bridge = bridge
                        bridge.closeAction = { [weak nav] in
                            nav?.dismiss(animated: true)
                            
                        }
                        controller.present(nav, animated: true, completion: nil)
                      
                     } 
                     else {
                        result(FlutterMethodNotImplemented)
                  return
                 }
             //  self?.receiveBatteryLevel(result: result)
             })
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

