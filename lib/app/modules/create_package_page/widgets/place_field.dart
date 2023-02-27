import 'package:lottie/lottie.dart';
import 'package:tien_duong/app/core/values/app_animation_assets.dart';
import 'package:tien_duong/app/core/values/app_colors.dart';
import 'package:tien_duong/app/core/values/font_weight.dart';
import 'package:tien_duong/app/core/values/input_styles.dart';
import 'package:tien_duong/app/core/values/shadow_styles.dart';
import 'package:tien_duong/app/core/values/text_styles.dart';
import 'package:tien_duong/app/data/models/response_goong_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:tien_duong/app/modules/create_package_page/controllers/create_package_page_controller.dart';

class PlaceField extends GetWidget<CreatePackagePageController> {
  PlaceField(
      {super.key,
      required this.enable,
      required this.hintText,
      required this.labelText,
      required this.onSelected,
      this.initialValue,
      this.autofocus = true,
      this.validator,
      this.textController});
  final bool enable;
  final String hintText;
  final String labelText;
  final bool autofocus;
  final String? initialValue;
  final Function(ResponseGoong) onSelected;
  final TextEditingController? textController;
  final String? Function(String?)? validator;
  final TextEditingController reserveTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController realTextCtrl =
        textController != null ? textController! : reserveTextController;
    return Material(
        child: TypeAheadFormField<ResponseGoong>(
      debounceDuration: const Duration(milliseconds: 500),
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
          enabled: enable,
          controller: realTextCtrl,
          autofocus: autofocus,
          style: subtitle1.copyWith(
            color: AppColors.lightBlack,
          ),
          decoration: InputStyles.createPackage(
              labelText: labelText, hintText: hintText)),
      validator: validator,
      suggestionsCallback: (pattern) async {
        if (pattern.isEmpty) {
          return [];
        }
        return await controller.queryLocation(pattern);
      },
      itemBuilder: (context, suggestion) {
        return ListTile(
          leading: const Icon(Icons.location_pin),
          minLeadingWidth: 10.w,
          title: Text(
            suggestion.name ?? 'Unknown',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: caption.copyWith(fontSize: 14.sp),
          ),
        );
      },
      onSuggestionSelected: (suggestion) {
        onSelected(suggestion);
        realTextCtrl.text = suggestion.name ?? '';
      },
      noItemsFoundBuilder: (context) => Padding(
          padding: EdgeInsets.all(10.w),
          child: const Text('Không tìm thấy địa chỉ')),
      errorBuilder: ((context, error) => Padding(
          padding: EdgeInsets.all(10.w), child: Text(error.toString()))),
      suggestionsBoxDecoration: SuggestionsBoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: const Color.fromARGB(255, 242, 243, 250),
      ),
    ));
  }
}
