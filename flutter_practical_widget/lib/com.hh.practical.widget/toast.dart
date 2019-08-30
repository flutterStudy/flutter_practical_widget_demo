import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';

///浮窗提示
class Toast
{
    static Queue<_ToastItem> _queue = Queue();

    static void show(BuildContext context, String tipText, {Duration duration = const Duration(seconds: 3)})
    {
        cancel();
        _ToastItem toastItem = _ToastItem(context, tipText, duration, ()
        {
            _ToastItem toastItem = _queue.removeFirst();
            toastItem.cancel();
        });
        toastItem.show();
        _queue.add(toastItem);
    }

    static void cancel()
    {
        while(_queue.length > 0)
        {
            _ToastItem toastItem = _queue.removeFirst();
            toastItem.cancel();
        }
    }
}

class _ToastItem
{
    final BuildContext context;
    final String tipText;
    final Duration duration;
    final VoidCallback callback;

    OverlayEntry _overlayEntry;
    Timer _timer;
    TextStyle _textStyle = TextStyle(color: Colors.white, fontSize: 16.0);

    _ToastItem(this.context, this.tipText, this.duration, this.callback);

    void show()
    {
        WidgetBuilder widgetBuilder = (BuildContext context)
        {
            Text text = Text(tipText, style: _textStyle,);
            Widget widget = Center(
                child: Container(
                    //color: Colors.black.withOpacity(0.5),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Material(child: text, color: Colors.transparent,),
                ),
            );
            return widget;
        };

        _overlayEntry = OverlayEntry(builder: widgetBuilder);
        Overlay.of(context).insert(_overlayEntry);
        _timer = Timer(duration, callback);
    }

    void cancel()
    {
        _overlayEntry?.remove();
        _timer?.cancel();
    }
}