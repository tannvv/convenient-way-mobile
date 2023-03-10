import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/account_rating_model.dart';
import 'package:tien_duong/app/data/models/notification_model.dart';
import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_account_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_route_model.dart';
import 'package:tien_duong/app/data/repository/request_model/is_valid_account_model.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/data/repository/request_model/logout_model.dart';
import 'package:tien_duong/app/data/repository/request_model/notification_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/send_notification_model.dart';
import 'package:tien_duong/app/data/repository/request_model/send_notification_tracking_model.dart';
import 'package:tien_duong/app/data/repository/response_model/authorize_response_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';

abstract class AccountRep {
  Future<AuthorizeResponseModel> login(LoginModel model);
  Future<SimpleResponseModel> logout(LogoutModel model);
  Future<Account?> getAccountId(String id);
  Future<Account?> create(CreateAccountModel model);
  Future<RouteAcc?> createRoute(CreateRoute createRoute);
  Future<List<RouteAcc>> getRoutes(String accountId);
  Future<SimpleResponseModel> deleteRoute(String id);
  Future<SimpleResponseModel> setActiveRoute(String id);
  Future<List<NotificationModel>> getNotifications(NotificationListModel model);
  Future<SimpleResponseModel> sendNotification(SendNotificationModel model);
  Future<SimpleResponseModel> sendNotificationTracking(
      SendNotificationTrackingModel model);
  Future<SimpleResponseModel> isValidAccount(IsValidAccountModel model);
  Future<AccountRating> getRating(String accountId);
}
