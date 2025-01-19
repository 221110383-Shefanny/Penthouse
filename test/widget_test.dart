import 'package:flutter/material.dart';
import 'package:flutter_application_9/pages/supervisor/supervisor_home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Date format test', (WidgetTester tester) async {
    final homePage = HomePage(
      userName: 'Test User',
      userRole: 'Manager',
      userEmail: 'test@example.com',
      userIcon: Icons.person,
      userUid: 'uid123',
      phoneNumber: '123456789',
      address: 'Test Address',
      dateOfBirth: '2000-01-01',
      dateJoined: '2020-01-01',
    );

    await tester.pumpWidget(MaterialApp(home: homePage));

    final formattedDateOfBirth = homePage.formatDate('2000-01-01');
    final formattedDateJoined = homePage.formatDate('2020-01-01');

    expect(formattedDateOfBirth, '01 January 2000');
    expect(formattedDateJoined, '01 January 2020');
  });

  testWidgets('Invalid date format returns "Invalid Date"',
      (WidgetTester tester) async {
    final homePage = HomePage(
      userName: 'Test User',
      userRole: 'Manager',
      userEmail: 'test@example.com',
      userIcon: Icons.person,
      userUid: 'uid123',
      phoneNumber: '123456789',
      address: 'Test Address',
      dateOfBirth: 'invalid-date',
      dateJoined: 'invalid-date',
    );

    await tester.pumpWidget(MaterialApp(home: homePage));

    final formattedInvalidDate = homePage.formatDate('invalid-date');

    expect(formattedInvalidDate, 'Invalid Date');
  });
}
