import UIKit

class RBWindow : UIWindow {
  private static let shared: RBWindow = {
    let frame = UIScreen.main.bounds;
    return RBWindow(frame: frame);
  }();
  private var _vc: RBViewController!;

  class func sharedWindow() -> RBWindow {
    return shared;
  }

  private override init(frame: CGRect) {  
    super.init(frame: frame);
    if let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
      windowScene = firstScene;
    }
    
    windowLevel = UIWindow.Level.statusBar - 1;
    isHidden = false;
    _vc = RBViewController(nibName: nil, bundle: nil);
    rootViewController = _vc;
    rootViewController?.view.frame = frame;
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder);
  }

  func getRootVC() -> RBViewController? {
    return self._vc;
  }

  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    // let hitTestResult = super.hitTest(point, with: event)

    guard let contentView = self._vc.contentView else {
      return nil;
    }

    if contentView.alpha <= 0.2 { return nil; }

    let convertedRect = contentView.convert(contentView.bounds, to: nil)
    if convertedRect.contains(point) {
      return contentView
    }

    return nil;
  }
}