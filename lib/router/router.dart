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

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/detail_screen.dart';
import '../screens/read_book_screen.dart';
import 'app_state.dart';

import '../screens/home_screen.dart';
import '../screens/login_screen.dart';
import '../screens/my_books_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/signup_screen.dart';
import 'pages.dart';

class RwBookRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<MaterialPage> _pages = [];

  @override
  GlobalKey<NavigatorState>? navigatorKey;

  final AppState appState;

  RwBookRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration {
    print(_pages.last.key);
    return _pages.last.arguments as PageConfiguration;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  // ignore: avoid_annotating_with_dynamic
  bool _onPopPage(Route<dynamic> route, dynamic result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void _removePage(MaterialPage page) {
    if (page != null) {
      _pages.remove(page);
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage<MaterialPage>(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget? child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child!, pageConfig),
    );
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).pages != pageConfig.pages;

    if (shouldAddPage) {
      switch (pageConfig.pages) {
        case Pages.Login:
          _addPageData(const LoginScreen(), LoginPageConfig);
          break;
        case Pages.SignUp:
          _addPageData(const SignupScreen(), SignupPageConfig);

          break;
        case Pages.Home:
          _addPageData(const HomeScreen(), HomePageConfig);

          break;
        case Pages.Details:
          if (pageConfig.currentPageAction != null) {
            _addPageData(pageConfig.currentPageAction!.widget, pageConfig);
          }
          break;
        case Pages.Cart:
          _addPageData(const CartScreen(), CartPageConfig);
          break;
        case Pages.Checkout:
          if (pageConfig.currentPageAction != null) {
            _addPageData(const CheckoutScreen(), CheckoutPageConfig);
          }
          break;
        case Pages.Mybook:
          _addPageData(const MyBooksScreen(), MyBookPageConfig);

          break;
        case Pages.ReadBook:
          if (pageConfig.currentPageAction != null) {
            _addPageData(pageConfig.currentPageAction!.widget, pageConfig);
          }
          break;
        case Pages.Settings:
          _addPageData(SettingsScreen(), SettingsPageConfig);

          break;
        default:
          break;
      }
    }
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).pages !=
            configuration.pages;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void _setPageAction(PageAction action) {
    switch (action.page!.pages) {
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.SignUp:
        SignupPageConfig.currentPageAction = action;
        break;
      case Pages.Home:
        HomePageConfig.currentPageAction = action;
        break;
      case Pages.Details:
        DetailsPageConfig.currentPageAction = action;
        break;
      case Pages.Cart:
        CartPageConfig.currentPageAction = action;
        break;
      case Pages.Checkout:
        CheckoutPageConfig.currentPageAction = action;
        break;
      case Pages.Mybook:
        MyBookPageConfig.currentPageAction = action;
        break;
      case Pages.ReadBook:
        ReadBookPageConfig.currentPageAction = action;
        break;
      case Pages.Settings:
        SettingsPageConfig.currentPageAction = action;
        break;
    }
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        _setPageAction(appState.currentAction);
        addPage(appState.currentAction.page!);
        break;
      case PageState.pop:
        pop();
        break;
      case PageState.replace:
        _setPageAction(appState.currentAction);
        replace(appState.currentAction.page!);
        break;
      case PageState.replaceAll:
        _setPageAction(appState.currentAction);
        replaceAll(appState.currentAction.page!);
        break;
      case PageState.addWidget:
        _setPageAction(appState.currentAction);
        pushWidget(
            appState.currentAction.widget!, appState.currentAction.page!);
        break;
      case PageState.addAll:
        addAll(appState.currentAction.pages!);
        break;
      default:
        break;
    }
    appState.resetCurrentAction();
    return List.of(_pages);
  }

  void parseRouter(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      setNewRoutePath(LoginPageConfig);
      return;
    }
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] == 'details') {
        pushWidget(
            DetailsScreen(
                bookData: uri.pathSegments[1] as Map<String, dynamic>),
            DetailsPageConfig);
      } else if (uri.pathSegments[0] == 'readBook') {
        pushWidget(
            ReadBookScreen(
                bookData: uri.pathSegments[1] as Map<String, dynamic>),
            ReadBookPageConfig);
      }
    } else if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];

      switch (path) {
        case 'login':
          setPath([
            _createPage(SignupScreen(), HomePageConfig),
            _createPage(HomeScreen(), CartPageConfig),
          ]);
          break;
        case 'signup':
          replaceAll(SignupPageConfig);
          break;
        case 'home':
          setPath([
            _createPage(HomeScreen(), HomePageConfig),
            _createPage(CartScreen(), CartPageConfig),
          ]);
          break;
        case 'cart':
          setPath([
            _createPage(HomeScreen(), HomePageConfig),
            _createPage(CartScreen(), CartPageConfig)
          ]);
          break;

        case 'mybook':
          setPath([
            _createPage(HomeScreen(), HomePageConfig),
            _createPage(MyBooksScreen(), MyBookPageConfig)
          ]);
          break;

        case 'settings':
          setPath([
            _createPage(HomeScreen(), HomePageConfig),
            _createPage(SettingsScreen(), SettingsPageConfig)
          ]);
          break;
        case 'checkout':
          setPath([
            _createPage(HomeScreen(), HomePageConfig),
            _createPage(CheckoutScreen(), CheckoutPageConfig)
          ]);
          break;
      }
    }
  }
}
