import Anapistula
import Foundation
import ArgumentParser

let defaultPort = 8000
let defaultDocroot = "."
let defaultCacheEnable = false
let defaultSPAEnable = false

struct CLI: ParsableCommand {
    @Option(name: .shortAndLong, default: defaultPort, help: "TCP Port to listen on (Default: \(defaultPort))")
    var port: Int

    @Option(name: .shortAndLong, default: defaultDocroot, help: "Filesystem path to search for files.  (Default: \(defaultDocroot))")
    var docRoot: String

    @Option(name: .shortAndLong, default: defaultCacheEnable, help: "Enable/disable cache.  Default: \(defaultCacheEnable)")
    var enableCache: Bool

    @Option(name: .shortAndLong, default: defaultSPAEnable, help: "Enable Single-Page-Application mode.  Default: \(defaultSPAEnable)")
    var enableSPA: Bool

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
