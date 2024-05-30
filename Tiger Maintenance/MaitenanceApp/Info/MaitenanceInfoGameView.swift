import SwiftUI

struct MaitenanceInfoGameView: View {
    
    @Environment(\.presentationMode) var ppresentationMode
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    ppresentationMode.wrappedValue.dismiss()
                } label: {
                    Image("close_bttn")
                        .resizable()
                        .frame(width: 70, height: 70)
                }
                Spacer().frame(width: 24)
                Image("info_title")
                    .resizable()
                    .frame(width: 160, height: 60)
                Spacer()
            }
            .padding()
            
            ZStack {
                Image("info_content_bg")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width)
                Text("Hi! I need your help. I'm Tiger Chef and I just opened a new restaurant. But I don't have enough paws to serve all the customers. I hope we can do better with you! Don't worry, I'm not forcing you to work for free. At the end of each day, I'll pay you according to how many customers you've served and how fast. And yes, your job will be to serve the customers who come to us. Choose the right dishes and the right guest. All customers have patience. No one wants to wait too long for their order. And if you do a good job, maybe someone will even leave you a tip! Good luck to us!")
                    .frame(width: 280)
                    .multilineTextAlignment(.center)
                    .font(.custom("Jost-Regular", size: 17))
                    .offset(y: -40)
                Image("character_img")
                    .resizable()
                    .frame(width: 250, height: 200)
                    .offset(y: 270)
            }
        }
        .background(
            Image("info_bg")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    MaitenanceInfoGameView()
}
