// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetMyPageDataQuery: GraphQLQuery {
  public static let operationName: String = "GetMyPageData"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query GetMyPageData {
        findMyInfo(sizeInput: {totalSize: 10, categorySize: 10}) {
          __typename
          takenLikeCnt
          photoLink
          nickName
          categoryList {
            __typename
            categoryId
            categoryDesc
          }
          badgeList {
            __typename
            badgeId
          }
          reportInfo {
            __typename
            countSucc
          }
          photoInfoByCategory {
            __typename
            photoInfo {
              __typename
              categoryId
              photoId
              photoLink
            }
          }
        }
      }
      """
    ))

  public init() {}

  public struct Data: MorningBearAPI.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { MorningBearAPI.Objects.Query }
    public static var __selections: [Selection] { [
      .field("findMyInfo", FindMyInfo?.self, arguments: ["sizeInput": [
        "totalSize": 10,
        "categorySize": 10
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
        .field("takenLikeCnt", Int?.self),
        .field("photoLink", String?.self),
        .field("nickName", String?.self),
        .field("categoryList", [CategoryList?]?.self),
        .field("badgeList", [BadgeList?]?.self),
        .field("reportInfo", ReportInfo?.self),
        .field("photoInfoByCategory", [PhotoInfoByCategory?]?.self),
      ] }

      ///  받은 응원하기 리스트 Count 
      public var takenLikeCnt: Int? { __data["takenLikeCnt"] }
      ///  프로필사진 링크 
      public var photoLink: String? { __data["photoLink"] }
      ///  닉네임 
      public var nickName: String? { __data["nickName"] }
      ///  설정한 카테고리 리스트 
      public var categoryList: [CategoryList?]? { __data["categoryList"] }
      ///  획득 뱃지 리스트 
      public var badgeList: [BadgeList?]? { __data["badgeList"] }
      ///  리포트정보 
      public var reportInfo: ReportInfo? { __data["reportInfo"] }
      ///   사진 리스트 (카테고리별) 
      public var photoInfoByCategory: [PhotoInfoByCategory?]? { __data["photoInfoByCategory"] }

      /// FindMyInfo.CategoryList
      ///
      /// Parent Type: `Category`
      public struct CategoryList: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.Category }
        public static var __selections: [Selection] { [
          .field("categoryId", String?.self),
          .field("categoryDesc", String?.self),
        ] }

        ///  카테고리 ID 
        public var categoryId: String? { __data["categoryId"] }
        ///  카테고리 명칭 
        public var categoryDesc: String? { __data["categoryDesc"] }
      }

      /// FindMyInfo.BadgeList
      ///
      /// Parent Type: `BadgeDetail`
      public struct BadgeList: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.BadgeDetail }
        public static var __selections: [Selection] { [
          .field("badgeId", String?.self),
        ] }

        ///  뱃지 ID 
        public var badgeId: String? { __data["badgeId"] }
      }

      /// FindMyInfo.ReportInfo
      ///
      /// Parent Type: `Report`
      public struct ReportInfo: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.Report }
        public static var __selections: [Selection] { [
          .field("countSucc", Int?.self),
        ] }

        ///  성공횟수 
        public var countSucc: Int? { __data["countSucc"] }
      }

      /// FindMyInfo.PhotoInfoByCategory
      ///
      /// Parent Type: `PhotoByCategory`
      public struct PhotoInfoByCategory: MorningBearAPI.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { MorningBearAPI.Objects.PhotoByCategory }
        public static var __selections: [Selection] { [
          .field("photoInfo", [PhotoInfo?]?.self),
        ] }

        ///  사진정보 
        public var photoInfo: [PhotoInfo?]? { __data["photoInfo"] }

        /// FindMyInfo.PhotoInfoByCategory.PhotoInfo
        ///
        /// Parent Type: `Photo`
        public struct PhotoInfo: MorningBearAPI.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ParentType { MorningBearAPI.Objects.Photo }
          public static var __selections: [Selection] { [
            .field("categoryId", String?.self),
            .field("photoId", String?.self),
            .field("photoLink", String?.self),
          ] }

          ///  카테고리ID 
          public var categoryId: String? { __data["categoryId"] }
          ///  사진ID 
          public var photoId: String? { __data["photoId"] }
          ///  사진 링크 
          public var photoLink: String? { __data["photoLink"] }
        }
      }
    }
  }
}
