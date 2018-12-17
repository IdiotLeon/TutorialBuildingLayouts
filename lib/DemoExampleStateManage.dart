import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppDemoStateSelfManage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter Demo'),
        ),
        body: Center(
          // To show the example that state managed by parent widget
          //child: ParentWidget(),
          // To show the example that state managed by the widget itself
          child: StateSelfManageTapBox(),
        ),
      ),
    );
  }
}

// -------------------- State managed by Self ----------------------------------
class StateSelfManageTapBox extends StatefulWidget {
  StateSelfManageTapBox({Key key}) : super(key: key);

  @override
  _StateSelfManageTapBoxState createState() => _StateSelfManageTapBoxState();
}

class _StateSelfManageTapBoxState extends State<StateSelfManageTapBox> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            _active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// -------------------- State managed by Parent Widget -------------------------
class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChildWidgetTapBox(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class ChildWidgetTapBox extends StatelessWidget {
  ChildWidgetTapBox(
      {Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        child: Center(
          child: Text(
            active ? 'Active' : 'Inactive',
            style: TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}
