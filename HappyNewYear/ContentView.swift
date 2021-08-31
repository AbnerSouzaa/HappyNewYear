//
//  ContentView.swift
//  TestProject
//
//  Created by Abner Souza on 29/08/21.
//

import SwiftUI


class Counter: ObservableObject {
    
    @Published var seconds = 0
    @Published var hours = 0
    @Published var days = 0
    @Published var minutes = 0
    
    init() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){timer in
            //turned on each second

            
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            print(currentDate)
        
            var eventDateComponents = DateComponents()
            eventDateComponents.year = 2022
            eventDateComponents.month = 1
            eventDateComponents.day = 1
            eventDateComponents.hour = 0
            eventDateComponents.minute = 0
            eventDateComponents.second = 0
            
            let eventDate = calendar.date(from: eventDateComponents)
            print(eventDate)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!) // timeleft to event day
            
            self.days = timeLeft.day ?? 0
            self.hours = timeLeft.hour ?? 0
            self.minutes = timeLeft.minute ?? 0
            self.seconds = timeLeft.second ?? 0
            //print( day)
        }
    }
    
}
struct ContentView: View {
    
    @StateObject var counter = Counter()
    var body: some View {
        VStack {          //vertical
            
            HStack {               //horizontal
                Text(" \(counter.days) Days")
                Text("\(counter.hours) Hours")
                Text("\(counter.minutes) mins")
                Text("\(counter.seconds) sec")
            }
            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
