import SwiftUI

struct ContentView: View {
    @StateObject private var cuestionario = Cuestionario()

    var body: some View {
        VStack(spacing: 20) {
            Text("¿Qué personaje eres?")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)

            if let personaje = cuestionario.resultado {
                ResultadoView(personaje: personaje) {
                    cuestionario.reiniciar()
                }
            } else if let pregunta = cuestionario.preguntaActual {
                PreguntaView(
                    pregunta: pregunta,
                    numero: cuestionario.indiceActual + 1,
                    total: cuestionario.preguntas.count
                ) { opcion in
                    cuestionario.responder(opcion)
                }
                .id(pregunta.id)
            }
            Spacer()
        }
        .padding()
    }
}

struct PreguntaView: View {
    let pregunta: Pregunta
    let numero: Int
    let total: Int
    let alResponder: (Opcion) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Pregunta \(numero) de \(total)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            ProgressView(value: Double(numero), total: Double(total))

            Text(pregunta.texto)
                .font(.title3.bold())

            ForEach(pregunta.opciones) { opcion in
                Button {
                    alResponder(opcion)
                } label: {
                    Text(opcion.texto)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.accentColor.opacity(0.15))
                        .cornerRadius(12)
                }
                .buttonStyle(.plain)
            }
        }
    }
}

struct ResultadoView: View {
    let personaje: Personaje
    let alReiniciar: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("Tu personaje es")
                .font(.headline)
                .foregroundColor(.secondary)
            Text(personaje.rawValue)
                .font(.largeTitle.bold())
                .foregroundColor(.accentColor)
            Text(personaje.descripcion)
                .multilineTextAlignment(.center)
            Button("Volver a empezar", action: alReiniciar)
                .buttonStyle(.borderedProminent)
                .padding(.top)
        }
    }
}

#Preview {
    ContentView()
}
