import 'package:flutter/material.dart';

Widget buildTextField({
  required TextInputType keyboardType,
  required TextEditingController controller,
  required String labeltext,
  required bool enabled,
  required BuildContext context,
}) {
  return Expanded(
    child: TextSelectionTheme(
      data: const TextSelectionThemeData(
          selectionColor: Color(0x25000000),
          selectionHandleColor: Color(0xFF333333)),
      child: SizedBox(
        height: 50,
        child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFFCCCCCC)
              : const Color(0xFF1A1A1A),
          cursorWidth: 1,
          style: TextStyle(color: Color(0xFF000000), fontSize: 14),
          decoration: InputDecoration(
            labelText: labeltext,
            labelStyle: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? const Color(0xFFCCCCCC)
                    : const Color(0xFF1A1A1A),
                fontSize: 14),
            filled: false,
            // enabledBorder: outlineBorder(context),
            // disabledBorder: outlineBorder(context),
            // focusedBorder: activeOutlineBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          ),
          obscureText: false,
          enabled: enabled,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
        ),
      ),
    ),
  );
}
