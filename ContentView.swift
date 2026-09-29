import SwiftUI
import AVFoundation

enum CameraShape: String, CaseIterable {
    case circle = "Círculo"
    case square = "Quadrado"
    case rounded = "Arredondado"
    case diamond = "Losango"
}

struct ContentView: View {
    @StateObject private var cameraManager = CameraManager()
    @State private var currentShape: CameraShape = .circle
    @State private var isHovering = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            CameraPreview(session: cameraManager.session)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            if isHovering {
                Button(action: {
                    NSApplication.shared.terminate(nil)
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 24))
                        .foregroundColor(Color.white.opacity(0.8))
                        .background(Circle().fill(Color.black.opacity(0.4)))
                }
                .buttonStyle(PlainButtonStyle())
                .padding(16)
                .transition(.opacity)
            }
        }
        .mask(shapeMask)
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.2)) {
                isHovering = hovering
            }
        }
        .contextMenu {
            Menu("Mudar Formato") {
                ForEach(CameraShape.allCases, id: \.self) { shape in
                    Button(shape.rawValue) {
                        currentShape = shape
                    }
                }
            }
            Divider()
            Button("Sair") {
                NSApplication.shared.terminate(nil)
            }
        }
        // Area interativa para garantir que cliques no fundo funcionem no arrasto
        .contentShape(Rectangle()) 
    }
    
    @ViewBuilder
    var shapeMask: some View {
        switch currentShape {
        case .circle:
            Circle()
        case .square:
            Rectangle()
        case .rounded:
            RoundedRectangle(cornerRadius: 20)
        case .diamond:
            DiamondShape()
        }
    }
}

// Forma personalizada de Losango
struct DiamondShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.closeSubpath()
        return path
    }
}

// Classe NSView personalizada para acomodar a camada de vídeo
class PreviewView: NSView {
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            fatalError("Esperava um `AVCaptureVideoPreviewLayer`")
        }
        return layer
    }
    
    override func makeBackingLayer() -> CALayer {
        let layer = AVCaptureVideoPreviewLayer()
        layer.videoGravity = .resizeAspectFill
        return layer
    }
    
    var session: AVCaptureSession? {
        get { videoPreviewLayer.session }
        set { videoPreviewLayer.session = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        self.wantsLayer = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) não foi implementado")
    }
}

// Ponte entre AppKit (NSView) e SwiftUI (View)
struct CameraPreview: NSViewRepresentable {
    let session: AVCaptureSession
    
    func makeNSView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.session = session
        return view
    }
    
    func updateNSView(_ nsView: PreviewView, context: Context) {
        nsView.session = session
    }
}
