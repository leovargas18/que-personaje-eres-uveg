import Foundation

// Prueba de lógica del cuestionario (se ejecuta en la nube con swiftc, sin simulador).
var fallos = 0
func verificar(_ condicion: Bool, _ mensaje: String) {
    print(condicion ? "OK    " : "FALLO ", mensaje)
    if !condicion { fallos += 1 }
}

verificar(bancoDePreguntas.count == 5, "El banco tiene 5 preguntas")
verificar(bancoDePreguntas.allSatisfy { $0.opciones.count == 4 }, "Cada pregunta tiene 4 opciones")

// Si el usuario elige siempre las opciones de un personaje, ese personaje debe ser el resultado.
for objetivo in Personaje.allCases {
    let c = Cuestionario()
    for _ in 0..<5 {
        guard let pregunta = c.preguntaActual,
              let opcion = pregunta.opciones.first(where: { $0.personaje == objetivo }) else { break }
        c.responder(opcion)
    }
    verificar(c.resultado == objetivo, "Respondiendo siempre \(objetivo.rawValue) el resultado es \(objetivo.rawValue)")
}

// Después de la pregunta 5 el cuestionario se cierra y no acepta más respuestas.
let c = Cuestionario()
for _ in 0..<5 { c.responder(c.preguntaActual!.opciones[0]) }
let resultadoFinal = c.resultado
verificar(resultadoFinal != nil && c.respuestas.count == 5, "Al responder la pregunta 5 se muestra un resultado")
c.responder(bancoDePreguntas[0].opciones[1])
verificar(c.respuestas.count == 5 && c.resultado == resultadoFinal, "No se pueden cambiar ni agregar respuestas al terminar")

// No se puede responder con una opción de otra pregunta (no se editan respuestas previas).
let d = Cuestionario()
d.responder(d.preguntaActual!.opciones[0])
d.responder(bancoDePreguntas[0].opciones[1])
verificar(d.respuestas.count == 1 && d.indiceActual == 1, "Una opción de otra pregunta se ignora")

print(fallos == 0 ? "\nTodas las pruebas pasaron" : "\nFallos: \(fallos)")
exit(fallos == 0 ? 0 : 1)
