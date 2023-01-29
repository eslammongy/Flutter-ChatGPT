import 'package:flutter/material.dart';
import 'package:flutter_chat_gpt/constants/constant.dart';
import 'package:flutter_chat_gpt/services/api_services.dart';
import 'package:flutter_chat_gpt/widgets/text_widget.dart';

class ModelsDropDownMenu extends StatefulWidget {
  const ModelsDropDownMenu({super.key});

  @override
  State<ModelsDropDownMenu> createState() => _ModelsDropDownMenuState();
}

class _ModelsDropDownMenuState extends State<ModelsDropDownMenu> {
  String currentModel = "text-davinci-003";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ApiServices.getModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : FittedBox(
                  child: DropdownButton(
                    dropdownColor: cardItemBKColor,
                    iconEnabledColor: cardItemBKColor2,
                    items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                        value: snapshot.data![index].id,
                        child: TextWidget(
                          label: snapshot.data![index].id,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    value: currentModel,
                    onChanged: (value) {
                      setState(() {
                        currentModel = value.toString();
                      });
                    },
                  ),
                );
        });
  }
}
