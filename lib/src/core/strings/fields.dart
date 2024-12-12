class UserField {
  static const String name = 'name';
  static const String isStoreOwner = 'isStoreOwner';
  static const String profilePhoto = 'profilePhoto';
  static const String contactNumber = 'contactNumber';
}

class ProductField {
  static const String name = 'name';
  static const String store = 'store';
  static const String category = 'category';
  static const String description = 'description';
  static const String isBiddable = 'isBiddable';
  static const String isDeleted = 'isDeleted';
  static const String bidStart = 'bidStart';
  static const String bidEnd = 'bidEnd';
  static const String price = 'price';
  static const String displayImage = 'displayImage';
  static const String isPublished = 'isPublished';
  static const String duration = '_duration';
  static const String bid = 'bid';
  static const String isPurchased = 'isPurchased';
  static const String tags = 'tags';
}

class CategoryField {
  static const String name = 'name';
  static const String description = 'description';
  static const String store = 'store';
}

class ReviewField {
  static const String product = 'product';
  static const String user = 'user';
  static const String rating = 'rating';
  static const String message = 'message';
  static const String order = 'order';
}

class BidField {
  static const String product = 'product';
  static const String store = 'store';
  static const String amount = 'amount';
  static const String user = 'user';
  static const String id = 'id';
  static const String minPrice = 'minPrice';
}

class OrderField {
  static const String notes = 'notes';
  static const String amount = 'amount';
  static const String product = 'product';
  static const String status = 'status';
  static const String price = 'price';
  static const String total = 'total';
  static const String bid = 'bid';
  static const String user = 'user';
  static const String productCopy = 'productCopy';
}

class StoreField {
  static const String name = 'name';
  static const String address = 'address';
  static const String contactNumber = 'contactNumber';
  static const String displayImage = 'displayImage';
  static const String user = 'user';
  static const String description = 'description';
  static const String isPublished = 'isPublished';
  static const String facebook = 'facebook';
  static const String instagram = 'instagram';
  static const String whatsapp = 'whatsapp';
  static const String others = 'others';
  static const String isDeleted = 'isDeleted';
}
