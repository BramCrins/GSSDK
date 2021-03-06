#import "Scan.h"
#import "UIImage-Extensions.h"

@implementation Scan

+ (NSString*) convertFilePathToFileUri:(NSString*)filePath {
    return [[NSURL fileURLWithPath:filePath] absoluteString];
}
+ (NSString*) convertFileUriToFilePath:(NSString*)fileUri {
    return [[NSURL URLWithString:fileUri] path];
}

+ (Scan*)initWithFileUri:(NSString*)originalImageeUri {
    Scan *instance = [[Scan alloc] init];

    NSString *originalImagePath = [Scan convertFileUriToFilePath:originalImageeUri];
    instance.originalImage = [UIImage imageWithContentsOfFile:originalImagePath];
    instance.rotation = 0;
    return instance;
}

- (void) rotateLeft {
    self.rotation -= M_PI_2;
}

- (void) rotateRight {
    self.rotation += M_PI_2;
}

- (void)saveAndSendCallback {
    NSTimeInterval timestamp = [[NSDate date] timeIntervalSince1970];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *enhancedImagePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"enhanced-%lu.jpg", (unsigned long)timestamp]];

    // Rotate image before saving
    UIImage *rotatedImage = [self.enhancedImage imageRotatedByRadians:self.rotation];

    [UIImageJPEGRepresentation(rotatedImage, 0.85) writeToFile:enhancedImagePath atomically:YES];
    NSString *resultFileUri = [Scan convertFilePathToFileUri:enhancedImagePath];

    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:resultFileUri];
    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}

- (void)cancelCallback {
    CDVPluginResult *result = [CDVPluginResult resultWithStatus:CDVCommandStatus_NO_RESULT messageAsString:@"Canceled"];

    [self.commandDelegate sendPluginResult:result callbackId:self.callbackId];
}
@end
