import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart%20%20';
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

class PlaceFieldDefault extends StatefulWidget {
  PlaceFieldDefault(
      {super.key,
      required this.enable,
      required this.hintText,
      required this.labelText,
      required this.onSelected,
      this.onClear,
      this.textController});
  final bool enable;
  final String hintText;
  final String labelText;
  final Function(ResponseGoong) onSelected;
  final Function()? onClear;
  final TextEditingController? textController;
  final TextEditingController reserveTextController = TextEditingController();

  @override
  State<PlaceFieldDefault> createState() => _PlaceFieldDefaultState();
}

class _PlaceFieldDefaultState extends State<PlaceFieldDefault> {
  GoongReq repo = GoongReqImp();
  @override
  Widget build(BuildContext context) {
    TextEditingController realTextCtrl = widget.textController != null
        ? widget.textController!
        : widget.reserveTextController;
    return Material(
        color: Colors.transparent,
        child: TypeAheadField<ResponseGoongDefault>(
            debounceDuration: const Duration(milliseconds: 500),
            minCharsForSuggestions: 2,
            textFieldConfiguration: TextFieldConfiguration(
              enabled: widget.enable,
              controller: realTextCtrl,
              autofocus: true,
              style: subtitle1.copyWith(color: AppColors.lightBlack),
              decoration: InputStyles.map(
                hintText: widget.hintText,
                labelText: widget.labelText,
              ).copyWith(
                  suffix: widget.enable &&
                          realTextCtrl.text.isNotEmpty &&
                          widget.onClear != null
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              realTextCtrl.clear();
                              if (widget.onClear != null) widget.onClear!();
                            });
                          },
                          icon: Icon(
                            Icons.cancel_sharp,
                            size: 20.sp,
                            color: AppColors.lightBlack,
                          ))
                      : null),
            ),
            suggestionsCallback: (pattern) async {
              if (pattern.isEmpty) {
                return [];
              }
              GoongReq repo = GoongReqImp();
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
            loadingBuilder: (context) => Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 120.w,
                  child: Center(
                    child: Lottie.asset(AppAnimationAssets.cuteDancingChicken,
                        fit: BoxFit.cover),
                  ),
                ),
            onSuggestionSelected: (suggestion) async {
              setState(() {
                realTextCtrl.text = suggestion.name ?? '';
              });
              if (suggestion.placeId == null) return;
              ResponseGoong detail =
                  await repo.getDetail(suggestion.placeId ?? '');
              widget.onSelected(detail);
            },
            noItemsFoundBuilder: (context) => Padding(
                padding: EdgeInsets.all(10.w),
                child: const Text('Không tìm thấy địa chỉ')),
            errorBuilder: ((context, error) => Padding(
                padding: EdgeInsets.all(10.w),
                child: const Text('Không có kết quả'))),
            suggestionsBoxDecoration: SuggestionsBoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.white,
            )));
  }
}
