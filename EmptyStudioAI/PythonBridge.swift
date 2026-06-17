import Foundation
import PythonKit

class PythonBridge: ObservableObject {
    @Published var isEnvironmentReady = false
    @Published var emyOutput = ""
    private var emyInstance: PythonObject?

    init() {
        configurePython()
    }

    func configurePython() {
        guard let resourcePath = Bundle.main.resourcePath else { return }
        let sys = Python.import("sys")
        sys.path.append(resourcePath)
        
        do {
            let emyModule = try Python.import("EmyEngine")
            emyInstance = emyModule.AdvancedMathAI()
            isEnvironmentReady = true
        } catch {
            print("Lỗi Python Runtime: \(error)")
            isEnvironmentReady = false
        }
    }

    func askEmy(num1: Double, num2: Double) {
        guard isEnvironmentReady, let emy = emyInstance else {
            self.emyOutput = "ERROR: RUNTIME_NOT_READY"
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            let prediction = emy.forward([num1, num2])
            let result = Double(prediction)! * 10.0
            
            DispatchQueue.main.async {
                self.emyOutput = String(format: "%.2f", result)
            }
        }
    }
}
