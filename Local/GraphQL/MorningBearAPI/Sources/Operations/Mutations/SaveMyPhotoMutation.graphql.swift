// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SaveMyPhotoMutation: GraphQLMutation {
  public static let operationName: String = "SaveMyPhoto"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      mutation SaveMyPhoto($input: PhotoInput) {
        saveMyPhoto(photoInput: $input) {
          __typename
          photoLink
          updatedBadge {
            __typename
            badgeId
            badgeTitle
            badgeDesc
          }
        }
      }
      """
    ))

  public var input: GraphQLNullable<PhotoInput>

  public init(input: GraphQLNullable<PhotoInput>) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Mutation }
    public static var __selections: [Selection] { [
      .field("saveMyPhoto", SaveMyPhoto?.self, arguments: ["photoInput": .variable("input")]),
    ] }

    ///  내 사진 저장 (뱃지이벤트 발생) 
    public var saveMyPhoto: SaveMyPhoto? { __data["saveMyPhoto"] }

    /// SaveMyPhoto
    ///
    /// Parent Type: `Photo`
    public struct SaveMyPhoto: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.Photo }
      public static var __selections: [Selection] { [
        .field("photoLink", String?.self),
        .field("updatedBadge", [UpdatedBadge?]?.self),
      ] }

      ///  사진 링크 
      public var photoLink: String? { __data["photoLink"] }
      ///  신규 획득 뱃지 
      public var updatedBadge: [UpdatedBadge?]? { __data["updatedBadge"] }

      /// SaveMyPhoto.UpdatedBadge
      ///
      /// Parent Type: `Badge`
      public struct UpdatedBadge: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.Badge }
        public static var __selections: [Selection] { [
          .field("badgeId", String?.self),
          .field("badgeTitle", String?.self),
          .field("badgeDesc", String?.self),
        ] }

        ///  뱃지 ID 
        public var badgeId: String? { __data["badgeId"] }
        ///  뱃지 타이틀 
        public var badgeTitle: String? { __data["badgeTitle"] }
        ///  뱃지 설명 
        public var badgeDesc: String? { __data["badgeDesc"] }
      }
    }
  }
}
