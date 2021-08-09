import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

class MultipleDynamicDependentDropdown extends StatefulWidget {
  final String hint;
  final String uri;
  final TextEditingController controller;
  final TextEditingController controller2;
  final TextEditingController controller3;
  final Color color;

  MultipleDynamicDependentDropdown({Key key, @required this.hint, @required this.uri, @required this.controller, this.color, this.controller2, this.controller3}) : super(key: key);

  @override
  _MultipleDynamicDependentDropdownState createState() => _MultipleDynamicDependentDropdownState();
}

class _MultipleDynamicDependentDropdownState extends State<MultipleDynamicDependentDropdown> {
  String dropdownValue;
  String dropdownValue2;
  String dropdownValue3;
  Future<List<dynamic>> items;
  Future<List<dynamic>> items2;
  Future<List<dynamic>> items3;
  bool isUpazilaFound =false;
  bool isPostFound =false;

  @override
  void initState() {
    super.initState();
    items = _getItems();
    widget.controller.addListener(() {
      if (widget.controller.text == 'null') {
        widget.controller.text = '';
      }
      setState(() {
        dropdownValue = widget.controller.text.isNotEmpty && widget.controller.text != 'null' ? widget.controller.text : null;
      });
    });
    widget.controller2.addListener(() {
      if (widget.controller2.text == 'null') {
        widget.controller2.text = '';
      }
      setState(() {
        dropdownValue2 = widget.controller2.text.isNotEmpty && widget.controller2.text != 'null' ? widget.controller2.text : null;
      });
    });
    widget.controller3.addListener(() {
      if (widget.controller3.text == 'null') {
        widget.controller3.text = '';
      }
      setState(() {
        dropdownValue3 = widget.controller3.text.isNotEmpty && widget.controller3.text != 'null' ? widget.controller3.text : null;
      });
    });


    if(widget.controller.text.isNotEmpty && widget.controller.text != 'null'){
      print(widget.controller.text);
      isUpazilaFound  =true;
      items2 =  _getItems2(widget.controller.text);
    }
    if(widget.controller2.text.isNotEmpty && widget.controller2.text != 'null'){
      print(widget.controller2.text);
      isPostFound = true;
      items3 =  _getItems3(widget.controller2.text);
    }

  }

  Future<List<dynamic>> _getItems () async {
    final response = await dio.get(widget.uri);
    return response.data;
  }
  Future<List<dynamic>> _getItems2 (districtId) async {
    final response = await dio.get('/upazilas/district_id=$districtId');
    return response.data;
  }
  Future<List<dynamic>> _getItems3 (upazilaId) async {
    final response = await dio.get('/post_offices/upazila_id=$upazilaId');
    return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          FutureBuilder(
              future: items,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return DropdownButtonFormField<String>(
                    value: widget.controller.text.isNotEmpty && widget.controller.text != 'null' ? widget.controller.text : dropdownValue,
                    isDense: false,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        widget.controller.text = newValue;
                        widget.controller2.text = '';
                        dropdownValue2 = null;
                        isUpazilaFound = true;
                        items2 =  _getItems2(widget.controller.text);
                      });
                    },
                    items: data?.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['name']),
                      );
                    })?.toList() ??
                        [],
                    decoration: InputDecoration(
                        hintText: widget.hint,
                        labelText: widget.hint,
                        labelStyle: TextStyle(
                          color: widget.color??Colors.grey[700],
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 8, right: 8)
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(widget.hint + ' - Loading...', style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700]
                        ),),
                        SizedBox(height: 8,),
                        LinearProgressIndicator(),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400], width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                  );
                }
              }
          ),
          SizedBox(height: 10,),
         if(isUpazilaFound) FutureBuilder(
              future: items2,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return DropdownButtonFormField<String>(
                    value: widget.controller2.text.isNotEmpty && widget.controller2.text != 'null' ? widget.controller2.text : dropdownValue2,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue2 = newValue;
                        widget.controller2.text = newValue;
                        widget.controller3.text = '';
                        dropdownValue3 = null;
                        isPostFound = true;
                        items3 =  _getItems3(widget.controller2.text);
                      });
                    },
                    items: data?.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['name']),
                      );
                    })?.toList() ??
                        [],
                    decoration: InputDecoration(
                        hintText: 'Upazila',
                        labelText: 'Upazila',
                        labelStyle: TextStyle(
                          color: widget.color??Colors.grey[700],
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 8, right: 8)
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Upazila'+ ' - Loading...', style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700]
                        ),),
                        SizedBox(height: 8,),
                        LinearProgressIndicator(),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400], width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                  );
                }
              }
          ),
          SizedBox(height: 10,),
         if(isPostFound) FutureBuilder(
              future: items3,
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                final data = snapshot.data;
                if (data != null) {
                  return DropdownButtonFormField<String>(
                    value: widget.controller3.text.isNotEmpty && widget.controller3.text != 'null' ? widget.controller3.text : dropdownValue3,
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue3 = newValue;
                        widget.controller3.text = newValue;
                      });
                    },
                    items: data?.map<DropdownMenuItem<String>>((dynamic value) {
                      return DropdownMenuItem<String>(
                        value: value['id'].toString(),
                        child: Text(value['name']),
                      );
                    })?.toList() ??
                        [],
                    decoration: InputDecoration(
                        hintText: 'Post Office',
                        labelText: 'Post Office',
                        labelStyle: TextStyle(
                          color: widget.color??Colors.grey[700],
                        ),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.only(left: 8, right: 8)
                    ),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  );
                } else {
                  return Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text('Post Office' + ' - Loading...', style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700]
                        ),),
                        SizedBox(height: 8,),
                        LinearProgressIndicator(),
                      ],
                    ),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400], width: 2),
                        borderRadius: BorderRadius.all(Radius.circular(8))
                    ),
                  );
                }
              }
          ),
        ],
      )
    );
  }
}
