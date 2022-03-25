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
// Software in any work that is designed, intended, or marketed for pedagogical
// or instructional purposes related to programming, coding, application
// development, or information technology.  Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing, creation of
// derivative works, or sale is expressly withheld.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import 'app_state.dart';

const String LoginPath = '/login';
const String SignupPath = '/signup';
const String HomePath = '/home';
const String DetailPath = '/details';
const String CartPath = '/cart';
const String CheckoutPath = '/checkout';
const String MybookPath = '/myBook';
const String ReadBookPath = '/readBook';
const String SettingsPath = '/settings';

enum Pages {
  Login,
  SignUp,
  Home,
  Details,
  Cart,
  Checkout,
  Mybook,
  ReadBook,
  Settings
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages pages;
  PageAction? currentPageAction;

  PageConfiguration(
      {required this.key,
      required this.path,
      required this.pages,
      this.currentPageAction});
}

PageConfiguration LoginPageConfig = PageConfiguration(
    key: 'Login', path: LoginPath, pages: Pages.Login, currentPageAction: null);

PageConfiguration SignupPageConfig = PageConfiguration(
    key: 'SignUp',
    path: SignupPath,
    pages: Pages.SignUp,
    currentPageAction: null);

PageConfiguration HomePageConfig = PageConfiguration(
    key: 'Home', path: HomePath, pages: Pages.Home, currentPageAction: null);

PageConfiguration DetailsPageConfig = PageConfiguration(
    key: 'Details',
    path: DetailPath,
    pages: Pages.Details,
    currentPageAction: null);

PageConfiguration CartPageConfig = PageConfiguration(
    key: 'Cart', path: CartPath, pages: Pages.Cart, currentPageAction: null);

PageConfiguration CheckoutPageConfig = PageConfiguration(
    key: 'Checkout',
    path: CheckoutPath,
    pages: Pages.Checkout,
    currentPageAction: null);

PageConfiguration MyBookPageConfig = PageConfiguration(
    key: 'MyBook',
    path: MybookPath,
    pages: Pages.Mybook,
    currentPageAction: null);

PageConfiguration ReadBookPageConfig = PageConfiguration(
    key: 'Login',
    path: ReadBookPath,
    pages: Pages.ReadBook,
    currentPageAction: null);

PageConfiguration SettingsPageConfig = PageConfiguration(
    key: 'Settings',
    path: SettingsPath,
    pages: Pages.Settings,
    currentPageAction: null);
