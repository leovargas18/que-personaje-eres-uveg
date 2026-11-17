import Foundation

// Cada respuesta "suma un punto" a uno de estos personajes.
enum Personaje: String, CaseIterable {
    case ironMan = "Iron Man"
    case capitanAmerica = "Capitán América"
    case thor = "Thor"
    case spiderMan = "Spider-Man"

    var descripcion: String {
        switch self {
        case .ironMan:
            return "Eres ingenioso, creativo y seguro de ti mismo. Te encanta resolver problemas con tecnología e inventiva, y tu humor te ayuda a salir de cualquier aprieto."
        case .capitanAmerica:
            return "Eres íntegro, leal y un líder natural. Pones al equipo por delante, defiendes tus principios y nunca te rindes aunque las cosas se pongan difíciles."
        case .thor:
            return "Eres valiente, enérgico y generoso. Entras con fuerza a cada reto, disfrutas la vida en compañía y proteges a quienes quieres sin pensarlo dos veces."
        case .spiderMan:
            return "Eres amable, ocurrente y muy responsable. Sabes que un gran poder implica una gran responsabilidad y ayudas a los demás con optimismo y buen humor."
        }
    }
}

struct Opcion: Identifiable {
    let id = UUID()
    let texto: String
    let personaje: Personaje
}

struct Pregunta: Identifiable {
    let id = UUID()
    let texto: String
    let opciones: [Opcion]
}

// Colección principal: arreglo de 5 preguntas, cada una con su arreglo de opciones.
let bancoDePreguntas: [Pregunta] = [
    Pregunta(texto: "Es sábado por la tarde. ¿Qué plan eliges?", opciones: [
        Opcion(texto: "Armar o programar algo en mi taller", personaje: .ironMan),
        Opcion(texto: "Salir a correr y ayudar en una actividad comunitaria", personaje: .capitanAmerica),
        Opcion(texto: "Reunir a mis amigos para una gran fiesta", personaje: .thor),
        Opcion(texto: "Recorrer la ciudad y tomar fotos", personaje: .spiderMan)
    ]),
    Pregunta(texto: "Tu equipo enfrenta un problema inesperado. ¿Qué haces?", opciones: [
        Opcion(texto: "Con ingenio, diseño una solución nueva", personaje: .ironMan),
        Opcion(texto: "Organizo al grupo y reparto tareas con claridad", personaje: .capitanAmerica),
        Opcion(texto: "Me lanzo de frente a resolverlo", personaje: .thor),
        Opcion(texto: "Mantengo el buen ánimo y busco ayudar donde haga falta", personaje: .spiderMan)
    ]),
    Pregunta(texto: "¿Qué cualidad valoras más en una persona?", opciones: [
        Opcion(texto: "La lealtad", personaje: .capitanAmerica),
        Opcion(texto: "La inteligencia", personaje: .ironMan),
        Opcion(texto: "La humildad y la responsabilidad", personaje: .spiderMan),
        Opcion(texto: "El valor", personaje: .thor)
    ]),
    Pregunta(texto: "¿Cómo te describen tus amigos?", opciones: [
        Opcion(texto: "Divertido y buen conversador", personaje: .spiderMan),
        Opcion(texto: "Carismático y un poco presumido", personaje: .ironMan),
        Opcion(texto: "Confiable y con valores firmes", personaje: .capitanAmerica),
        Opcion(texto: "Fuerte y de gran corazón", personaje: .thor)
    ]),
    Pregunta(texto: "¿Cuál sería tu mayor motivación?", opciones: [
        Opcion(texto: "Proteger a los que quiero", personaje: .thor),
        Opcion(texto: "Hacer lo correcto, cueste lo que cueste", personaje: .capitanAmerica),
        Opcion(texto: "Ayudar a mi comunidad con lo que sé hacer", personaje: .spiderMan),
        Opcion(texto: "Innovar y dejar un legado", personaje: .ironMan)
    ])
]
