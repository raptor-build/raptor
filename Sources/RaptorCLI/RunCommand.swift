//
// RunCommand.swift
// Raptor
// https://raptor.build
// See LICENSE for license information.
//

import ArgumentParser
import Foundation

/// The command that lets users run their Raptor site
/// back in a local web server.
struct RunCommand: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName: "run",
        abstract: "Start a local web server for the current site."
    )

    /// The server's port number. Defaults to 8000.
    @Option(name: .shortAndLong, help: "The port number to run the local server on.")
    var port = 8000

    /// The name of the site's output directory. Defaults to Build.
    @Option(name: .shortAndLong, help: "The name of your build directory.")
    var directory = "Build"

    /// Whether to open a web browser pointing at the local
    /// web server. Defaults to false.
    @Flag(help: "Whether to open the server in your preferred web browser immediately.")
    var preview = false

    /// Runs this command. Automatically called by Argument Parser.
    func run() throws {
        // Make sure we actually have a folder to serve up.
        guard FileManager.default.fileExists(atPath: "./\(directory)") else {
            print("❌ Failed to find directory named '\(directory)'.")
            return
        }

        // Detect if the site is a subsite
        let subsite = identifySubsite(directory: directory) ?? ""

        // Find an available port
        var currentPort = port
        while isPortInUse(currentPort) {
            currentPort += 1
            if currentPort >= 9000 {
                print("❌ No available ports found in range 8000–8999.")
                return
            }
        }

        // Get the installed location of the server script
        let serverScriptURL = URL(fileURLWithPath: "/usr/local/bin/raptor-server.py")

        // Verify server script exists
        guard FileManager.default.fileExists(atPath: serverScriptURL.path) else {
            print("❌ Critical server component missing")
            print("   This suggests a corrupted installation. Please reinstall with:")
            print("   make install && make clean")
            return
        }

        let serverURL = "http://localhost:\(currentPort)\(subsite)"
        print("✅ Starting local web server on \(serverURL)")

        generateQRCode(port: currentPort, subsite: subsite)

        // Build the Python server process
        let serverProcess = Process()
        serverProcess.executableURL = URL(fileURLWithPath: "/usr/bin/python3")
        serverProcess.arguments = [
            serverScriptURL.path,
            "-d", directory,
            subsite.isEmpty ? nil : "-s",
            subsite.isEmpty ? nil : subsite,
            "\(currentPort)"
        ].compactMap { $0 }

        serverProcess.standardOutput = nil
        serverProcess.standardError  = nil

        try serverProcess.run()

        // Open browser after server starts (no DispatchQueue / run loop)
        if preview {
            Thread {
                Thread.sleep(forTimeInterval: 0.5)
                _ = try? Process.run(
                    URL(fileURLWithPath: "/usr/bin/open"),
                    arguments: [serverURL]
                )
            }.start()
        }

        print("Press ↵ Return to exit.")

        // Wait for user input, then terminate server cleanly
        _ = readLine()

        if serverProcess.isRunning {
            serverProcess.terminate()
        }

        serverProcess.waitUntilExit()
    }

    /// Returns true if there is a server running on the specified port.
    private func isPortInUse(_ port: Int) -> Bool {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/sbin/lsof")
        process.arguments = ["-t", "-i", "tcp:\(port)"]

        let pipe = Pipe()
        process.standardOutput = pipe
        process.standardError = Pipe()

        try? process.run()
        process.waitUntilExit()

        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        return !data.isEmpty
    }

    /// Generates a QR code for the given URL and prints it to the terminal.
    private func generateQRCode(port: Int, subsite: String) {
        #if canImport(CoreImage)
        guard let ipAddress = getLocalIPAddress() else { return }
        let localURL = "http://\(ipAddress):\(port)\(subsite)"
        guard let qrCode = try? QRCode(utf8String: localURL) else { return }
        print("\n📱 Scan this QR code to access the site on your mobile device:\n")
        print(qrCode.smallAsciiRepresentation())
        print("URL: \(localURL)\n")
        #endif
    }

    /// Returns the local IP address of the machine.
    private func getLocalIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?

        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            while ptr != nil {
                defer { ptr = ptr?.pointee.ifa_next }

                guard
                    let interface = ptr?.pointee,
                    interface.ifa_addr.pointee.sa_family == UInt8(AF_INET)
                else { continue }

                let name = String(cString: interface.ifa_name)
                guard name != "lo0" else { continue }

                var buffer = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                getnameinfo(
                    interface.ifa_addr,
                    socklen_t(MemoryLayout<sockaddr_in>.size),
                    &buffer,
                    socklen_t(buffer.count),
                    nil,
                    0,
                    NI_NUMERICHOST
                )

                let bytes = buffer.prefix { $0 != 0 }.map { UInt8(bitPattern: $0) }
                address = String(decoding: bytes, as: UTF8.self)
                break
            }
            freeifaddrs(ifaddr)
        }

        return address
    }

    /// Identify subsite by looking at the canonical URL of
    /// the root index.html of the given directory.
    private func identifySubsite(directory: String) -> String? {
        guard let data = FileManager.default.contents(atPath: "\(directory)/index.html") else {
            return nil
        }

        let html = String(decoding: data, as: UTF8.self)
        let regex = #/<link href="([^"]+)" rel="canonical"/#
        guard let match = html.firstMatch(of: regex)?.1 else { return nil }
        guard let url = URL(string: String(match)), url.path != "/" else { return nil }

        return url.path
    }
}
