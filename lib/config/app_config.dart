import '../core/localization/loc_keys.dart';

abstract class AppConfig {
  static String baseUrl = 'http://104.248.165.230:5000/api/v1/';
  static String baseImgUrl = "http://144.126.155.112:8011/";
  static const int maxRetries = 3;
  static const Duration rateLimitDelay = Duration(milliseconds: 500);
  static String version = 'v1/';
}

const kUserLangKey = "lang";
const kUserLanguage = "language";
const kDefaultLanguage = Loc.en;
const kUserKey = "user";
const kUserProfileKey = "userProfile";
const kUserToken = "token";
const kUserOnBoardIsSkipped = "onBoardingSkipped";
const kUserAddressList = "addressList";
bool kUpdateContactsMaybeLater = false;

///firebase
const firebaseApiKey = 'AIzaSyAiJDY15P4hRNQcZKn8fIekoA9COcUIeDU';
const firebaseAppId = '1:1051843546353:android:b820677e74be5beafc2d50';
const firebaseMessagingSenderId = '1051843546353';
const firebaseMessagingProjectId = 'test-c8634';

abstract class EndPoints {
  static String getBrokers = 'brokers';

  static String loginWithDataBase = 'Auth/LoginMobileApp';

  static String profileDataWithDataBase = 'User/GetUserProfile';
  static String serviceContract({required String serviceId}) =>
      'OrderReport/GetServiceContract/$serviceId';
  static String contractsWithDataBase = 'Order/GetOrderContracts';
  static String advertismentWithDataBase = 'Advertisement/GetAll';
  static String preVisits = 'Order/GetAllOrder';
  static String nextVisits = 'Order/GetFutureOrder';

  static String registerWithDataBase = 'Auth/RegisterMobileApp';
  static String updateProfileWithDataBase = 'User/UpdateUserProfile';
  static String checkOtpWithDataBase = 'Auth/CheckLoginOTP';
  static String updateUserWithDataBase = 'profile';
/////////////////////////////////////////////////////////
  //shifts
  static String getShifts = 'Shift/GetAll';
/////////////////////////////
  //nationalities
  static String getNationalities = 'Nationality/GetAll';
  static String getAllNationalityWorkers = 'Worker/GetAll';
  static String orderMedService = 'Order';
  /////////////////////////////////////////////////
  // servicePerHour
  static String getServicePerHourNearCompanies({
    required String serviceId,
    required int distance,
    required String addressId,
  }) =>
      'ServicePriceHead/GetNearbyServices?SystemOfServiceId=$serviceId&DistanceInKilometers=$distance';
  ///////////////////////////////////////////////
  //order
  static String addOrder = 'Order';
  static String addContracts = 'my-contacts';

  static String updateContracts({required int id}) => 'my-contacts/$id';

  static String countries = 'location/countries';

  static String placeOfWOrk = 'work-categories';

  static String getAllCities() => 'city/GetAll';

  static String uploadContact = 'my-contacts/upload';

  static String unCompletedContact = 'my-contacts/uncompleted';

  static String getProfile = "profile";

  static String getRecentlyProfileImages = "profile-photo-history";

  static String aboutApp = "about-app";
  static String mediationSubServices = "TypeOfService/GetAll";

  static String getFriendConnections = "connections";

  static String chatWithAi = "assistant";

  static String deleteFriendConnections(int id) => "connections/$id";

  static String deleteManyContacts({required List<int> contactIds}) {
    return 'my-contacts/destroy/many?${Uri(
      queryParameters: {
        for (var i = 0; i < contactIds.length; i++)
          'ids[$i]': contactIds[i].toString()
      },
    )}';
  }

  //////////////////////////////
  //////////////UserAddres
  static String getAllAddress(String userId) =>
      'UserAddres/GetByUserId/$userId';
  static String addAddress = 'UserAddres';

  static String code = ''; // todo
  static String logout = ''; // todo
  static String updateDeviceToken = ''; // todo

  static String getSystemServiceEndPoint = "SystemOfService/GetAll";

  static String deleteContractsWithDataBase({required String contractId}) =>
      'Order?id=$contractId';
}
