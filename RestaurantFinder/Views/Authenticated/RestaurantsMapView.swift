//
//  RestaurantsMapView.swift
//  RestaurantFinder
//
//  Created by Ahmad Ardal on 2022-11-03.
//

import SwiftUI
import MapKit

struct RestaurantsMapView: View {
    
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    @Binding var viewOnMap: Bool
    
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 59.325300386430435, longitude: 18.06622395719864), span: MKCoordinateSpan(latitudeDelta: 0.30, longitudeDelta: 0.25))
    
    @State var selectedRestaurant: Restaurant?
    
    var body: some View {
        
        Map(coordinateRegion: $region, annotationItems: dbConnection.restaurantList) {
            restaurant in
            
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: restaurant.longitude, longitude: restaurant.latitude), content: {
                Button(action: {
                    selectedRestaurant = restaurant
                }, label: {
                    VStack {
                        
                        ZStack {
                            Circle().fill(.black).frame(width: 35, height: 35)
                            Image(systemName: "carrot").foregroundColor(.white)
                        }

                        Text(restaurant.title).bold().foregroundColor(.black)
                    }
                })

            })
            
        }.ignoresSafeArea().onTapGesture {
            selectedRestaurant = nil
        }.overlay(alignment: .bottom, content: {
            
            VStack  {
                if let selectedRestaurant = selectedRestaurant {
                 
                    NavigationLink(destination: RestaurantView(restaurant: selectedRestaurant), label: {
                        RestaurantCard(restaurant: selectedRestaurant, isMini: true).padding()
                    })
                    
                }
                
                Button(action: {
                    viewOnMap.toggle()
                }, label: {
                    Text("View on list").padding().background(.black).foregroundColor(.white).cornerRadius(9)
                })
            }
            
        })
        
    }
}

struct RestaurantsMapView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsMapView(viewOnMap: .constant(true)).environmentObject(DatabaseConnection())
    }
}
