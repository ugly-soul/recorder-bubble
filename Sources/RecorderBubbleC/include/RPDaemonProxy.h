#import <Foundation/Foundation.h>

@interface RPDaemonProxy : NSObject
- (void)recordingTimerDidUpdate:(id)arg1;
- (void)stopSystemRecordingWithHandler:(id /* block */)arg1;
- (void)startSystemRecordingWithContextID:(id)arg1 windowSize:(CGSize)arg2 microphoneEnabled:(bool)arg3 cameraEnabled:(bool)arg4 withHandler:(id /* block */)arg5;
- (void)recordingDidStopWithError:(id)arg1 movieURL:(id)arg2;
@end