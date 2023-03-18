import 'package:tien_duong/app/core/base/base_repository.dart';
import 'package:tien_duong/app/data/models/feedback_model.dart';
import 'package:tien_duong/app/data/models/package_cancel_model.dart';
import 'package:tien_duong/app/data/models/package_model.dart';
import 'package:tien_duong/app/data/models/suggest_package_model.dart';
import 'package:tien_duong/app/data/repository/package_req.dart';
import 'package:tien_duong/app/data/repository/request_model/account_pickup_model.dart';
import 'package:tien_duong/app/data/repository/request_model/cancel_package_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_feedback_model.dart';
import 'package:tien_duong/app/data/repository/request_model/create_package_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_cancel_list_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_model/pickup_package_failed_model.dart';
import 'package:tien_duong/app/data/repository/request_model/package_model/delivered_package_failed_model.dart';
import 'package:tien_duong/app/data/repository/request_model/suggest_package_request_model.dart';
import 'package:tien_duong/app/data/repository/response_model/simple_response_model.dart';
import 'package:tien_duong/app/network/dio_provider.dart';

class PackageReqImp extends BaseRepository implements PackageReq {
  @override
  Future<List<SuggestPackage>> getSuggestPackage(
      SuggestPackageRequestModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/combos-v2';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<SuggestPackage> data = (response.data['data'] as List)
            .map((e) => SuggestPackage.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Package>> getList(PackageListModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<Package> data = (response.data['data'] as List)
            .map((e) => Package.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PackageCancel>> getListCancelReason(
      PackageCancelListModel model) {
    String endpoint =
        '${DioProvider.baseUrl}/transactionpackages/cancel-package';
    Map<String, dynamic> queryParams = model.toJson();
    var dioCall = dioClient.get(endpoint, queryParameters: queryParams);
    try {
      return callApi(dioCall).then((response) {
        List<PackageCancel> data = (response.data['data'] as List)
            .map((e) => PackageCancel.fromJson(e))
            .toList();
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> selectedPackages(
      SelectedPackagesModel model) async {
    String endpoint = '${DioProvider.baseUrl}/packages/deliver-selected';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> pickupSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/pickup-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliverCancel(CancelPackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/deliver-cancel';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Package> create(CreatePackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Package data = Package.fromJson(response.data['data']);
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> senderCancel(CancelPackageModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/sender-cancel';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Feedback> createFeedback(CreateFeedbackModel model) async {
    String endpoint = '${DioProvider.baseUrl}/feedbacks';
    var dioCall = dioClient.post(endpoint, data: model.toJson());
    try {
      return callApi(dioCall).then((response) {
        Feedback data = Feedback.fromJson(response.data['data']);
        return data;
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> refundFailed(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/refund-failed';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> refundSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/refund-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliveredFailed(
      DeliveredPackageFailedModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/delivered-failed';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> deliveredSuccess(String packageId) {
    String endpoint = '${DioProvider.baseUrl}/packages/delivered-success';
    var dioCall =
        dioClient.put(endpoint, queryParameters: {'packageId': packageId});
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SimpleResponseModel> pickupFailed(PickupPackageFailedModel model) {
    String endpoint = '${DioProvider.baseUrl}/packages/pickup-failed';
    var dioCall = dioClient.put(endpoint, data: model.toJson());
    try {
      return callApi(dioCall)
          .then((response) => SimpleResponseModel.fromJson(response.data));
    } catch (e) {
      rethrow;
    }
  }
}
