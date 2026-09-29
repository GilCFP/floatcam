import AVFoundation
import CoreImage

class CameraManager: NSObject, ObservableObject {
    @Published var session = AVCaptureSession()
    
    override init() {
        super.init()
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupCamera()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                }
            }
        default:
            print("Permissão de câmera negada. Você precisa autorizar nos Ajustes do Sistema.")
        }
    }
    
    func setupCamera() {
        session.beginConfiguration()
        
        // Usa a câmera padrão do sistema
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else {
            print("Não foi possível acessar a câmera.")
            return
        }
        
        if session.canAddInput(input) {
            session.addInput(input)
        }
        
        session.commitConfiguration()
        
        // Iniciar sessão de captura em uma thread de background
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.session.startRunning()
        }
    }
}
