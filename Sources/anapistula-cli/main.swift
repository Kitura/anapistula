import Anapistula
import Foundation
import ArgumentParser

let defaultPort = 8000
let defaultDocroot = "."

struct CLI: ParsableCommand {
    @Option(name: .shortAndLong, default: defaultPort, help: "TCP Port to listen on (Default: \(defaultPort))")
    var port: Int

    @Option(name: .shortAndLong, default: defaultDocroot, help: "Filesystem path to search for files.  (Default: \(defaultDocroot))")
    var docRoot: String

    func run() throws {
        let config = AnapistulaConfig(
            port: self.port,
            staticPaths: [ "/": self.docRoot ]
        )

        let app = Anapistula(config: config)

        app.run()
    }
}

CLI.main()
