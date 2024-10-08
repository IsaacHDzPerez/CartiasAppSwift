//
//  PremiosDetailView.swift
//  Caritas_iBorregOS
//
//  Created by Yolis on 16/09/24.
//
import SwiftUI

struct PremiosDetailView: View {
    var premio: Premio
    let blueC = Color(red: 0/255, green: 156/255, blue: 166/255)
    let darkBlueC = Color(red: 0/255, green: 59/255, blue: 92/255)
    let lightGreenC = Color(red: 209/255, green: 224/255, blue: 215/255)
    let whiteC = Color(red: 255/255, green: 255/255, blue: 255/255)
    
    var body: some View {
        ZStack {
            // Fondo verde para toda la vista
            lightGreenC
                .edgesIgnoringSafeArea(.all)
            
            // Parabola Invertida
            GeometryReader { geometry in
                Path { path in
                    let width = geometry.size.width
                    let height = geometry.size.height
                    
                    // Movimiento inicial del path
                    path.move(to: CGPoint(x: 0, y: height * 0.65)) // Baja la parábola
                    
                    // Dibuja la parábola
                    for x in stride(from: 0, to: width, by: 1) {
                        let y = height * 0.6 + (x - width / 2) * (x - width / 2) / (width * -0.9)
                        path.addLine(to: CGPoint(x: x, y: y))
                    }
                    
                    // Cierra el path
                    path.addLine(to: CGPoint(x: width, y: height))
                    path.addLine(to: CGPoint(x: 0, y: height))
                    path.closeSubpath()
                }
                .fill(LinearGradient(
                    gradient: Gradient(colors: [blueC, blueC]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
            }
            .edgesIgnoringSafeArea(.bottom) // Ignora el área segura en la parte inferior
            
            VStack(spacing: 20) {
                // Ícono del premio
                Image(systemName: premio.icono)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(blueC)
                
                // Nombre del premio
                Text(premio.nombre)
                    .font(.system(size: 28))
                    .bold()
                    .foregroundColor(darkBlueC)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                // Descripción del premio
                Text(premio.descripcion)
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Detalle del Premio")
    }
}

#Preview {
    PremiosDetailView(premio: Premio(nombre: "Café gratis en Oxxo", icono: "cup.and.saucer.fill", descripcion: "Disfruta de un café gratis en cualquier tienda Oxxo participante."))
}

