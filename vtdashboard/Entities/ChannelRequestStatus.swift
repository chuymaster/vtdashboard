enum ChannelRequestStatus: Int, Codable {
  case unconfirmed = 1
  case accepted = 2
  case pending = 3
  case rejected = 4
}
