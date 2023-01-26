// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMyMorningPhotosQuery: GraphQLQuery {
  public static let operationName: String = "GetMyMorningPhotos"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query GetMyMorningPhotos($photoSize: Int = 4, $categorySize: Int = 5) {
        findMyInfo(sizeInput: {totalSize: $photoSize, categorySize: $categorySize}) {
          __typename
          photoInfo {
            __typename
            photoLink
            photoDesc
            photoId
          }
        }
      }
      """
    ))

  public var photoSize: GraphQLNullable<Int>
  public var categorySize: GraphQLNullable<Int>

  public init(
    photoSize: GraphQLNullable<Int> = 4,
    categorySize: GraphQLNullable<Int> = 5
  ) {
    self.photoSize = photoSize
    self.categorySize = categorySize
  }

  public var __variables: Variables? { [
    "photoSize": photoSize,
    "categorySize": categorySize
  ] }

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findMyInfo", FindMyInfo?.self, arguments: ["sizeInput": [
        "totalSize": .variable("photoSize"),
        "categorySize": .variable("categorySize")
      ]]),
    ] }

    ///  내정보 조회 (뱃지이벤트 발생) 
    public var findMyInfo: FindMyInfo? { __data["findMyInfo"] }

    /// FindMyInfo
    ///
    /// Parent Type: `User`
    public struct FindMyInfo: MorningBearAPI.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { MorningBearAPI.Objects.User }
      public static var __selections: [Selection] { [
        .field("photoInfo", [PhotoInfo?]?.self),
      ] }

      ///  사진 리스트 
      public var photoInfo: [PhotoInfo?]? { __data["photoInfo"] }

      /// FindMyInfo.PhotoInfo
      ///
      /// Parent Type: `Photo`
      public struct PhotoInfo: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.Photo }
        public static var __selections: [Selection] { [
          .field("photoLink", String?.self),
          .field("photoDesc", String?.self),
          .field("photoId", String?.self),
        ] }

        ///  사진 링크 
        public var photoLink: String? { __data["photoLink"] }
        ///  사진 설명 
        public var photoDesc: String? { __data["photoDesc"] }
        ///  사진ID 
        public var photoId: String? { __data["photoId"] }
      }
    }
  }
}
