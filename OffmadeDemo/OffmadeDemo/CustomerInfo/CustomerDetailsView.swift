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
    
    @EnvironmentObject var customerDetailsData : CustomerDetailsData
    @State var isUpdating : Bool = false
    
    var body: some View {
        Group{
            if(self.customerDetailsData.isNetworking){
                ActivityIndicator.init(style: .medium)
            }
            else {
                List {
                    VStack(alignment: .leading, spacing: 12){
                        PersonalInfoView()
                        PropertyInfoView()
                        ReminderCreaterView()
                    }
                    ForEach(self.customerDetailsData.customerDetails!.reminderGroupList, id: \.self) { group in
                        Section(header: SectionView(reminderGroupName: self.customerDetailsData.getReminderGroupName(reminderStatus: group.status)))
                        {
                            ForEach(group.reminderList, id: \.self) { reminder in
                                RowView(reminderObject: reminder)
                            }
                        }.modifier(SectionHeaderStyle())
                    }
                }
            }
        }
        .accentColor(Color.customAccentColor)
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: Button("Edit", action: {
            print("Edit Details")
        }))
    }
}

struct PersonalInfoView : View {
    @EnvironmentObject var customerDetailsData : CustomerDetailsData
    
    var body : some View {
        VStack(alignment: .leading){
            Text(self.customerDetailsData.customerDetails!.customerPersonalInfo.firstName)
                .font(.largeTitle)
                .foregroundColor(Color.textBodyColor)
                +
                Text(" " + self.customerDetailsData.customerDetails!.customerPersonalInfo.lastName)
                .font(.largeTitle)
                .foregroundColor(Color.customAccentColor)
            Text(self.customerDetailsData.customerDetails!.customerPersonalInfo.companyName)
                .foregroundColor(Color.textSubHeadingColor)
        }
        Spacer().frame(height: 12)
        
        HStack(alignment: VerticalAlignment.center){
            Image(systemName: "phone.fill")
                .foregroundColor(Color.customAccentColor)
            Text(self.customerDetailsData.customerDetails!.customerPersonalInfo.phoneNumber)
                .foregroundColor(Color.textBodyColor)
        }
        HStack(alignment: VerticalAlignment.center){
            Image(systemName: "envelope.fill")
                .foregroundColor(Color.customAccentColor)
            Text(self.customerDetailsData.customerDetails!.customerPersonalInfo.emailAddress)
                .foregroundColor(Color.textBodyColor)
        }
        
        Spacer().frame(height: 12)
    }
}

struct PropertyInfoView : View {
    @EnvironmentObject var customerDetailsData : CustomerDetailsData
    
    var body : some View {
        Text(self.customerDetailsData.customerDetails!.customerPropertyInfo.description)
            .foregroundColor(Color.textBodyColor)
        Spacer().frame(height: 12)
        
        VStack(alignment: HorizontalAlignment.leading){
            Text(self.customerDetailsData.customerDetails!.customerPropertyInfo.purchasePrice)
                .foregroundColor(Color.textBodyColor)
            Text(self.customerDetailsData.customerDetails!.customerPropertyInfo.multiplePrice)
                .foregroundColor(Color.textBodyColor)
        }
        Spacer().frame(height: 12)
    }
}

struct ReminderCreaterView : View {
    @EnvironmentObject var customerDetailsData : CustomerDetailsData
    
    var body : some View {
        VStack(alignment: HorizontalAlignment.leading){
            HStack(alignment: VerticalAlignment.center){
                Text("Reminders")
                    .fontWeight(.bold)
                    .font(.title)
                    .foregroundColor(Color.textHeadingColor)
                Spacer()
                Image(systemName: "plus")
                    .foregroundColor(Color.customAccentColor)
                    .onTapGesture {
                        print("Create Reminder")
                    }
            }
            Spacer().frame(height: 24)
        }
    }
}

struct SectionView : View {
    var reminderGroupName : String
    
    var body : some View {
        HStack{
            Text(self.reminderGroupName)
                .font(.system(size: 18, weight: .semibold, design: .default))
        }
    }
}

struct SectionHeaderStyle: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 14, *) {
                AnyView(content.textCase(.none))
            } else {
                content
            }
        }
    }
}

struct RowView : View {
    
    @EnvironmentObject var customerDetailsData : CustomerDetailsData
    var reminderObject : ReminderObject
    
    var body : some View {
        Button {
            self.customerDetailsData.updateReminder(reminderObject: self.reminderObject)
        } label: {
            HStack(alignment: VerticalAlignment.center){
                Image(systemName: self.reminderObject.isCompleted ? "circle.fill" : "circle")
                    .frame(width: 20, height: 20)
                    .foregroundColor(Color.customAccentColor)
                VStack(alignment: HorizontalAlignment.leading){
                    Text(self.reminderObject.title)
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.textHeadingColor)
                    Text(self.reminderObject.address)
                        .font(.subheadline)
                        .fontWeight(.regular)
                        .foregroundColor(Color.textSubHeadingColor)
                        .frame(minHeight: 0, maxHeight: self.reminderObject.address == "" ? 0 : .infinity)
                }.padding(EdgeInsets.init(top: 8, leading: 8, bottom: 8, trailing: 8))
            }
        }
    }
}

struct ActivityIndicator: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        indicator.color = UIColor.init(red: 0/255, green: 128/255, blue: 255/255, alpha: 1)
        indicator.style = style
        return indicator
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        uiView.startAnimating()
    }
}
