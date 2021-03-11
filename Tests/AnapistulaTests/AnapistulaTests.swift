import XCTest
import class Foundation.Bundle
import Anapistula
import SwiftyRequest

final class AnapistulaTests: XCTestCase {
    func testThat_Server_WillReturnIndexHtml() throws {
        let tmpDirUrl = try self.getTempDir()
        let indexContent = "Test Index File Works!"
        _ = try self.createFile(dir: tmpDirUrl, content: indexContent)
        
        let config = AnapistulaConfig(
            port: 8888,
            staticPaths: [ "/": tmpDirUrl.path ],
            cacheEnable: false,
            enableSpa: false
        )
        
        let app = Anapistula(config: config)
        
        app.run(shouldWait: false)
        
        let request = RestRequest(method: .get, url: "http://localhost:\(config.port)")
        
        let g = DispatchGroup()
        g.enter()
        request.responseString { result in
            defer { g.leave() }
            switch result {
                case .success(let response):
                    print(" response: \(response)")
                    XCTAssertEqual(response.status, .ok, "HTTP Status should be 200 (OK)")
                    XCTAssertEqual(response.body, indexContent, "Content from server should be same as assigned")
                case .failure(let error):
                    XCTFail(error.localizedDescription)
            }
        }
                                  
        _ = g.wait(timeout: .now() + 3)
        app.stop()
        
        try self.deleteDir(tmpDirUrl)
    }
    
    func testByRunningApplication() throws {
        throw XCTSkip("not ready yet")
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        // Some of the APIs that we use below are available in macOS 10.13 and above.
        guard #available(macOS 10.13, *) else {
            return
        }

        let fooBinary = productsDirectory.appendingPathComponent("anapistula")

        let process = Process()
        process.executableURL = fooBinary

        let pipe = Pipe()
        process.standardOutput = pipe

        try process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = String(data: data, encoding: .utf8)

        XCTAssertEqual(output, "Hello, world!\n")
    }

    /// Returns path to the built products directory.
    var productsDirectory: URL {
      #if os(macOS)
        for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
            return bundle.bundleURL.deletingLastPathComponent()
        }
        fatalError("couldn't find the products directory")
      #else
        return Bundle.main.bundleURL
      #endif
    }

    static var allTests = [
        ("testByRunningApplication", testByRunningApplication),
    ]

}

// MARK: Helper Functions

extension AnapistulaTests {
    public enum Failures: LocalizedError {
        case unableToCreateFile
    }
    /// Create a file at a given path with the given contents
    /// - Parameters:
    ///   - dir: fileURL of directory to create file
    ///   - content: Content to write to file
    /// - Throws: `Failures.unableToCreateFile`
    /// - Returns: fileURL of created file
    func createFile(dir: URL, content: String) throws -> URL {
        let fm = FileManager.default
        let fileUrl = dir.appendingPathComponent("index.html")
        
        let contentData = content.data(using: .utf8)
        let result = fm.createFile(atPath: fileUrl.path, contents: contentData, attributes: [:])
        if result == false {
            throw Failures.unableToCreateFile
        }
        return fileUrl
    }
    
    /// Return the path of a temporary directory
    /// - Parameter shouldCreate: if true, create directory
    /// - Returns: path to newly created directory
    func getTempDir(shouldCreate: Bool = true) throws -> URL {
        let fm = FileManager.default
        let tmpDir =  fm.temporaryDirectory.appendingPathComponent(UUID().uuidString, isDirectory: true)
        
        try fm.createDirectory(at: tmpDir, withIntermediateDirectories: true, attributes: [:])
        
        return tmpDir
    }
    
    /// Delete a directory if it exists; do nothing if it does not
    /// - Parameter url: fileURL of directory to delete
    /// - Throws: ?
    func deleteDir(_ url: URL) throws {
        let fm = FileManager.default
        guard fm.fileExists(atPath: url.path) else {
            return
        }
        try fm.removeItem(at: url)
    }
}
