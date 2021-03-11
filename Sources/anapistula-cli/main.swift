import Anapistula
import Foundation
import ArgumentParser

let defaultPort = 8000
let defaultDocroot = "."
let defaultCacheEnable = false
let defaultSPAEnable = false

struct CLI: ParsableCommand {
    @Option(name: .shortAndLong, help: "TCP Port to listen on (Default: \(defaultPort))")
    var port: Int = defaultPort

    @Option(name: .shortAndLong, help: "Filesystem path to search for files.  (Default: \(defaultDocroot))")
    var docRoot: String = defaultDocroot

    @Option(name: .shortAndLong, help: "Enable/disable cache.  Default: \(defaultCacheEnable)")
    var enableCache: Bool = defaultCacheEnable

    @Option(name: .shortAndLong, help: "Enable Single-Page-Application mode.  Default: \(defaultSPAEnable)")
    var enableSPA: Bool = defaultSPAEnable

    func run() throws {
        let config = AnapistulaConfig(
            port: self.port,
            staticPaths: [ "/": self.docRoot ],
            cacheEnable: enableCache,
            enableSpa: enableSPA
        )

        let app = Anapistula(config: config)

        app.run()
    }
}

CLI.main()
