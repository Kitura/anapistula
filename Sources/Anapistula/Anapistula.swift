import Foundation
import Kitura
import KituraNet
import KituraCORS
import Koba

public class Anapistula {
    let router: Router
    let config: AnapistulaConfig
    var kobaConfig: KobaConfig?
    var corsConfig: Options?

    public init(config: AnapistulaConfig)
    {
        self.config = config
        router = Router()
    }

    public func run() {
        let port = self.config.port
        let koba: Koba?
        let cors: CORS?
        let staticServerConfig: StaticFileServer.Options

        if let config = kobaConfig {
            koba = Koba(config: config)
        } else {
            koba = nil
        }
        if let config = corsConfig {
            cors = CORS(options: config)
        } else {
            cors = nil
        }

        if self.config.enableSpa {
            staticServerConfig = StaticFileServer.Options(defaultIndex: "/index.html")
        } else {
            staticServerConfig = StaticFileServer.Options()
        }

        // Setup file server
        for (urlPath, filePath) in self.config.staticPaths {

            let server = StaticFileServer(path: filePath, options: staticServerConfig)
            router.get(urlPath, middleware: server)
            if let cors = cors {
                router.all(urlPath, middleware: cors)
            }
            if let koba = koba {
                router.all(urlPath, middleware: koba)
            }

            print("Serving \"\(filePath)\" as http://loocalhost:\(port)\(urlPath)")
        }
        
        // Setup port
        Kitura.addHTTPServer(onPort: self.config.port, with: router)

        // Block, running web server
        Kitura.run()
    }
}
