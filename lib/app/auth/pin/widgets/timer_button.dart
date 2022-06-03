import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:smart_pay/utils/color_scheme.dart';

class TimerButton extends StatefulWidget {
  const TimerButton({
    Key? key,
    required this.onTap,
    this.buttonText,
    this.secs = 10,
    required this.isLoading,
  }) : super(key: key);
  final void Function(void Function())? onTap;
  final String? buttonText;
  final int secs;
  final bool isLoading;

  @override
  State<TimerButton> createState() => _TimerButtonState();
}

class _TimerButtonState extends State<TimerButton> {
  late Timer _timer;
  late int _start;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _start = widget.secs;
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _start > 0
          ? null
          : () {
              if (widget.onTap == null) return;
              widget.onTap!(startTimer);
              _start = widget.secs;
            },
      child: widget.isLoading
          ? const Center(
              child: CircularProgressIndicator.adaptive(
                  backgroundColor: kAccentColor))
          : Text(
              _start > 0
                  ? '$_start:00 | Resend Code'
                  : (widget.buttonText ?? 'Resend Code'),
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                textStyle: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: _start > 0
                          ? kAccentColor3
                          : null,
                    ),
              ),
            ),
    );
  }
}
