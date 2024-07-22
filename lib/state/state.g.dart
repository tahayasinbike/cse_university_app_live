// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$StateManage on _StateManageBase, Store {
  late final _$nameAtom = Atom(name: '_StateManageBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$obscureTextAtom =
      Atom(name: '_StateManageBase.obscureText', context: context);

  @override
  bool get obscureText {
    _$obscureTextAtom.reportRead();
    return super.obscureText;
  }

  @override
  set obscureText(bool value) {
    _$obscureTextAtom.reportWrite(value, super.obscureText, () {
      super.obscureText = value;
    });
  }

  late final _$isLoginAtom =
      Atom(name: '_StateManageBase.isLogin', context: context);

  @override
  bool get isLogin {
    _$isLoginAtom.reportRead();
    return super.isLogin;
  }

  @override
  set isLogin(bool value) {
    _$isLoginAtom.reportWrite(value, super.isLogin, () {
      super.isLogin = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_StateManageBase.errorMessage', context: context);

  @override
  String? get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String? value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$isIstunEmailAtom =
      Atom(name: '_StateManageBase.isIstunEmail', context: context);

  @override
  bool get isIstunEmail {
    _$isIstunEmailAtom.reportRead();
    return super.isIstunEmail;
  }

  @override
  set isIstunEmail(bool value) {
    _$isIstunEmailAtom.reportWrite(value, super.isIstunEmail, () {
      super.isIstunEmail = value;
    });
  }

  late final _$signOutAsyncAction =
      AsyncAction('_StateManageBase.signOut', context: context);

  @override
  Future<void> signOut() {
    return _$signOutAsyncAction.run(() => super.signOut());
  }

  late final _$resetPasswordAsyncAction =
      AsyncAction('_StateManageBase.resetPassword', context: context);

  @override
  Future<dynamic> resetPassword(
      {required dynamic emailController, required BuildContext context}) {
    return _$resetPasswordAsyncAction.run(() => super
        .resetPassword(emailController: emailController, context: context));
  }

  late final _$signInWithEmailAndPasswordAsyncAction = AsyncAction(
      '_StateManageBase.signInWithEmailAndPassword',
      context: context);

  @override
  Future<void> signInWithEmailAndPassword(
      {required dynamic emailController, required dynamic passwordController}) {
    return _$signInWithEmailAndPasswordAsyncAction.run(() => super
        .signInWithEmailAndPassword(
            emailController: emailController,
            passwordController: passwordController));
  }

  late final _$createUserWithEmailAndPasswordAsyncAction = AsyncAction(
      '_StateManageBase.createUserWithEmailAndPassword',
      context: context);

  @override
  Future<void> createUserWithEmailAndPassword(
      {required dynamic emailController,
      required dynamic passwordController,
      required BuildContext context}) {
    return _$createUserWithEmailAndPasswordAsyncAction.run(() => super
        .createUserWithEmailAndPassword(
            emailController: emailController,
            passwordController: passwordController,
            context: context));
  }

  late final _$_StateManageBaseActionController =
      ActionController(name: '_StateManageBase', context: context);

  @override
  void showHide() {
    final _$actionInfo = _$_StateManageBaseActionController.startAction(
        name: '_StateManageBase.showHide');
    try {
      return super.showHide();
    } finally {
      _$_StateManageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void checkEmail({required dynamic emailController}) {
    final _$actionInfo = _$_StateManageBaseActionController.startAction(
        name: '_StateManageBase.checkEmail');
    try {
      return super.checkEmail(emailController: emailController);
    } finally {
      _$_StateManageBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
obscureText: ${obscureText},
isLogin: ${isLogin},
errorMessage: ${errorMessage},
isIstunEmail: ${isIstunEmail}
    ''';
  }
}
