//
//  DataDetail.swift
//  NotesCoreData
//
//  Created by Admin on 21.06.2021.
//

import SwiftUI



struct DataDetail: View {
    
        let datacore: EntityData
        @State  var dataTittle: String = ""
        @State  var data: String = ""
        let coreDM: CoreDataManager
        @Binding var needsRefresh: Bool
 
    var body: some View {
        VStack {
            Form{
                Section(header: Text("Заголовок").font(Font.system(size: 30)).bold()){
                    TextField(datacore.tittle ?? "", text: $dataTittle).font(Font.system(size: 25).bold())
                    
                    TextEditor(text: $data).frame(height: 525).font(Font.system(size: 20).italic())
                }
                .foregroundColor(.white)
            }
        }.navigationBarItems(trailing: HStack { Button(action: {
            let datastr = dataTittle + "\n" + data
            let av = UIActivityViewController(activityItems: [datastr], applicationActivities: nil)
            
            UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
        }, label: {
            Image(systemName: "square.and.arrow.up")
        })
        Button("Сохранить"){
            if !dataTittle.isEmpty {
                datacore.tittle = dataTittle
                coreDM.updateData()
                needsRefresh.toggle()
            }
            if !data.isEmpty {
                datacore.data = data
                coreDM.updateData()
                needsRefresh.toggle()
            }
            hidekeyboard()
        }
        }
        )
        .onAppear(){
            dataTittle = datacore.tittle!
            data = datacore.data!
        }
    }
    
}

struct DataDetail_Previews: PreviewProvider {
    static var previews: some View {
        let date = EntityData()
        let coreDM = CoreDataManager()
        DataDetail(datacore: date, coreDM: CoreDataManager(), needsRefresh: .constant(false))
    }
  
}

#if canImport(UIKit)
extension View{
    func hidekeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

