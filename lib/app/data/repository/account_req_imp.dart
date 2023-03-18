import 'package:tien_duong/app/core/base/base_repository.dart';
import 'package:tien_duong/app/data/models/account_model.dart';
import 'package:tien_duong/app/data/models/account_rating_model.dart';
import 'package:tien_duong/app/data/models/balance_model.dart';
import 'package:tien_duong/app/data/models/notification_model.dart';
import 'package:tien_duong/app/data/models/route_model.dart';
import 'package:tien_duong/app/data/models/route_point_model.dart';
import 'package:tien_duong/app/data/models/user_config_model.dart';
import 'package:tien_duong/app/data/repository/account_req.dart';
import 'package:tien_duong/app/data/repository/request_model/account_model/update_user_config_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_account_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_route_model.dart';
import 'package:tien_duong/app/data/repository/request_model/is_valid_account_model.dart';
import 'package:tien_duong/app/data/repository/request_model/login_model.dart';
import 'package:tien_duong/app/data/repository/request_model/logout_model.dart';
import 'package:tien_duong/app/data/repository/request_model/notification_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/route_model/route_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/send_notification_model.dart';
import 'package:tien_duong/app/data/repository/request_model/send_notification_tracking_model.dart';
import 'package:tien_duong/app/data/repository/request_model/update_account_model.dart';
import 'package:tien_duong/app/data/repository/response_model/authorize_response_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/dio_provider.dart';

class AccountReqImp extends BaseRepository implements AccountRep {
  @override
  Future<Account?> create(CreateAccountModel model) {
    String endpoint = '${DioProvider.baseUrl}/accounts';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']);
        return account;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Account?> getAccountId(String id) {
    String endpoint = '${DioProvider.baseUrl}/accounts/$id';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']);
        return account;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthorizeResponseModel> login(LoginModel model) {
    String endpoint = '${DioProvider.baseUrl}/authorizes';
    Map<String, dynamic> data = model.toJson();
    var dioCall = dioClient.post(endpoint, data: data);
    try {
      return callApi(dioCall).then((response) {
        Account? account = Account.fromJson(response.data['data']['account']);
        String? token = response.data['data']['token'];
        AuthorizeResponseModel model =
            AuthorizeResponseModel(account: account, token: token);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RouteAcc?> createRoute(CreateRoute createRouteModel) {
    String endpoint = '${DioProvider.baseUrl}/routes';
    var dioCall = dioClient.post(endpoint, data: createRouteModel.toJson());
    try {
      return callApi(dioCall).then((response) {
        RouteAcc? route = RouteAcc.fromJson(response.data['data']);
        return route;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<RouteAcc>> getRoutes(String accountId) {
    String endpoint = '${DioProvider.baseUrl}/routes/$accountId';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        List<RouteAcc> routes = [];
        for (var item in response.data['data']) {
          routes.add(RouteAcc.fromJson(item));
        }
        return routes;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deleteRoute(String id) {
    String endpoint = '${DioProvider.baseUrl}/routes/$id';
    var dioCall = dioClient.delete(endpoint);
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> setActiveRoute(String id) {
    String endpoint = '${DioProvider.baseUrl}/routes/active-route';
    var dioCall = dioClient.put(endpoint, queryParameters: {'id': id});
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<NotificationModel>> getNotifications(
      NotificationListModel model) {
    String endpoint = '${DioProvider.baseUrl}/notifications';
    var dioCall = dioClient.get(endpoint, queryParameters: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        List<NotificationModel> notifications = [];
        for (var item in response.data['data']) {
          notifications.add(NotificationModel.fromJson(item));
        }
        return notifications;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> sendNotification(SendNotificationModel model) {
    String endpoint = '${DioProvider.baseUrl}/notifications/send-notification';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> sendNotificationTracking(
      SendNotificationTrackingModel model) {
    String endpoint = '${DioProvider.baseUrl}/notifications/send-tracking';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> isValidAccount(IsValidAccountModel model) {
    String endpoint = '${DioProvider.baseUrl}/accounts/is-valid';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AccountRating> getRating(String accountId) {
    String endpoint = '${DioProvider.baseUrl}/feedbacks/rating/$accountId';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        AccountRating model = AccountRating.fromJson(response.data['data']);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> logout(LogoutModel model) {
    String endpoint = '${DioProvider.baseUrl}/authorizes/logout';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        SimpleResponseModel model = SimpleResponseModel.fromJson(response.data);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Account> updateAccount(UpdateAccount model) {
    String endpoint = '${DioProvider.baseUrl}/accounts/info';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Account model = Account.fromJson(response.data['data']);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BalanceModel> getAvailableBalance(String accountId) {
    String endpoint = '${DioProvider.baseUrl}/accounts/available-balance';
    var dioCall =
        dioClient.get(endpoint, queryParameters: {'accountId': accountId});
    try {
      return callApi(dioCall).then((response) {
        BalanceModel model = BalanceModel.fromJson(response.data['data']);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<RouteListModel> getRoutePoints(String routeId) {
    String endpoint = '${DioProvider.baseUrl}/routes/point-list/$routeId';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        RouteListModel model = RouteListModel.fromJson(response.data['data']);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UserConfig>> getUserConfigs(String accountId) {
    String endpoint = '${DioProvider.baseUrl}/config-user/$accountId';
    var dioCall = dioClient.get(endpoint);
    try {
      return callApi(dioCall).then((response) {
        List<UserConfig> configs = [];
        for (var item in response.data['data']) {
          configs.add(UserConfig.fromJson(item));
        }
        return configs;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserConfig> updateUserConfig(UpdateUserConfigModel model) {
    String endpoint = '${DioProvider.baseUrl}/config-user';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        UserConfig model = UserConfig.fromJson(response.data['data']);
        return model;
      });
    } catch (e) {
      rethrow;
    }
  }
}
