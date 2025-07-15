class EndPoints {
  EndPoints._();

  //? Endpoint URLs
  static const baseUrl = "http://104.248.165.230:5000";
  static const testingUrl = "$baseUrl/api/v1";
  // static const prodUrl = "$baseUrl/api/PROD_URL";
  static const apiUrl = "$testingUrl"; //? Replace with $prodUrl when we go live
  static const getSymbolsList = "$testingUrl/symbols";
  static const getSymbolGroups = "$testingUrl/symbols-groups";

//Orders URLs
  static const createOrder = "$baseUrl/api/v1/orders";
  static const getOrders = "$baseUrl/api/v1/orders";
  static const closeOrder = "$baseUrl/api/v1/orders/CloseOrder";

//Positions URLs
  static const getPositions = "$baseUrl/api/v1/positions";
  static const getPositionById = "$baseUrl/api/v1/positions/by-id/";
  static const closeAllPositions =
      "$baseUrl/api/v1/positions/CloseAllPositions";
  static const postPosition = "$baseUrl/api/v1/positions";
  static const updatePosition = "$baseUrl/api/v1/positions";
  static const login = "$baseUrl/api/v1/users/login";
  static const register = "$baseUrl/api/v1/register";
  static const logout = "$baseUrl/api/v1/logout";

  static const createDemoAccount = "$baseUrl/api/v1/demo-accounts";
  static const createRealAccount = "$baseUrl/api/v1/real-accounts";
}
