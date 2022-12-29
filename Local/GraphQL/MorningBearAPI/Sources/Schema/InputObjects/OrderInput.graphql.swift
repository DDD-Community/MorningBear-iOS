// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

///  순서별 사진조회를 위한 입력데이터 
public struct OrderInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    size: GraphQLNullable<Int> = nil,
    orderType: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "size": size,
      "orderType": orderType
    ])
  }

  ///  조회할 사진 갯수 
  public var size: GraphQLNullable<Int> {
    get { __data["size"] }
    set { __data["size"] = newValue }
  }

  ///  순서타입 (1:생성일자asc, 2:생성일자:desc, 3:응원하기asc, 4:응원하기desc) 
  public var orderType: GraphQLNullable<String> {
    get { __data["orderType"] }
    set { __data["orderType"] = newValue }
  }
}
