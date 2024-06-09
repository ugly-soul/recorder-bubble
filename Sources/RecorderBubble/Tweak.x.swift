import Orion
import RecorderBubbleC

var _window: RBWindow? = nil;
class SpringBoardHook: ClassHook<SpringBoard> {
  func applicationDidFinishLaunching(_ application : AnyObject) {
    orig.applicationDidFinishLaunching(application);
    _window = RBWindow.sharedWindow();
    _window?.makeKeyAndVisible();
  }
}

class RPDaemonProxyHook: ClassHook<RPDaemonProxy> {
  func startSystemRecordingWithContextID(
      _ arg: Any,
      windowSize arg2: CGSize,
      microphoneEnabled arg3: Bool,
      cameraEnabled arg4: Bool,
      withHandler arg5: Any
  ) {
    orig.startSystemRecordingWithContextID(arg, windowSize: arg2, microphoneEnabled: arg3, cameraEnabled: arg4, withHandler: arg5);
    DispatchQueue.main.async {
      _window?.getRootVC()?.hideContentView();
      _window?.getRootVC()?.showContentView();
    }
  }

  func stopSystemRecordingWithHandler(_ arg: Any) {
    orig.stopSystemRecordingWithHandler(arg);
    DispatchQueue.main.async {
      _window?.getRootVC()?.hideContentView();
    }
  }

  func recordingDidStopWithError(_ arg1: Any, movieURL arg2: Any) {
    orig.recordingDidStopWithError(arg1, movieURL: arg2);
    DispatchQueue.main.async {
      _window?.getRootVC()?.hideContentView();
    }
  }

  func recordingTimerDidUpdate(_ arg: Any) {
    orig.recordingTimerDidUpdate(arg);
    // TODO: 录制中，后续可能新增记时等....
  }
}
