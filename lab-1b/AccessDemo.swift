
import Foundation

public class AccessDemo {

    private var privateValue = "Private Access"

    fileprivate var filePrivateValue = "Fileprivate Access"

    internal var internalValue = "Internal Access"

    public var publicValue = "Public Access"

    public init() {}

    public func showPrivateValue() {
        print(privateValue)
    }

    public func showFilePrivateValue() {
        print(filePrivateValue)
    }
}
