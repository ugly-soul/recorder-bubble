import UIKit

class RBViewController: UIViewController {
  var contentView: RBAnimateView?;

  override func viewDidLoad() {
    super.viewDidLoad();
    DispatchQueue.main.async {
      self.createSubviews();
    }
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder);
  }

  private func createSubviews() {
    self.contentView = RBAnimateView();
    self.contentView!.backgroundColor = .clear;
    self.contentView!.frame = CGRect(x: 0, y: 0, width: 44, height: 44);
    self.contentView!.layer.cornerRadius = 22;
    self.view.addSubview(self.contentView!);

    self.contentView!.center = CGPoint(x: 100, y: 100);

    // click
    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(sender :)));
    self.contentView!.addGestureRecognizer(tapGestureRecognizer);
    // touchmove
    let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)));
    self.contentView!.addGestureRecognizer(panGestureRecognizer);
  }

  @objc func viewTapped(sender: UITapGestureRecognizer?) {
    self.contentView?.stopAnimate();
    RBManager.shared.toggleRecorderStatus();
  }

  @objc func handlePan(_ gesture: UIPanGestureRecognizer?) {
    guard let _contentView = self.contentView else { return; }
    switch gesture?.state {
      case .began, .changed:
        guard let translation = gesture?.translation(in: _contentView) else {
          return;
        }
        _contentView.center = CGPoint(x: _contentView.center.x + translation.x, y: _contentView.center.y + translation.y);
        UIView.animate(withDuration: 0.1, animations: {
          gesture?.setTranslation(.zero, in: _contentView);
        });
        break;
      case .ended:
        let newFrame = _contentView.frame;
        let screenBounds = self.view.bounds;
        let _x = max(screenBounds.minX, min(newFrame.minX, screenBounds.maxX - newFrame.width));
        let _y = max(screenBounds.minY, min(newFrame.minY, screenBounds.maxY - newFrame.height));
        UIView.animate(withDuration: 0.4, animations: {
          _contentView.frame.origin = CGPoint(x: _x, y: _y);
        });
        break;
      default:
        break;
    }
  }

  func hideContentView() {
    self.contentView?.stopAnimate();
    UIView.animate(withDuration: 0.4, animations: {
      self.contentView?.alpha = 0.0;
    });
  }

  func showContentView() {
    self.contentView?.animate();
    UIView.animate(withDuration: 0.4, animations: {
      self.contentView?.alpha = 1.0;
    });
  }

  override var shouldAutorotate : Bool {
    return false;
  }
}