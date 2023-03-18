// ignore_for_file: static constant_identifier_names, constant_identifier_names

abstract class PackageStatus {
  static const String WAITING = "WAITING";
  static const String APPROVED = "APPROVED";
  static const String REJECT = "REJECT";
  static const String SELECTED = "SELECTED";
  static const String PICKUP_SUCCESS = "PICKUP_SUCCESS";
  static const String PICKUP_FAILED = "PICKUP_FAILED";
  static const String DELIVER_CANCEL = "DELIVER_CANCEL";
  static const String SENDER_CANCEL = "SENDER_CANCEL";
  static const String DELIVERED_SUCCESS = "DELIVERED_SUCCESS";
  static const String DELIVERED_FAILED = "DELIVERED_FAILED";
  static const String SUCCESS = "SUCCESS";
  static const String REFUND_TO_WAREHOUSE_SUCCESS =
      "REFUND_TO_WAREHOUSE_SUCCESS";
  static const String REFUND_TO_WAREHOUSE_FAILED = "REFUND_TO_WAREHOUSE_FAILED";
  static const String NOT_EXIST = "NOT_EXIST";
  static const String EXPIRED = "EXPIRED";
}
