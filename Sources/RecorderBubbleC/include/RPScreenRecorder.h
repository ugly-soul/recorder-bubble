#import <Foundation/Foundation.h>

@interface RPScreenRecorder : NSObject
+ (RPScreenRecorder *)sharedRecorder;
- (bool)isPaused;
- (bool)isRecording;
- (void)startSystemRecordingWithMicrophoneEnabled:(bool)arg1 handler:(id /* block */)arg2;
- (void)stopSystemRecording:(id /* block */)arg1;
@end
