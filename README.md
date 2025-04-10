# brick_breaker

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


what i learned from correcting the code

focus node must be called explcitly can't count on the internal focus node

1. initlize a focus node seperately
late FocusNode _focusNode;
2. add the above focus node in the initstate then add and use _focusNode.requestFocus() inside the postframe widget call back
3. destroy the focus node to prevent the leckage of the memory
4. use  _focusNode.requestFocus() this in the ontap fuction to restore the focus if it is lost