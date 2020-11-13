import 'package:flutter/material.dart';

class DeleteConfirmationDialog extends AlertDialog {
  final VoidCallback deleteCallback;

  DeleteConfirmationDialog({@required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Remove from favourites?"),
      actions: [
        FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel")),
        FlatButton(
            onPressed: () {
              deleteCallback.call();
              Navigator.pop(context);
            },
            child: Text("Remove"))
      ],
    );
  }
}