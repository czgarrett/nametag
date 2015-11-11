//: Playground - noun: a place where people can play

import UIKit

let dpi: CGFloat = 600.0 // dots per inch for the image.  CGFloat is the floating point type used in core graphics

let imageSizeInches = CGSizeMake(3.375, 2.3333) // Avery 5395 labels
let imageSizePixels = CGSizeMake(imageSizeInches.width * dpi, imageSizeInches.height*dpi)

let imageRect = CGRect(origin: CGPoint.zero, size: imageSizePixels)

UIGraphicsBeginImageContext(imageSizePixels)  // This sets up a context into which we can draw images

// Get the context
let context = UIGraphicsGetCurrentContext()


// Draw our beautiful name tag

// Fill it with white so the preview looks good.  Or pick any color that won't use lots of printer ink.  ☺️
CGContextSetFillColorWithColor(context, UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).CGColor)
CGContextFillRect(context, imageRect)

// Draw a border around the edge

// the border is inset by 60px
let borderRect = CGRectInset(imageRect, 60.0, 60.0)

// Set a color for the border
CGContextSetStrokeColorWithColor(context, UIColor.purpleColor().CGColor)

// Create a bezier path for the border
let bezierPath = UIBezierPath(roundedRect: borderRect, cornerRadius: 60.0)
bezierPath.lineWidth = 18.0
bezierPath.stroke()

// Draw our name

// For a list of font names, go to iosfonts.com
let font = UIFont(name: "Georgia-Bold", size: 240.0)! // it's a big size because our image is actually pretty big in pixels

let name = "Chris Garrett" as NSString

// Create a paragraph style for our name
let paragraphStyle = NSMutableParagraphStyle()
paragraphStyle.alignment = .Center

let textAttributes = [
    NSFontAttributeName: font,
    NSForegroundColorAttributeName: UIColor.blackColor(),
    NSParagraphStyleAttributeName: paragraphStyle
]

var nameRect = borderRect
nameRect.size.height = 240.0
nameRect.origin.y = 120.0
name.drawInRect(nameRect, withAttributes: textAttributes)





let image = UIGraphicsGetImageFromCurrentImageContext()


UIGraphicsEndImageContext() // clean up after ourselves

let folderName = "NameTag"
// Playgrounds get their own sandboxed folder for documents.  Here we're going to get that folder so that we can save our image
let documentDirectoryURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
let folder = documentDirectoryURL.URLByAppendingPathComponent(folderName) // You can ctrl-click on this URL to the right, and choose Open URL to navigate to it ->
let fileMgr = NSFileManager.defaultManager()
if (!fileMgr.fileExistsAtPath(folder.path!)) {
    do {
        try fileMgr.createDirectoryAtURL(folder, withIntermediateDirectories: false, attributes: nil)
    } catch _ {
    }
}

let filePath = folder.URLByAppendingPathComponent("NameTag.png")

// Convert the in-memory image into file data
let fileData = UIImagePNGRepresentation(image)

// Save the data
fileData?.writeToFile(filePath.path!, atomically: true)


