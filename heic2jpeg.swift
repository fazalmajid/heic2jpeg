import Foundation
import CoreImage

var jpegQuality = 0.90
let context = CIContext(options: nil)
let options = NSDictionary(
    dictionary: [kCGImageDestinationLossyCompressionQuality:jpegQuality]
)
var delete:Bool
var filename:String?
delete = false
for i in 1..<Int(CommandLine.argc) {
    filename = CommandLine.arguments[i]
    if filename == "-delete" || filename == "--delete" {
        delete = true
        continue
    }
    let srcURL = URL(fileURLWithPath:filename!)
    let destURL = srcURL.deletingPathExtension().appendingPathExtension("jpg")
    var exists:Bool
    do {
        exists = try destURL.checkResourceIsReachable()
    } catch {
        exists = false
    }
    if exists {
        print("skipping \(filename ?? "???")")
    } else {
        print("converting \(filename ?? "???")")
        let image = CIImage(contentsOf: srcURL)
        do {
            try context.writeJPEGRepresentation(
                of:image!,
                to:destURL,
                colorSpace: image!.colorSpace!,
                options:options as! [CIImageRepresentationOption : Any]
            )
            if delete {
                print("deleting \(filename ?? "???")")
                try FileManager.default.removeItem(at:srcURL)
            }
        } catch {
        }
    }
}
