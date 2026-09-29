import SwiftUI

@main
struct FloatCamApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var activity: NSObjectProtocol?

    func applicationDidFinishLaunching(_ notification: Notification) {
        // Evita que o macOS congele o app (App Nap) ao mover janelas ou quando achar que ele está em segundo plano
        activity = ProcessInfo.processInfo.beginActivity(options: [.userInitiatedAllowingIdleSystemSleep], reason: "Camera tracking")
        
        let contentView = ContentView()

        // Criar janela sem bordas e transparente
        window = NSWindow(
            contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
            styleMask: [.borderless, .resizable],
            backing: .buffered,
            defer: false
        )
        
        window.center()
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = true
        
        // Habilitar arrastar a janela clicando em qualquer lugar dela
        window.isMovableByWindowBackground = true 
        
        // Configurações cruciais para o MVP: 
        // 1. Sempre no topo
        // 2. Visível em todas as mesas (spaces) e até sobre apps em tela cheia
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        
        window.contentView = NSHostingView(rootView: contentView)
        window.makeKeyAndOrderFront(nil)
    }
}
