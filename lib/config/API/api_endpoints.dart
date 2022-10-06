enum Type { home, all }

class APIEndpoints {
  static const String endPoint = "http://api-meistersclub.r-y-x.net/api/v1/";

  /// Auth
  static const String connectToNftVerification = "set-token-verification/";
  static const String register = "member-registration";
  static const String sendOtpToEmail = "member-login?email=";

  static verifyOTP({required String email, required String otp, required String deviceId}) {
    return 'member-login?email=$email&Otp=$otp&firebaseId=$deviceId';
  }

  /// Event
  static getEvents({required int memberId, required Type type}) {
    return 'upcoming-event/$memberId/${type.index == 0 ? "home" : "all"}';
  }
  static getEventDetails({required int memberId,required int eventId,}) {
    return 'event-details/$eventId/$memberId';
  }

  static getNews_and_Updates({required Type type}) {
    return 'news-and-updated/${type.index == 0 ? "home" : "all"}';
  }

  static const String getWishList = "WishListEventCollection/";
  static const String wishListAddRemoveEvents = "WishListAddRemove";
  static joinEvent({required int eventId,required int memberId,}) {
    return "eventjoing/$eventId/$memberId";
  }

  /// OFFERS
  static getOffers({required int memberId, required Type type}) {
    return 'upcoming-Offers/$memberId/${type.index == 0 ? "home" : "all"}';
  }
  static getOfferDetails({required int memberId,required int offerId,}) {
    return 'Offer-details/$offerId/$memberId';
  }
  static availOffer({required int offerId,required int memberId,}) {
    return "offerjoing/$offerId/$memberId";
  }

  /// Product
  static const String productBanner = "ProductBanner";
  static const String productDetails = "ProductDetails/";

  /// Chat
  static const String getAllChatRooms = "ShowAllRooms";

  static getParticularChatRoomGroups({required int roomId, required int memberId}) {
    return 'ShowAllGroups/$roomId,$memberId';
  }

  static addParticipantsToGroup({required int groupId, required int memberId}) {
    return 'AddPerticipants/$groupId,$memberId';
  }

  static getMessages({required int groupId, required int page, required int pageSize}) {
    return 'ShowAllMessagesByGroup/$groupId/$page/$pageSize';
  }

  static const String insertMessage = "InsertMessages";

  /// Profile
  static const String getUserDetails = "member?memberId=";
  static const String getUserJoinedEvents = "membereventHistory/";
  static const String profileUpdate = "member-Update";


  /// Notification
  static const String getNotificationList = "ShowNotifications/";

  /// Contact Us
  static const String contactUsFeedback = "AddfeedBack";

  /// GetAllInfo
  static const String getAllInfoOfApp = "GetAllInfo";

  /// Upload Files
  static const String uploadFiles = "uploadFile";

  /// GetFrontVideo
  static const String getFrontVideo = "GetFrontVideo";


}
