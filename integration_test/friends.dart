// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:test_drive/src/screens/friends_screen.dart';

import './friends.mocks.dart';

@GenerateMocks(
    [DatabaseReference, DatabaseEvent, DataSnapshot, StreamSubscription])
void main() {
  group('FriendsListScreen Tests', () {
    testWidgets('Init State sets up the friends stream subscription',
        (WidgetTester tester) async {
      // Set up mock references
      final mockRef = MockDatabaseReference();
      when(mockRef.child(any)).thenReturn(mockRef);
      when(mockRef.onValue).thenAnswer(
        (_) => Stream.fromIterable([MockDatabaseEvent()]),
      );

      await tester.pumpWidget(const MaterialApp(home: FriendsListScreen()));

      // Verify initState behavior
      verify(mockRef.onValue).called(1);
    });

    testWidgets('Dispose cancels the stream subscription',
        (WidgetTester tester) async {
      final mockSubscription = MockStreamSubscription<List<String>>();
      final screenState = FriendsListScreenState();

      // Simulate setting a subscription
      screenState.friendsSubscription = mockSubscription;
      screenState.dispose();

      // Verify cancellation on dispose
      verify(mockSubscription.cancel()).called(1);
    });

    testWidgets('Load Friends from Firebase', (WidgetTester tester) async {
      final mockRef = MockDatabaseReference();
      final mockEvent = MockDatabaseEvent();
      final mockSnapshot = MockDataSnapshot();

      when(mockRef.child(any)).thenReturn(mockRef);
      when(mockRef.onValue).thenAnswer((_) => Stream.value(mockEvent));
      when(mockEvent.snapshot).thenReturn(mockSnapshot);
      when(mockSnapshot.value).thenReturn({
        '1': {'username': 'John'},
        '2': {'username': 'Jane'}
      });

      await tester.pumpWidget(const MaterialApp(home: FriendsListScreen()));

      // Expect two friends loaded
      expect(find.text('John'), findsOneWidget);
      expect(find.text('Jane'), findsOneWidget);
    });

    testWidgets('Perform search and update results',
        (WidgetTester tester) async {
      final mockRef = MockDatabaseReference();
      final mockEvent = MockDatabaseEvent();
      final mockSnapshot = MockDataSnapshot();

      when(mockRef.orderByChild(any)).thenReturn(mockRef);
      when(mockRef.startAt(any)).thenReturn(mockRef);
      when(mockRef.endAt(any)).thenReturn(mockRef);
      when(mockRef.once()).thenAnswer((_) async => mockEvent);
      when(mockEvent.snapshot).thenReturn(mockSnapshot);
      when(mockSnapshot.value).thenReturn({
        '1': {'username': 'Alice'},
        '2': {'username': 'Bob'}
      });

      await tester.pumpWidget(const MaterialApp(home: FriendsListScreen()));

      // Simulate search
      await tester.enterText(find.byType(TextField), 'A');
      await tester.pumpAndSettle();

      // Check if Alice and Bob appear in search results
      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
    });
  });
}
