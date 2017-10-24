// AUTOGENERATED FILE - DO NOT MODIFY!
// This file generated by Djinni from sdk.djinni

#import "GSKPDFDocument.h"
#import "GSKPDFGeneratorError.h"
#import <Foundation/Foundation.h>
@class GSKPDFGenerator;
@protocol GSKPDFImageProcessor;
@protocol GSKPDFLogger;


@interface GSKPDFGenerator : NSObject

+ (nullable GSKPDFGenerator *)createWithDocument:(nonnull GSKPDFDocument *)document
                                       processor:(nullable id<GSKPDFImageProcessor>)processor
                                          logger:(nullable id<GSKPDFLogger>)logger;

- (GSKPDFGeneratorError)generatePDF:(nonnull NSString *)outputFile;

@end
