import SwiftUI

struct ChannelsFilterView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var sortType: ChannelsViewModel.SortType
    @Binding var filterType: ChannelsViewModel.FilterType
    let sortTypes: [ChannelsViewModel.SortType]
    let filterTypes: [ChannelsViewModel.FilterType]
    
    var body: some View {
        VStack {
            Text("Sorting and Filtering")
                .bold()
                .padding(.top, 24)
            List {
                Section(header: Text("Sort by")) {
                    ForEach(sortTypes) { sortType in
                        Button(action: {
                            self.sortType = sortType
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            if sortType == self.sortType {
                                HStack {
                                    Text(sortType.displayText)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                }
                            } else {
                                Text(sortType.displayText)
                            }
                        })
                    }
                }
                Section(header: Text("Filter by")) {
                    ForEach(filterTypes) { filterType in
                        Button(action: {
                            self.filterType = filterType
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            if filterType == self.filterType {
                                HStack {
                                    Text(filterType.displayText)
                                    Spacer()
                                    Image(systemName: "checkmark")
                                }
                            } else {
                                Text(filterType.displayText)
                            }
                        })
                    }
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct ChannelsFilterView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelsFilterView(
            sortType: .constant(.subscribers),
            filterType: .constant(.all),
            sortTypes: ChannelsViewModel.SortType.allCases,
            filterTypes: ChannelsViewModel.FilterType.allCases
        )
    }
}
