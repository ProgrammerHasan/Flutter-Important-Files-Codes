final fastNavigatorTextController = TextEditingController();

getShowAlertBox() {
  return showDialog(
      barrierColor: Colors.black.withOpacity(0.3),
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Material(
                    color: Colors.transparent,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[

                          ],
                        ),
                        Divider(),
                        TextField(
                          style: TextStyle(
                              fontSize: 14
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onChanged: (val){

                          },
                          controller: fastNavigatorTextController,
                        ),
                      ],
                    )
                );
              }
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Wrap(
                children: <Widget>[
                  Icon(Icons.close,size: 22,color: Colors.redAccent),
                  Text('Close',style: TextStyle(fontSize: 17,color: Colors.redAccent),),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            CupertinoDialogAction(
               child: Wrap(
                  children: <Widget>[
                    Icon(Icons.search,size: 22,),
                    Text(' Ok',style: TextStyle(fontSize: 18,color:Colors.grey[700]),textAlign: TextAlign.center,),
                ],
               ),
              onPressed: (){

              },
            )
          ],
        );
      });
}