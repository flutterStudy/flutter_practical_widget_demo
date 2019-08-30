import 'package:flutter/material.dart';

import 'package:flutter_practical_widget/com.hh.practical.widget/toast.dart';


class TestLayout extends StatefulWidget
{
  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    return _TestLayoutState();
  }
}

class _TestLayoutState extends State<TestLayout>
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    FlatButton flatButton = FlatButton(onPressed: ()
    {
      Toast.show(context, "AAAA");
    }, child: Text("点击"));

    return Scaffold(body: SafeArea(child: flatButton),);
  }

}
