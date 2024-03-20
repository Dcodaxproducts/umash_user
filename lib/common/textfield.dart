import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;
  final EdgeInsetsGeometry? padding;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function()? onTap;
  final bool readOnly;
  final bool enabled;
  final bool isOutline;

  const CustomTextField(
      {this.controller,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.prefix,
      this.obscureText = false,
      this.padding,
      this.validator,
      this.onChanged,
      this.onSubmitted,
      this.keyboardType,
      this.textInputAction,
      this.onTap,
      this.readOnly = false,
      this.enabled = true,
      this.isOutline = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ??
          EdgeInsetsDirectional.only(top: labelText == null ? 5 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          TextFormField(
            onTapOutside: (event) => FocusScope.of(context).unfocus(),
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onTap: onTap,
            readOnly: readOnly,
            enabled: enabled,
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              prefixIcon: prefix,
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
              errorStyle: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.red),
              enabledBorder: border(),
              disabledBorder: border(),
              focusedBorder: border(color: primaryColor),
              errorBorder: border(color: Theme.of(context).colorScheme.error),
              focusedErrorBorder: border(),
              contentPadding: const EdgeInsets.all(18),
              suffixIcon: suffixIcon,
              filled: true,
            ),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }
}

InputBorder border({Color? color}) => OutlineInputBorder(
      borderSide:
          BorderSide(color: color ?? Theme.of(Get.context!).dividerColor),
      borderRadius: BorderRadius.circular(15),
    );

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem> items;
  final Function(dynamic) onChanged;
  final String? labelText, hintText;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? padding;
  const CustomDropDown(
      {required this.items,
      required this.onChanged,
      this.hintText,
      this.labelText,
      this.suffixIcon,
      this.padding,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // title
          if (labelText != null) ...[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                labelText!,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).hintColor),
              ),
            ),
            const SizedBox(height: 5),
          ],
          DropdownButtonFormField(
            decoration: InputDecoration(
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelText: hintText,
              labelStyle:
                  FontStyles.titleSmall.copyWith(fontWeight: FontWeight.normal),
              enabledBorder: border(context),
              focusedBorder:
                  border(context, color: Theme.of(context).primaryColor),
              errorBorder:
                  border(context, color: Theme.of(context).colorScheme.error),
              focusedErrorBorder: border(context),
              filled: true,
              fillColor: Theme.of(context).cardColor,
              contentPadding: const EdgeInsets.all(15),
              suffixIcon: suffixIcon,
            ),
            style: FontStyles.titleMedium,
            items: items,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  InputBorder border(BuildContext context, {Color? color}) =>
      OutlineInputBorder(
        borderSide: BorderSide(
          color: color ?? Theme.of(context).cardColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(5),
      );
}
