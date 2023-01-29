import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';

class ModelsDropDownMenu extends StatefulWidget {
  const ModelsDropDownMenu({super.key});

  @override
  State<ModelsDropDownMenu> createState() => _ModelsDropDownMenuState();
}

class _ModelsDropDownMenuState extends State<ModelsDropDownMenu> {
  String currentModel = "Model Test 1";
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: cardItemBKColor,
      iconEnabledColor: scaffoldBKColor,
      items: getModelItems,
      value: currentModel,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }
}
