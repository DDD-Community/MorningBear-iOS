// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SaveMyInfoMutation: GraphQLMutation {
  public static let operationName: String = "SaveMyInfo"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      mutation SaveMyInfo {
        saveMyInfo {
          __typename
          accountId
          nickName
          photoLink
          memo
          wakeUpAt
        }
      }
      """
    ))

  public init() {}

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Mutation }
    public static var __selections: [Selection] { [
      .field("saveMyInfo", SaveMyInfo?.self),
    ] }

    ///  내정보 저장 (회원가입, 정보수정) 
    public var saveMyInfo: SaveMyInfo? { __data["saveMyInfo"] }

    /// SaveMyInfo
    ///
    /// Parent Type: `User`
    public struct SaveMyInfo: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.User }
      public static var __selections: [Selection] { [
        .field("accountId", String?.self),
        .field("nickName", String?.self),
        .field("photoLink", String?.self),
        .field("memo", String?.self),
        .field("wakeUpAt", String?.self),
      ] }

      ///  사용자ID 
      public var accountId: String? { __data["accountId"] }
      ///  닉네임 
      public var nickName: String? { __data["nickName"] }
      ///  프로필사진 링크 
      public var photoLink: String? { __data["photoLink"] }
      ///  자기소개글 
      public var memo: String? { __data["memo"] }
      ///  기상시간(format: HHmm) 
      public var wakeUpAt: String? { __data["wakeUpAt"] }
    }
  }
}
