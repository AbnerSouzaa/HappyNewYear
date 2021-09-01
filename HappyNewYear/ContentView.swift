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
    
    var selectedDate = Date()
    
    init() {
        
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true){timer in
            //turned on each second

            
            let calendar = Calendar.current
            
            let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date())
            
            let currentDate = calendar.date(from: components)
            print(currentDate)
            
            let selectedComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self.selectedDate)
        
            var eventDateComponents = DateComponents()
            eventDateComponents.year = selectedComponents.year
            eventDateComponents.month = selectedComponents.month
            eventDateComponents.day = selectedComponents.day
            eventDateComponents.hour = selectedComponents.hour
            eventDateComponents.minute = selectedComponents.minute
            eventDateComponents.second = selectedComponents.second
            
            let eventDate = calendar.date(from: eventDateComponents)
            print(eventDate)
            
            let timeLeft = calendar.dateComponents([ .day, .hour, .minute, .second], from: currentDate!, to: eventDate!) // timeleft to event day
            
            if (timeLeft.second! >= 0) {
                
            self.days = timeLeft.day ?? 0
            self.hours = timeLeft.hour ?? 0
            self.minutes = timeLeft.minute ?? 0
            self.seconds = timeLeft.second ?? 0
            
            }
        }
    }
    
}
struct ContentView: View {
    
    @StateObject var counter = Counter()
    var body: some View {
        VStack {          //vertical
            
            DatePicker(selection: $counter.selectedDate, in: Date()..., displayedComponents: [.hourAndMinute, .date]) {
                Text("Selecione uma data: ")
            }
            
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
