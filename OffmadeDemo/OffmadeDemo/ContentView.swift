//
//  ContentView.swift
//  OffmadeDemo
//
//  Created by Syed Najam on 25/09/2020.
//

import SwiftUI

struct TestData : Hashable{
    var title: String
    var items: [String]
}

struct CustomerDetailsView: View {
    init(){
        UITableView.appearance().separatorColor = .clear
    }
    
    let mygroups = [
        TestData(title: "Overdue", items: ["1","2","3"]),
        TestData(title: "Today", items: ["1","2","3"]),
        TestData(title: "Tomorrow", items: ["A","B","C"]),
        TestData(title: "Upcoming", items: ["€","%","&"])
    ]
    
    var body: some View {
        List{
            VStack(alignment: HorizontalAlignment.leading){
                Text("Syed Najam")
                Text("Syed Najam Property GmbH")
            }
            HStack(alignment: VerticalAlignment.center){
                Image(systemName: "phone.fill")
                Text("+491783064032")
            }
            HStack(alignment: VerticalAlignment.center){
                Image(systemName: "envelope.fill")
                Text("hellofromnajam@gmail.com")
            }
            Text("Syed Najam is looking for good residential property deals in teir 1 and teir 2 in Berlin, Hamburg and Munich")
            VStack(alignment: HorizontalAlignment.leading){
                Text("Purchase price up to 10M")
                Text("Multiples up to 30-35 ok")
            }
            HStack(alignment: VerticalAlignment.center){
                Text("Remainders")
                Spacer()
                Image(systemName: "plus")
            }
            ForEach(self.mygroups, id: \.self) { gr in
                Section(header: Text(gr.title))
                {
                    ForEach(gr.items, id: \.self) { item in
                        Text(item)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerDetailsView()
    }
}
