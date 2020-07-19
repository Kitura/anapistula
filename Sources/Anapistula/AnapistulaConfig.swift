import Foundation

public struct AnapistulaConfig {
    public typealias PathMap = [String:String] // key: url path, value: filesystem path

    public let port: Int
    public let staticPaths: PathMap
    public let cacheEnable: Bool
    public let enableSpa: Bool

    public init(port: Int, staticPaths: PathMap, cacheEnable: Bool = false, enableSpa: Bool = false) {
        self.port = port
        self.staticPaths = staticPaths
        self.cacheEnable = cacheEnable
        self.enableSpa = enableSpa
    }
}
