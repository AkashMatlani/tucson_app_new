import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'ColorExtension.dart';
import 'Constant.dart';


Widget textFieldFor(String hint,
    TextEditingController controller,
    {TextInputType keyboardType = TextInputType.text,
      bool autocorrect = true,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      bool obscure = false,
      maxLength: 200,
      perfixIcon,
      suffixIcon,
      textInputAction,
      bool enabled = true,
      bool readOnly = false,
      var inputFormatter,
      onEditingComplete,
      onTap,
      onSubmit}) {
  return SizedBox(
    height: 50,
    child: TextField(
      autocorrect: autocorrect,
      enabled: enabled,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      onEditingComplete: onEditingComplete,
      obscureText: obscure,
      controller: controller,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      style: AppTheme.regularSFTextStyle(),
      decoration: InputDecoration(
        filled: true,
        contentPadding: textFieldPadding(),
        prefixIcon: perfixIcon,
        hintText: hint,
        suffixIcon: suffixIcon,
        fillColor: Colors.white,
        hintStyle: AppTheme.textFieldHintTextStyle(),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
      ),
      inputFormatters: inputFormatter,
      onTap: onTap,
      onSubmitted: onSubmit,
    ),
  );
}

Widget multilineTextFieldFor(String hint, TextEditingController controller, double height,
    {TextInputType keyboardType = TextInputType.text,
      bool autocorrect = true,
      TextCapitalization textCapitalization = TextCapitalization.sentences,
      bool obscure = false,
      maxLength: 200,
      perfixIcon,
      bool enabled = true,
      bool readOnly = false,
      onEditingComplete,
      onTap,
      onSubmit,
      onChange}) {
  return SizedBox(
    height: height,
    child: TextField(
      autocorrect: autocorrect,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: 5,
      textCapitalization: textCapitalization,
      onEditingComplete: onEditingComplete,
      obscureText: obscure,
      controller: controller,
      keyboardType: keyboardType,
      style: AppTheme.regularSFTextStyle(),
      decoration: InputDecoration(
        filled: true,
        contentPadding: textFieldPadding(),
        prefixIcon: perfixIcon,
        hintText: hint,
        fillColor: Colors.white,
        hintStyle: AppTheme.textFieldHintTextStyle(),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: MyColor.textFieldBorderColor()),
        ),
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
      onTap: onTap,
      onSubmitted: onSubmit,
    ),
  );
}

Widget defaultUserProfile(){
  return Container(
    decoration: BoxDecoration(
      /*gradient: LinearGradient(colors: [HexColor("#1785e9"), HexColor("#83cff2")]),*/
        color: HexColor("#556080"),
        borderRadius: BorderRadius.all(Radius.circular(10))),
    height: 80,
    width: 80,
    child: Container(
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: SvgPicture.asset(MyImage.defaultProfile),
    ),
  );
}

EdgeInsets textFieldPadding() {
  return EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 10.0);
}
