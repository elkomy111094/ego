import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/sizes.dart';

class TFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? hintText;
  late List<TextInputFormatter>  formatter;
  final String? Function(String?)? validator;
  final bool? enabled;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;
  final int? maxLines;
   TFormField({
    super.key,
    this.formatter = const [],
    required this.controller,
    required this.label,
    this.hintText = "",
    this.validator,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  State<TFormField> createState() => _TFormFieldState();
}

class _TFormFieldState extends State<TFormField> {
 

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChanged,
      inputFormatters: widget.formatter ,
      style: Theme.of(context).textTheme.titleMedium , 
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        isDense: false,
        hintText:   (widget.hintText ?? ""),
        errorStyle: Theme.of(context).textTheme.labelLarge?.copyWith(color: Theme.of(context).colorScheme.error),
        hintTextDirection: TextDirection.rtl,
        hintStyle: TextTheme.of(context).labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
        prefixText: widget.label+" : ",
        prefixStyle: Theme.of(context).textTheme.bodyLarge, 
        contentPadding: EdgeInsets.only(left: 6, right: 6, bottom: 2, top: 0),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
        
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2.0),
        ),
        errorBorder: UnderlineInputBorder(
    
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        
        ),
      ),
    );
  }
}
