import SwiftUI

struct AddChannelRequestView: View {
    @State private var channelId = ""
    @State private var channelType = ChannelType.original
    @State private var selectedChannelId: String!
    @StateObject var viewModel = AddChannelRequestViewModel()

    private let maxCharacterCount = 24

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                VStack {
                    TextField("Enter Channel ID", text: $channelId)
                        .font(.headline)
                    if isAbleToSubmit {
                        Text("Channel ID must begin with UC, must be exact 24 characters.")
                            .font(.callout)
                            .foregroundColor(.red)
                    }
                }
                .padding()

                ChannelTypePicker(channelType: $channelType)

                Button(action: {
                    viewModel.postChannelRequest(
                        id: channelId,
                        type: channelType
                    )
                }) {
                    Text("Submit")
                }
                .keyboardShortcut(.defaultAction)
                .disabled(isAbleToSubmit)

                // Sample channel ids
                List(sampleChannelIds, selection: $selectedChannelId) {
                    Text($0)
                }
                .listStyle(SidebarListStyle())
                .frame(maxHeight: 300)
                .cornerRadius(8)

                Spacer()
            }
            .padding()
            .alert(item: $viewModel.channelRequest) { channelRequest in
                Alert(
                    title: Text("Submission Completed"),
                    message: Text("\(channelRequest.title)\nType: \(channelRequest.type.displayText)"),
                    dismissButton: .default(Text("Close")
                    )
                )
            }
            .onChange(of: selectedChannelId, perform: { _ in
                channelId = selectedChannelId
            })
            .onChange(of: channelId) { _ in
                if channelId.count > maxCharacterCount {
                    channelId = String(channelId.prefix(maxCharacterCount))
                }
            }
            if viewModel.viewStatus == .loading {
                LoadingView()
                    .background(Color.black.opacity(0.5))
            }
        }
    }

    private var isAbleToSubmit: Bool {
        channelId.prefix(2) != "UC" || channelId.count != maxCharacterCount
    }
}

extension AddChannelRequestView {
    private var sampleChannelIds: [String] {
        [
            "UC2Llj9mfRcRTEjzuPiasXMw",
            "UCe1qGYHTmj0kkOdrevEkB5Q",
            "UCuWiL6tWtWxOgtgxs1S4Tog",
            "UCbGMUv2Elpovpi9WyWwv3Lw",
            "UCASukO4m2BR4uqZH0XlH1IA",
            "UC4ylYJJ0PeoKhqVQR6nwkdw",
            "UCsrpu8SrsKFBxlmpulDiWxw",
            "UCrUmEIK7jOgqVw5BPEDfQdQ",
            "UCj9cgH7xmBTQvKNKsHkLNJg",
            "UCPrUrBGBTNAki52OosDCTMQ",
            "UCaCZ78DoDsPxejb_azg1hog",
            "UCL9pGQHePabm2RkTgbFR7YQ",
            "UCwqiZ9PISzXH7I-g19Y6GjQ",
            "UCq97LOtWB1CgRVFzDF3FSSA",
            "UCw2tGTd6WmR26h-8F9ighyQ",
            "UCjr1VnM1LBRp9Ez2JGNndaA",
            "UCo6s7xKctpVwVwhYGpTtYmw",
            "UC-z7X8ICz1T-5gAJLgvYWCQ",
            "UCEAweQRj86ga-ymLA_L50BA",
            "UCO16Msf-IqFupuEiRYbmC7A",
            "UC6JIG9kjnF3ml6gLudTyzuA",
            "UCgq-rIElYiBFQnxgMnkojwg",
            "UCsO3bLRlRtET6FMH0KIWvYQ",
            "UCrZZ55RSNNZvURxjffvIDng",
            "UCsZSZCsOh_00oTBLdk2w-GA",
            "UCP9x4Ib5jyCiZTjcRY8HTsg",
            "UCi0lsSeXkSUuFwWTdhk73IA",
            "UC7mdtnzH9kw4sBoZvmfcI9Q",
            "UCym8-od2HnpvZvpOtKYKX3A",
            "UC3HM8L5j53x0WsliGNTXhbQ",
            "UCMQ21qN4qXA0sJf-kUK9ZjQ",
            "UCyMsZpmjEnQxpem3QEJ1G4Q",
            "UCBDddfQCn-MvvVbCIZKyp6g",
            "UCoOMJUZ5plQtVQDYbicD3dw",
            "UCUlyl-zRpqE1Dm0GYoKFEJw",
            "UCQeaVihiQ-X9LRda5WCYnRw",
            "UCV7dVXp53A48-Iwqg5BezQA",
            "UC25e5qEqvVaG_VKrkTmJBmw",
            "UCRG5fX1v4b-3sUyKfAAtxxA",
            "UCafG1bj6Qtcbn4bozcicWfA",
            "UCZilc7jP-X_92Fii1uTIs0Q",
            "UCC5q6CpuDflPvO7pNn52RGQ",
            "UC0tRnxwQh4pDp5zeb9upjuA",
            "UCafr8HG8gXERkYav9g2dnEA",
            "UCSUnEj1cNGH9BWGxC6tRfbA",
            "UCzcxUVey7vDU6NqDaXwZG5w",
            "UCUR0HEtdHk4nx2WddW0Qthg",
            "UCc31qMp87wZnOpcxkQB7Prw",
            "UCH9YSRP3hG56bs2lzmMoOVw",
            "UCSqQDeXi3tLW_MyHnwTgvDA",
            "UCRk9GF8RknJ1tfcgP2Rr2Vw",
            "UClVffjMBRRev_all-ck6ORQ",
            "UCxn_EkDl0yi45LN2H00ddiQ",
            "UC4Fkmiz9A1QS-cEtCWCYuLA",
            "UCqDxa29yqHeXRMEPTj1ABjg",
            "UCGofntRkNUAgXGqimLtLy4g",
            "UCSfTLTP8ER3HNeh9jJGWVmw",
            "UCi2T9exDdJRTsxL1vnNV9gQ",
            "UC3KjwdPTH3FVpmzWvMFUA0Q",
            "UCbbRx6_XRv4v8gz7JWiauQA",
            "UCSI6HCL4gOzpul9r2WQwA1A",
            "UCt5fJ2gphb_K1IglT7WI0aQ",
            "UCrh0bkfe_0_jvZifi8l1CYQ",
            "UCVd5BmqL0n6Q04gvL-hK83A",
            "UCnZdtcYU8g506lNg5j3cKcw",
            "UCZADy95eqIHEiRbtFrAC3Qw",
            "UCWL4Qo2BSKwg7Yoyjuz6Kmg",
            "UCi_GXDmNCRLOskSl55P1RIg",
            "UCNi7vaX3mNQZN_PR-IdMO8g",
            "UC0UOTf43S-4ieBx9rbMyBFw",
            "UCSmwbpH_ZvRCn8-gbggGfTw",
            "UCs4PHAfrL6I2CkAk7JJ4mfQ",
            "UChNALrBJanqhbKasT0tgajQ",
            "UClbr2Ml5EXjoAysIGi65z4w",
            "UCZxNaWG_8Br9q1eTLSG5wPg",
            "UCAKxVqeGyZTrxYwg3p3xUAg",
            "UCHmUwOAToMBgtxMFXf-S2Zg",
            "UCX5Qv6nz_HUVKtaDiMEReyQ",
            "UC5wA30Tc9ONbRjj6QNinH9w",
            "UCQsrKHkR4lZpdKVL8QOgtgg",
            "UCAnKhwx493i5myddnJFF_gg",
            "UCMvc8BlQ7r5gRbz-D2EY0LA",
            "UCSdV0wKlfljMvRY3mFVn1ZQ",
            "UCYu6pahmFwIki35ru8s62pQ",
            "UCFbk4JLjlwRZYz0GqmMbTsA",
            "UCovQLEvnxcHmKD4rkA7j56w",
            "UCbeaB9MoD9IyXqBshyQuNRQ",
            "UCESGs2FOHGZDFV4hUaRCc8Q",
            "UCutCJNu6FRZPjEqGkL08Xpg",
            "UCbqKYHQfc1WIOPgnFnPURqA",
            "UCrp_xrGOIkztfLIOMR2FrWQ",
            "UCxcmm1lpyL1Z3o7SgPAM1nw",
            "UCRtX1_Nq7m18iyX2fKPTusg",
            "UCl_ojvzR1_p8SuI-M8uikvA",
            "UC3RN10yz3DBh7ERYALvd8xA",
            "UC84SKy5FIxebyG-zSeBaQig",
            "UChSIHEGwvsjE5MRS62Xd-PA",
            "UC64_YFnoPvaGUSv4fpozr1w",
            "UCOzFeOVoXq-E_8ClgO16msg",
            "UCUUiRsJXOGaGUMsgwX1h_5g",
            "UCbD0eVN3O-T7iBszxoBYwdA",
            "UCEIng584JuWYJeU2gl3cN5Q",
            "UCzz6lqaIDORJBRli-4E2RoA",
            "UCL2NpEQLGrC8H3hxD2JPa5A",
            "UCM69uU9b_raR3mcACHeivgg",
            "UCqhhWjpw23dWhJ5rRwCCrMA",
            "UC7iCSRt7Jej2XE0MaM9gPgg",
            "UCgXcfaWl68A1gHWm4AiJXAQ",
            "UCklpP4KpgJdCfz4XVe0Nhvg",
            "UCzOlFrxT8PsxRRA5E4MiMUQ",
            "UC1xmO5jVjOCeo02XCpq4WFA",
            "UCjQxLH9yqYXowVtH7a-6L-Q",
            "UC7uttDpQDJ3bdnU8u8gZzbQ",
            "UC8iTIbRueIONUDDgHN74JHw",
            "UCCptqrhEdtJGBer1qWWRLnA",
            "UCK8GmjIUCbl_qlRCfAR3yaA",
            "UCTIi4NC8SvzUZDMExjCscVA",
            "UCJV_fi2dwgLJLLkIIzsT4hg",
            "UCMDaeugSCq7jNvWma9pa0ZQ",
            "UC5TnSrUJmrC_KFW9VLi37lA",
            "UCzFS0V-m_b71n8Y1fDdJ2og",
            "UCRkQWBz3Vdp-24_Xqxuqd8Q",
            "UC2YSL7miphgLmRxlgpS7_MA",
            "UChSGIJlrLUI1UVds38w2Obg",
            "UC8cpV2XY6w58Ftbx_yMBc6w",
            "UCwtyxO7B0xIv3XdtSvdnYgQ",
            "UCY8j33h1epfkBEkIv_K5WKg",
            "UCY3reV-jwagniwcghy1B4VA",
            "UC6LqeYbc-0mQiYwFjhdU13Q",
            "UCUaCBBJSOS6Ph2KYbNvzVYw",
            "UC4QiJt8a2VjOnwI-0zzMsKA",
            "UCgxuLWOuU5QX8ReEFthb_lA",
            "UCPHqJsNtOp94Vcol4DPKpSA",
            "UC-7KSYyqZ5FthXGj4R1nVbw",
            "UCnX9yNE_8q2vusipjM0fBwQ",
            "UCZ-Vbihp3Y84EzwVVd2GjDQ",
            "UCxI2vEES81ViqI4xs7dnsnA",
            "UCatSdbBdnsXgFpCyhJ7jYGg",
            "UCpWq_pummdoTXbak8IvVmdg",
            "UCIWrMTsjxdx_V1zlBkbCVCg",
            "UCd7zrPvuQfxazqo0OEyP61A",
            "UCMvIUZRjMYx-_U7_RRlQYqw",
            "UCAvQO1F-w6NELewvcDFupmw",
            "UCRSZSfoxu6jnk5zAXlYnJPw",
            "UCXC_P051Pv6Xqg4y4CaEAvg",
            "UCUlc9fwNihOqufbS8KtakvA",
            "UC7rJN7zzIdUfNogj1RnTXDw",
            "UCqSPXvXSVNfliGgYFK_zyrw",
            "UCJi1l4gH7X-T8x691agd-vA",
            "UCPKp1agiHSOwu9iPyb6WSNw",
            "UC2GaO3oPD_bkDMtLLRHnJgw",
            "UCDVOWB_Fi5jmi6o-x5_uV8g",
            "UChRfiMqGglF5G8UPx459Jyw",
            "UCus7FjtV4qGWS1v1GIhfZaQ",
            "UCRldXR7ASrCYYoxeqOU-_og",
            "UCmYqCn77fIefPd9kKmr6uZg",
            "UCcFZXKIA6gzGlYM0Tw9vHHw",
            "UCRcoD-ROesW13Ts-dbS8HrQ",
            "UCthmrmfVix2WgS-Ti6z15hQ",
            "UCeq0Jc2hnAGXS3HlL3mcVLg",
            "UCD01RbTscZLD96_EH0IppUQ",
            "UCI5veUArsBxUb6mnEvzIVLQ",
            "UCe33CjMy_3DqvmKMMqEjWDQ",
            "UCMnBPmFw-N8oDDAWbH-qI-g",
            "UClidlxHAam6YxJ8FpUQA00w",
            "UCI9bNMcvSiuq-bfjsPNomTA",
            "UCJJMZyWjnIiHGsgoZ38kkjA",
            "UCOuX_UFS7o1y-JJN7cmHl1A",
            "UCCTYtSYAVFLD4SX5UK4q3uA",
            "UCFRCQhHa_MUmmRaGUJVN8zA",
            "UCO8YcEfbe_-_WlX9QTU6b0Q",
            "UCR4Vap93GIkE4zA4DrMW-Rw",
            "UCcTIykGFVlYtUdGQvCeBcrw",
            "UCzN8bPvb3UmK06aSWz-tMzg",
            "UCjiIfHN3nlU80_DgNz-5qlA",
            "UCW38XRIWkNf30cD_cR7-rnA",
            "UC-Aeb9vtgxtnI8oXQqe7PAQ",
            "UCmVx2k5Qcsmk8qGbZEBZGCw",
            "UCs79Ia6_ENS65tgHXXVOdcg",
            "UCxjyNnknbCKvcdMAcb6PwOg",
            "UCyiOVvjoIRv1MYPb3vLlkBQ",
            "UC4WS6eqGJEYIKx_LXck50-A",
            "UCASVAAgvntOrwRgVeMAkIPg",
            "UCpNAFq_PANbmcdfhzfuiekA",
            "UCdxaZWWFBl3N7Ollc3EwZAw",
            "UCOQXDZCXXd-05ikdDsNaPEQ",
            "UCJTNslIwBlF8cN1MlaE8lag",
            "UCrA099iIdepLcZeV_5kzWdw",
            "UCA_7kXlC8oEYWhQA-dsmIeQ",
            "UC6KTB79XRwx_iwxnrIEvHQA",
            "UCUmOIR6U5fNCQFwMAEmWgcA",
            "UCtsEaaHljOuH3QP4K8rgSnA",
            "UCJXlFtYerJIIjyy909fetZw",
            "UCpuk3ld3rGWSsLOhuVlOFBQ",
            "UCDFrQa0uUmXb6lyQJGUAVlA",
            "UCzM-6yhdmR4UGS_g_zzSf5Q",
            "UCSUHC7ieLr0RqhoBpcNhmsg",
            "UCs00yKfnpd0ngpCFKndfAlQ",
            "UCnmykXkj5SVMQf75oyp7Lkg",
            "UCZaSPX01M1dxGWdSF_86Isg",
            "UCoVpEObbNlG_AVSz-K8yYTg",
            "UCxovguri_Dmb3HaVeKEpVSA",
            "UC7DRj5BKL5aKU3Zf91BQ3uw",
            "UCN2uHnFKm8CTbjFQ9H7Uotg",
            "UC-ZDJww4irljOotrkMG0FeA",
            "UCAj8NHkWEqbJ2er8Umbpoog",
            "UCHJk8SH7iceSkCmXs6Fdn_A",
            "UC0zhAPKBZfAvvG57VgSLImw",
            "UC_nmh9XycGlquouvai2UC6g",
            "UCompe4fS2oUss8CGTuhOSxA",
            "UCeijqgCP9z3zLJ-uwQzvFtQ",
            "UCnfKwU2JKvFnZzjQGmzM2Kw",
            "UC6kSf58pZ2Ej71Ti4TZG_yQ",
            "UCmxm8HxZwbd4dx_xjYi9acw",
            "UC1z-ybaAe5LYfcnDdzp9SGw",
            "UCiZG4hoElnNYefqCSu5MC5A",
            "UCx0pDLDiZ3RXDXYtrXkaMMw",
            "UCxNhn7OIhxQkISOi1x3JTFg",
            "UCr7Xw3BfDCcPBh9pFvOyCBw",
            "UC5VPIoY1j_x9UZSqkpwg8jw",
            "UC8lQ60XP8szvj0GHwxYUS2Q",
            "UCFGVSlxuE9EmL2L70_YfIgw",
            "UCDYy9EVjkBym7bUYwTKzugA",
            "UCGBkYTR4tMKS38TQHGWWLjg",
            "UCyAprfLmhKS8zLRZRaCyi5A",
            "UC0C_CplF_fwd1hEZuIE6VIw",
            "UC19G1A17yxePMyLJqcNBN7Q"
        ]
    }
}

struct AddChannelRequestView_Previews: PreviewProvider {
    static var previews: some View {
        AddChannelRequestView(
            viewModel: .init(networkClient: MockNetworkClient()
            )
        )
    }
}
