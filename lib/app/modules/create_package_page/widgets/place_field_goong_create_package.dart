import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:lottie/lottie.dart';
import 'package:tien_duong/app/core/values/app_animation_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/response_goong_default.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:tien_duong/app/data/repository/goong_req.dart';
import 'package:tien_duong/app/data/repository/goong_req_imp.dart';

class PlaceFieldGoongCreatePackage extends StatefulWidget {
  PlaceFieldGoongCreatePackage(
      {super.key,
      required this.enable,
      required this.hintText,
      required this.labelText,
      required this.onSelected,
      this.formKey,
      this.focusNode,
      this.initialValue,
      this.autofocus = true,
      this.validator,
      this.textController});
  final bool enable;
  final String hintText;
  final String labelText;
  final bool autofocus;
  final FocusNode? focusNode;
  final String? initialValue;
  final Function(ResponseGoong) onSelected;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final GlobalKey<FormState>? formKey;
  final TextEditingController reserveTextController = TextEditingController();
  @override
  State<PlaceFieldGoongCreatePackage> createState() =>
      _PlaceFieldGoongCreatePackageState();
}

class _PlaceFieldGoongCreatePackageState
    extends State<PlaceFieldGoongCreatePackage> {
  GoongReq repo = GoongReqImp();
  @override
  Widget build(BuildContext context) {
    TextEditingController realTextCtrl = widget.textController != null
        ? widget.textController!
        : widget.reserveTextController;
    return Material(
        child: Form(
      key: widget.formKey,
      child: TypeAheadFormField<ResponseGoongDefault>(
        debounceDuration: const Duration(milliseconds: 1000),
        minCharsForSuggestions: 4,
        loadingBuilder: (context) => Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 120.w,
          child: Center(
            child: Lottie.asset(AppAnimationAssets.cuteDancingChicken,
                fit: BoxFit.cover),
          ),
        ),
        textFieldConfiguration: TextFieldConfiguration(
            enabled: widget.enable,
            controller: realTextCtrl,
            autofocus: widget.autofocus,
            focusNode: widget.focusNode,
            style: subtitle1.copyWith(
              color: AppColors.lightBlack,
            ),
            decoration: InputStyles.createPackage(
                labelText: widget.labelText, hintText: widget.hintText)),
        validator: widget.validator,
        suggestionsCallback: (pattern) async {
          if (pattern.isEmpty) {
            return [];
          }
          return await repo.getListDefault(pattern);
        },
        itemBuilder: (context, suggestion) {
          return ListTile(
            leading: const Icon(Icons.location_pin),
            minLeadingWidth: 10.w,
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                suggestion.name ?? 'Unknown',
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: caption.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
        onSuggestionSelected: (suggestion) async {
          setState(() {
            realTextCtrl.text = suggestion.name ?? '';
          });
          if (suggestion.name == null || suggestion.placeId == null) return;
          ResponseGoong detail = await repo.getDetail(suggestion.placeId!);
          widget.onSelected(detail);
        },
        noItemsFoundBuilder: (context) => Padding(
            padding: EdgeInsets.all(10.w),
            child: const Text('Không tìm thấy địa chỉ')),
        errorBuilder: ((context, error) => Padding(
            padding: EdgeInsets.all(10.w), child: const Text('Có lỗi xảy ra'))),
        suggestionsBoxDecoration: SuggestionsBoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: const Color.fromARGB(255, 242, 243, 250),
        ),
      ),
    ));
  }
}
