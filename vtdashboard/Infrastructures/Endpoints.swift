enum GetEndpoint: String {
    case getChannelList = "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/getChannelList"
    case getChannelRequestList = "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/getChannelRequestList"
}

enum PostEndpoint: String {
    case postChannelRequest = "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/postChannelRequest"
    case postChannel = "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/postChannel"
    case deleteChannel = "https://us-central1-thaivtuberranking-dev.cloudfunctions.net/deleteChannel"
}
