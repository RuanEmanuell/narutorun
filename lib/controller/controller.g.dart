// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Controller on _Controller, Store {
  late final _$diedAtom = Atom(name: '_Controller.died', context: context);

  @override
  bool get died {
    _$diedAtom.reportRead();
    return super.died;
  }

  @override
  set died(bool value) {
    _$diedAtom.reportWrite(value, super.died, () {
      super.died = value;
    });
  }

  late final _$scoreAtom = Atom(name: '_Controller.score', context: context);

  @override
  int get score {
    _$scoreAtom.reportRead();
    return super.score;
  }

  @override
  set score(int value) {
    _$scoreAtom.reportWrite(value, super.score, () {
      super.score = value;
    });
  }

  @override
  String toString() {
    return '''
died: ${died},
score: ${score}
    ''';
  }
}
