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
          // To show the example that state is managed by parent widget
          //child: ParentWidget(),
          // To show the example that state is managed by the widget itself
          // child: StateSelfManageTapBox(),
          // To show the example that state is managed in a mix-and-match approach
          child: AnotherParentWidget(),
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
  ChildWidgetTapBox({Key key, this.active: false, @required this.onChanged})
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

// ---------------- State managed by mix-and-match approach --------------------
class AnotherParentWidget extends StatefulWidget {
  @override
  _AnotherParentWidgetState createState() => _AnotherParentWidgetState();
}

class _AnotherParentWidgetState extends State<AnotherParentWidget> {
  bool _active = false;

  void _handleTapBoxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MixedApproachTapBox(
        active: _active,
        onChanged: _handleTapBoxChanged,
      ),
    );
  }
}

class MixedApproachTapBox extends StatefulWidget {
  MixedApproachTapBox({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  _StateMixApproachTapBox createState() => _StateMixApproachTapBox();
}

class _StateMixApproachTapBox extends State<MixedApproachTapBox> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // This example adds a green border on tap down
    // On tap up, the square changes to the opposite state
    return GestureDetector(
        onTapDown: _handleTapDown,
        // to handle the tap events in the order that
        onTapUp: _handleTapUp,
        // they occur, down, up, tap, cancel
        onTap: _handleTap,
        onTapCancel: _handleTapCancel,
        child: Container(
          child: Center(
            child: Text(widget.active ? 'Active' : 'Inactive',
                style: TextStyle(fontSize: 32.0, color: Colors.white)),
          ),
          width: 200.0,
          height: 200.0,
          decoration: BoxDecoration(
            color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
            border: _highlight
                ? Border.all(color: Colors.teal[700], width: 10.0)
                : null,
          ),
        ));
  }
}
