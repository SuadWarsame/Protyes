//
//  HomePageView.swift
//  Protyes
//
//  Created by Suad Warsame on 18/04/2022.
//

import SwiftUI
import MapKit
import FirebaseFirestore

struct Place: Identifiable {
    let id = UUID()
    let name: String
    let cooridinate : CLLocationCoordinate2D
    
}


struct HomePageView: View {
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507351, longitude: -0.127758), latitudinalMeters: 5000, longitudinalMeters: 5000)
    
    
    
    
    @ObservedObject private var viewModel = ProtestViewModel()
    var body: some View {
        
        NavigationView{
            Map(coordinateRegion: $region, annotationItems: viewModel.cities) {
                cities in
                
                
                
                
                MapAnnotation(coordinate: cities.cooridinate ){
                    
                    NavigationLink{
                        
                        ZStack{
                            Color.red
                            
                            
                            VStack{
                                Text("WARNING!!!!")
                                    .padding()
                                    .background(Color(hex: "ffff00"))
                                    .foregroundColor(.black)
                                    .font(.system(size: 45, weight: .bold, design: .default))
                                
                                Text("-----Live Protest-----")
                                    .font(.largeTitle)
                                    .bold()
                                    .padding()
                                    .foregroundColor(.black)
                                Text("Start Location: " + cities.startLocation)
                                    .bold()
                                Text("Start Time: " + cities.startTime)
                                    .bold()
                                Text("End location: " + cities.endLocation)
                                    .bold()
                                Text("EndTime: " + cities.endTime)
                                    .bold()
                                Text(cities.name)
                                    .bold()
                                    .font(.title)
                                Spacer()
                                    .frame(width: 10, height: 10)
                                Text(cities.details)
                                    .multilineTextAlignment(.center)
                                
                                
                                Spacer()
                                    .frame(width : 100, height: 100)
                                
                            }
                            
                            
                        }
                        
                        
                    } label: {
                        
                        VStack{
                            Text("PROTEST")
                                .foregroundColor(Color.red)
                            
                            Circle()
                            
                                .stroke(.red, lineWidth: 5)
                                .frame(width: 47, height:47)
                                .background(Color.init(
                                    red: 100, green: 0, blue: 0, opacity: 0.3))
                                .cornerRadius(10)
                        }
                        
                        
                        
                    }
                }
                
                // Code that will be used to implement direction for map
                /**
                // NYC
                let p1 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 40.71, longitude: -74))

                // Boston
                let p2 = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 42.36, longitude: -71.05))

                let request = MKDirections.Request()
                request.source = MKMapItem(placemark: p1)
                request.destination = MKMapItem(placemark: p2)
                request.transportType = .automobile

                let directions = MKDirections(request: request)
                directions.calculate { response, error in
                  guard let route = response?.routes.first else { return }
                  mapView.addAnnotations([p1, p2])
                  mapView.addOverlay(route.polyline)
                  mapView.setVisibleMapRect(
                    route.polyline.boundingMapRect,
                    edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20),
                    animated: true)
                  self.directions = route.steps.map { $0.instructions }.filter { !$0.isEmpty }
                }
                
                */
                    
         
                
                
                
                
                
            }.ignoresSafeArea()
                .onAppear(){
                    self.viewModel.fetchCities()
                }
            
        }.navigationTitle("Protest info")
    }
    
    // Code that will be used to impplement direction for the map
    class MapViewCoordinator: NSObject, MKMapViewDelegate {
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .systemBlue
            renderer.lineWidth = 5
            return renderer
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
