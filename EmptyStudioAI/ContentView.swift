import SwiftUI

struct ContentView: View {
    @StateObject private var bridge = PythonBridge()
    @State private var input1: String = ""
    @State private var input2: String = ""
    
    var body: some View {
        VStack(spacing: 20) {
            VStack {
                Text("EMPTY STUDIO AI LAB")
                    .font(.system(.title3, design: .monospaced))
                    .fontWeight(.bold)
                Text("ENGINE: \(bridge.isEnvironmentReady ? "PYTHON_EMBEDDED_ACTIVE" : "INITIALIZING")")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(bridge.isEnvironmentReady ? .green : .red)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(white: 0.1))
            .cornerRadius(6)
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("EMY_OUTPUT://")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(.gray)
                HStack {
                    Text(bridge.emyOutput.isEmpty ? "Đang chờ dữ liệu..." : bridge.emyOutput)
                        .font(.system(.title2, design: .monospaced))
                        .foregroundColor(.cyan)
                    Spacer()
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color(white: 0.12))
            .overlay(RoundedRectangle(cornerRadius: 6).stroke(Color.cyan, lineWidth: 1))
            
            Spacer()
            
            HStack(spacing: 12) {
                TextField("Số 1", text: $input1)
                    .keyboardType(.numberPad)
                    .padding(12)
                    .background(Color(white: 0.15))
                    .font(.system(.body, design: .monospaced))
                    .cornerRadius(6)
                
                Text("+")
                    .font(.system(.title3, design: .monospaced))
                
                TextField("Số 2", text: $input2)
                    .keyboardType(.numberPad)
                    .padding(12)
                    .background(Color(white: 0.15))
                    .font(.system(.body, design: .monospaced))
                    .cornerRadius(6)
            }
            
            Button(action: {
                if let n1 = Double(input1), let n2 = Double(input2) {
                    bridge.askEmy(num1: n1, num2: n2)
                }
            }) {
                Text("NẠP PHÉP TÍNH CHO EMY")
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(bridge.isEnvironmentReady ? Color.blue : Color.gray)
                    .cornerRadius(6)
            }
            .disabled(!bridge.isEnvironmentReady)
        }
        .padding()
        .preferredColorScheme(.dark)
    }
}