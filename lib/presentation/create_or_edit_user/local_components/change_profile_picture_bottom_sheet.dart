import 'package:flutter/material.dart';
import 'package:reconstructitapp/components/app_secondary_button.dart';

class ChangeProfilePictureBottomSheet extends StatefulWidget {
  final void Function() onDelete;
  final void Function() onPickImage;

  const ChangeProfilePictureBottomSheet({
    super.key,
    required this.onDelete,
    required this.onPickImage,
  });

  @override
  ChangeProfilePictureBottomSheetState createState() =>
      ChangeProfilePictureBottomSheetState();
}

class ChangeProfilePictureBottomSheetState
    extends State<ChangeProfilePictureBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSecondaryButton(
                  onPressed: () {
                    widget.onPickImage();
                    Navigator.pop(context);
                  },
                  child: Text("Aus Bibliothek auswählen"),
                ),

                Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: Theme.of(context).colorScheme.copyWith(
                      primary: Theme.of(context).colorScheme.error,
                      onPrimary: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      widget.onDelete();
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    child: Text("Profilbild entfernen"),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
