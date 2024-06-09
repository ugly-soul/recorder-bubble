import RecorderBubbleC

class RBManager {
  static let shared = RBManager();

  func toggleRecorderStatus() {
    if self.getCaptureStatus() {
      self.endCapture();
    } else {
      self.startCapture();
    }
  }
  private func startCapture() {
    RPScreenRecorder.shared().startSystemRecording(withMicrophoneEnabled: true, handler: nil);
  }

  private func endCapture() {
    RPScreenRecorder.shared().stopSystemRecording(nil);
  }

  private func getCaptureStatus() -> Bool {
    let status: Bool = RPScreenRecorder.shared().isRecording();
    return status;
  }

}