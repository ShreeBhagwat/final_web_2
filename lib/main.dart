// Copyright (c) 2022 Razeware LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
// distribute, sublicense, create a derivative work, and/or sell copies of the
// Software in any work that is designed, intended or marketed for pedagogical
// or instructional purposes related to programming, coding, application
// development, or information technology.  Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing, creation of
// derivative works or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_strategy/url_strategy.dart';
import 'router/app_state.dart';
import 'router/back_dispatcher.dart';
import 'router/pages.dart';
import 'router/router.dart';
import 'router/rw_book_parser.dart';

void main() {
  setPathUrlStrategy();
  runApp(const RwBook());
}

class RwBook extends StatefulWidget {
  const RwBook({Key? key}) : super(key: key);

  @override
  State<RwBook> createState() => _RwBookState();
}

class _RwBookState extends State<RwBook> {
  final appState = AppState();
  late RwBookRouterDelegate delegate;
  final parser = RwBookParser();
  late RwBookBackButtonDispatcher backButtonDispatcher;

  late StreamSubscription _linkSubscription;

  _RwBookState() {
    delegate = RwBookRouterDelegate(appState);
    delegate.setNewRoutePath(LoginPageConfig);
    backButtonDispatcher = RwBookBackButtonDispatcher(delegate);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: parser,
        routerDelegate: delegate,
        backButtonDispatcher: backButtonDispatcher,
      ),
    );
  }
}
