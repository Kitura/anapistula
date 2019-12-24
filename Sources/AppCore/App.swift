import Foundation
import Kitura
import KituraNet
import KituraCORS

public class App {
    let router: Router
    let config: AppConfig

    public init(config: AppConfig)
    {
        self.config = config
        router = Router()
    }

    public func run() {
        let port = self.config.port

        // setup CORS
        let corsOptions = Options(allowedOrigin: .all,
                                  preflightContinue: true)
        let cors = CORS(options: corsOptions)


        // Setup file server
        for (urlPath, filePath) in self.config.staticPaths {
            let server = StaticFileServer(path: filePath)
            router.get(urlPath, middleware: server)
            router.all(urlPath, middleware: cors)

            print("Serving \"\(filePath) as http://loocalhost:\(port)\(urlPath)")
        }

        // Setup port
        Kitura.addHTTPServer(onPort: self.config.port, with: router)

        // Block, running web server
        Kitura.run()
    }
}
