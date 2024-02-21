//
//  ParkView.swift
//  PORApp
//
//  Created by ituser on 1/31/24.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct ParkView: View {
    var park : Park
    
    @State var locations: [Location] = []
    
    // Default region for the map view.
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    //please make it looks better
    var body: some View {
        ScrollView {
            VStack {
                
                Map(coordinateRegion: $region, annotationItems: locations) { location in
                    
                    MapMarker(coordinate: location.coordinate)
                        
                }
                .frame(height: 500)
            
                HStack {
                    Text(park.addressEn)
                        .font(.headline)
                }
                HStack{
                    Button(action: {
                        
                        let destinationCoordinates = park.coordinate
                        
                        // Create a MKMapItem from the coordinates.
                        let placemark = MKPlacemark(coordinate: destinationCoordinates, addressDictionary: nil)
                        let mapItem = MKMapItem(placemark: placemark)
                        
                        // Set the launch options for the navigation mode.
                        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
                        
                        // Open in Maps app and start navigation.
                        mapItem.openInMaps(launchOptions: launchOptions)
                        
                    },
                           label: {
                        Label("Navi", systemImage: "bus.doubledecker.fill")
                        
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.gray)
                }
                }
                Text(park.facilitiesEn.replacingOccurrences(of: "<br />", with: "\n\n"))
                    .padding()
            }
        .navigationTitle(park.nameEn)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print("park: \(park)")
            
            let location = Location(name: park.nameEn, coordinate: CLLocationCoordinate2D(latitude: Double(park.latitude.toDecimalDegrees() ?? 0.0 ) ?? 0.0 , longitude: Double(park.longitude.toDecimalDegrees() ?? 0.0) ?? 0.0 ))
            
            region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: Double(park.latitude.toDecimalDegrees() ?? 0.0 ) ?? 0.0 , longitude: Double(park.longitude.toDecimalDegrees() ?? 0.0) ?? 0.0 ),
               span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            locations.append(location)
        }
    }
}


struct ParkView_Preview : PreviewProvider {
    static var previews: some View {
        NavigationStack {
            ParkView(park: Park(districtEn: "Navigator", districtCn: "Navigator",
                                nameEn: "Navigator", nameCn: "Navigator",
                                addressEn: "Address", addressCn: "Address",
                                gihs: "Address",
                                facilitiesEn: "Address Details", facilitiesB5: "Address Details",
                                phone: "p0",
                                photo1: "p1",
                                photo2: "p2",
                                photo3: nil,
                                photo4: nil,
                                longitude: "22.3",
                                latitude: "114.5"))
        }
    }
}
