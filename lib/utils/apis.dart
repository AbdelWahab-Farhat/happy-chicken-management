

abstract class Apis {
  static const baseUrl = "https://happy-api.justhost.ly/api/branch";
  static const baseUrlVersion = "https://happy-api.justhost.ly/api/v1/branch";

  static const loginUrl = "$baseUrl/login";
  static const logoutUrl = "$baseUrl/logout";

  static const checkUserUrl = "$baseUrlVersion/branch";
  static const getHomeStatics = "$baseUrlVersion/home";
  static  getOrdersByState(int pageKey , List<String> states, {String? searchQuery}) {
    String stringStates = states.join(',');
    if (searchQuery == null) {
      return "$baseUrlVersion/filter-orders?page=$pageKey&status=$stringStates";
    }
    else {
      return "$baseUrlVersion/filter-orders?page=$pageKey&status=$stringStates&search=$searchQuery";
    }
  }
  static getOrder (String id) => "$baseUrlVersion/branch-orders/$id";
  static  confirmationOrder(String id) =>  "$baseUrlVersion/branch-orders/$id?_method=PUT";
  static getNotifications(int pageKey) => "$baseUrlVersion/notifications?page=$pageKey";

  static getOrdersForPrint() {
    return "$baseUrlVersion/branch-orders?status=cancelled,pending,confirmed";
  }
  static sendPrintedOrdersInvoices() {
    // send id's of orders
    // its post
    return "$baseUrlVersion/update-all-orders?_method=PUT";
  }
}