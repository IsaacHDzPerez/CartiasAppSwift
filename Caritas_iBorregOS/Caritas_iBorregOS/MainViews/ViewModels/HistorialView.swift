import SwiftUI

struct HistorialView: View {
    @State private var selectedSegment = 0
    @State private var events: [EVENTOS] = []
    @State private var retos: Array<RETOS> = []
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                HStack { Spacer() }
                Spacer()
                
                Text("Historial")
                    .font(.system(size: 35))
                    .bold()
                    .foregroundColor(darkBlueC)
                    .padding()
                
                // Barra de selección
                Picker("", selection: $selectedSegment) {
                    Text("Eventos").tag(0)
                    Text("Retos").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                Divider()
                    .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        
                    }
                    .padding()
                    if selectedSegment == 0 {
                        // Dynamically fetch and display events
                        if !events.isEmpty {
                            ForEach(events) { evento in
                                NavigationLink {
                                    EventDetailView(event: evento)
                                } label: {
                                    EventCardView(event: evento)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(.black)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            }
                        } else {
                            // Display loading or error message
                            if let errorMessage = errorMessage {
                                Text("No has completado ningún evento")
                                    .foregroundStyle(pinkC)
                                    .bold()
                                    .font(.system(size: 20))
                            } else {
                                Text("No has completado ningún evento")
                                    .foregroundStyle(pinkC)
                                    .bold()
                                    .font(.system(size: 20))
                            }
                        }
                    } else {
                        // Historial de Retos
                        if !retos.isEmpty {
                            ForEach(retos) { reto in
                                NavigationLink {
                                    RetoDetailView(retoX: reto)
                                } label: {
                                    RetoCardView(RetoX: reto)
                                        .multilineTextAlignment(.leading)
                                        .foregroundStyle(.black)
                                }
                                .padding(.vertical, 5)
                                .padding(.horizontal)
                            }
                        } else {
                            // Display loading or error message for retos
                            if let errorMessage = errorMessage {
                                Text("No has completado ningún reto")
                                    .foregroundStyle(pinkC)
                                    .bold()
                                    .font(.system(size: 20))
                            } else {
                                Text("No has completado ningún reto")
                                    .foregroundColor(darkBlueC)
                            }
                        }
                    }
                }
                .background(lightGreenC)
            }
            .navigationBarBackButtonHidden(true) // Ocultar el botón de regreso predeterminado
            .navigationBarItems(leading: Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    HStack {
                        Image(systemName: "chevron.backward") // Cambia esto por el ícono que desees
                            .font(.system(size: 20))
                            .foregroundColor(blueC)// Ajusta el tamaño del ícono según sea necesario
                        Text("Volver")
                            .font(.headline)
                        .foregroundColor(blueC)// Puedes ajustar la fuente según tus preferencias
                    }
                })
            .background(lightGreenC)
            .onAppear {
                Task {
                    do {
                        let fetchedEvents = try await fetchUserCompletedEvents(usuarioID: UserDefaults.standard.integer(forKey: "usuario_id"))
                        events = fetchedEvents
                        let fetchedRetos = getCompletedRETOSList(userID: UserDefaults.standard.integer(forKey: "usuario_id"))
                        retos = fetchedRetos
                    } catch {
                        errorMessage = "Failed to fetch events: \(error.localizedDescription)"
                    }
                }
            }
        }
    }
}

#Preview {
    HistorialView()
}
