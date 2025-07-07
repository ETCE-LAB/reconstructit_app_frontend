import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/AppButton.dart';

class SelectStatusBottomSheet extends StatefulWidget {
  const SelectStatusBottomSheet({super.key});

  @override
  SelectStatusBottomSheetState createState() => SelectStatusBottomSheetState();
}

class SelectStatusBottomSheetState extends State<SelectStatusBottomSheet> {
  int? _selectedIndex = 0;

  final List<_OptionItem> options = [
    _OptionItem(
      title: 'Einigung ausstehend',
      description:
          'Ihr habt euch noch nicht darauf geeinigt, dass Alina das Bauteil druckt.',
    ),
    _OptionItem(
      title: 'Geeinigt',
      description:
          'Ihr habt euch darauf geeinigt, dass Alina das Bauteil druckt. Andere verknüpfte Chats werden abgebrochen.',
    ),
    _OptionItem(
      title: 'Bauteil erhalten',
      description: 'Du hast das Bauteil erhalten.',
    ),
    _OptionItem(
      title: 'Abgebrochen',
      description: 'Ihr werdet euch nicht einig.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: RadioListTile(
                  value: index,
                  groupValue: _selectedIndex,
                  onChanged: (val) {
                    setState(() {
                      _selectedIndex = val as int;
                    });
                  },
                  title: Text(
                    options[index].title,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  subtitle: Text(
                    options[index].description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 10),
            itemCount: 4,
          ),
          SizedBox(height: 12),
          AppButton(child: Text("Änderungen speichern"), onPressed: () {}),
          SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _OptionItem {
  final String title;
  final String description;

  _OptionItem({required this.title, required this.description});
}
