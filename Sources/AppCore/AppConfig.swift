import Foundation

public struct AppConfig {
    public typealias PathMap = [String:String] // key: url path, value: filesystem path

    let port: Int
    let staticPaths: PathMap

    public init(port: Int, staticPaths: PathMap) {
        self.port = port
        self.staticPaths = staticPaths
    }
}
