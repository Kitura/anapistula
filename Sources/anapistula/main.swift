import AppCore
import Foundation
import SPMUtility

print("Hello, world!")

let defaultPort = 8000
let defaultDocroot = "."

let parser = ArgumentParser(commandName: "anapistula",
                            usage: "-p port",
                            overview: "A simple web server")

let argFieldPort = parser.add(option: "--port", shortName: "-p", kind: Int.self, usage: "Port to listen on", completion: ShellCompletion.none)
let argFieldDocroot = parser.add(option: "--docroot", shortName: "-d", kind: String.self, usage: "filesystem path to search for files", completion: ShellCompletion.none)

let args = Array(CommandLine.arguments.dropFirst())
let result = try parser.parse(args)

let fieldPort = result.get(argFieldPort) ?? defaultPort
let fieldDocroot = result.get(argFieldDocroot) ?? defaultDocroot

let config = AppConfig(
    port: fieldPort,
    staticPaths: ["/":fieldDocroot]
)

let app = App(config: config)


app.run()

