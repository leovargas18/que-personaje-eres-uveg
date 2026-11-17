import Combine
import Foundation

final class Cuestionario: ObservableObject {
    let preguntas: [Pregunta]

    @Published private(set) var indiceActual = 0
    @Published private(set) var respuestas: [Personaje] = []   // una por pregunta, no se editan
    @Published private(set) var resultado: Personaje?

    init(preguntas: [Pregunta] = bancoDePreguntas) {
        self.preguntas = preguntas
    }

    var preguntaActual: Pregunta? {
        if indiceActual < preguntas.count {
            return preguntas[indiceActual]
        }
        return nil
    }

    // Registra la respuesta y avanza. No permite responder dos veces ni cambiar respuestas previas.
    func responder(_ opcion: Opcion) {
        guard resultado == nil, let pregunta = preguntaActual else { return }
        guard pregunta.opciones.contains(where: { $0.id == opcion.id }) else { return }

        respuestas.append(opcion.personaje)

        if respuestas.count == preguntas.count {
            resultado = calcularResultado()   // al terminar la última pregunta, se cierra el cuestionario
        } else {
            indiceActual += 1
        }
    }

    // Cuenta puntos por personaje (diccionario) y devuelve el que más tiene.
    // En caso de empate gana el primero de la lista de personajes.
    private func calcularResultado() -> Personaje {
        var puntos: [Personaje: Int] = [:]
        for respuesta in respuestas {
            puntos[respuesta, default: 0] += 1
        }

        var ganador = Personaje.allCases[0]
        var maximo = 0
        for personaje in Personaje.allCases {
            let total = puntos[personaje, default: 0]
            if total > maximo {
                maximo = total
                ganador = personaje
            }
        }
        return ganador
    }

    func reiniciar() {
        indiceActual = 0
        respuestas = []
        resultado = nil
    }
}
