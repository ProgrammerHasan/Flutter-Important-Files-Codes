BuildContext dialogContext;
showDialog(
context: context,
barrierDismissible: false,
builder: (BuildContext context) {
dialogContext = context;
return Dialog(
child: new Row(
mainAxisSize: MainAxisSize.min,
children: [
new CircularProgressIndicator(),
new Text("Loading"),
],
),
);
},
);

Navigator.pop(dialogContext);