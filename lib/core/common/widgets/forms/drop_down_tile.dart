import 'package:flutter/material.dart';

class TDropDownTile extends StatefulWidget {
  final String title;
  final String value;
  final List<String> items;
  final String? extraText;
  final void Function(String?)? onChanged;
  final FormFieldValidator<String>? validator;

  const TDropDownTile({
    required this.title,
    required this.items,
    required this.value,
    super.key,
    this.onChanged,
    this.extraText,
    this.validator,
  });

  @override
  State<TDropDownTile> createState() => T_DropDownTileState();
}

class T_DropDownTileState extends State<TDropDownTile> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: widget.value,
      validator: widget.validator,
      builder: (FormFieldState<String> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${widget.title} ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: widget.extraText,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: field.value,
                  items: widget.items
                      .map((String item) => DropdownMenuItem<String>(
                    alignment: AlignmentDirectional.centerEnd,
                    value: item,
                    child: Text(
                      item,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ))
                      .toList(),
                  selectedItemBuilder: (context) => [
                    for (final item in widget.items)
                      Text(
                        field.value ?? widget.value,
                        style: Theme.of(context).textTheme.titleMedium,
                      )
                  ],
                  menuWidth: MediaQuery.of(context).size.width / 1.1,
                  onChanged: (String? newValue) {
                    widget.onChanged?.call(newValue);
                    field.didChange(newValue);
                  },
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  underline: const SizedBox.shrink(),
                  alignment: AlignmentDirectional.center,
                  isDense: true,
                  isExpanded: false,
                  dropdownColor: Theme.of(context).colorScheme.secondaryContainer,
                  iconEnabledColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ],
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 8.0),
                child: Text(
                  field.errorText!,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
