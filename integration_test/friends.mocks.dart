// Mocks generated by Mockito 5.4.4 from annotations
// in test_drive/test/friends.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:firebase_database/firebase_database.dart' as _i2;
import 'package:firebase_database_platform_interface/firebase_database_platform_interface.dart'
    as _i5;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDatabaseReference_0 extends _i1.SmartFake
    implements _i2.DatabaseReference {
  _FakeDatabaseReference_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeTransactionResult_1 extends _i1.SmartFake
    implements _i2.TransactionResult {
  _FakeTransactionResult_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeOnDisconnect_2 extends _i1.SmartFake implements _i2.OnDisconnect {
  _FakeOnDisconnect_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDataSnapshot_3 extends _i1.SmartFake implements _i2.DataSnapshot {
  _FakeDataSnapshot_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeDatabaseEvent_4 extends _i1.SmartFake implements _i2.DatabaseEvent {
  _FakeDatabaseEvent_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuery_5 extends _i1.SmartFake implements _i2.Query {
  _FakeQuery_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFuture_6<T1> extends _i1.SmartFake implements _i3.Future<T1> {
  _FakeFuture_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [DatabaseReference].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseReference extends _i1.Mock implements _i2.DatabaseReference {
  MockDatabaseReference() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseReference get root => (super.noSuchMethod(
        Invocation.getter(#root),
        returnValue: _FakeDatabaseReference_0(
          this,
          Invocation.getter(#root),
        ),
      ) as _i2.DatabaseReference);

  @override
  _i2.DatabaseReference get ref => (super.noSuchMethod(
        Invocation.getter(#ref),
        returnValue: _FakeDatabaseReference_0(
          this,
          Invocation.getter(#ref),
        ),
      ) as _i2.DatabaseReference);

  @override
  String get path => (super.noSuchMethod(
        Invocation.getter(#path),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#path),
        ),
      ) as String);

  @override
  _i3.Stream<_i2.DatabaseEvent> get onChildAdded => (super.noSuchMethod(
        Invocation.getter(#onChildAdded),
        returnValue: _i3.Stream<_i2.DatabaseEvent>.empty(),
      ) as _i3.Stream<_i2.DatabaseEvent>);

  @override
  _i3.Stream<_i2.DatabaseEvent> get onChildRemoved => (super.noSuchMethod(
        Invocation.getter(#onChildRemoved),
        returnValue: _i3.Stream<_i2.DatabaseEvent>.empty(),
      ) as _i3.Stream<_i2.DatabaseEvent>);

  @override
  _i3.Stream<_i2.DatabaseEvent> get onChildChanged => (super.noSuchMethod(
        Invocation.getter(#onChildChanged),
        returnValue: _i3.Stream<_i2.DatabaseEvent>.empty(),
      ) as _i3.Stream<_i2.DatabaseEvent>);

  @override
  _i3.Stream<_i2.DatabaseEvent> get onChildMoved => (super.noSuchMethod(
        Invocation.getter(#onChildMoved),
        returnValue: _i3.Stream<_i2.DatabaseEvent>.empty(),
      ) as _i3.Stream<_i2.DatabaseEvent>);

  @override
  _i3.Stream<_i2.DatabaseEvent> get onValue => (super.noSuchMethod(
        Invocation.getter(#onValue),
        returnValue: _i3.Stream<_i2.DatabaseEvent>.empty(),
      ) as _i3.Stream<_i2.DatabaseEvent>);

  @override
  _i2.DatabaseReference child(String? path) => (super.noSuchMethod(
        Invocation.method(
          #child,
          [path],
        ),
        returnValue: _FakeDatabaseReference_0(
          this,
          Invocation.method(
            #child,
            [path],
          ),
        ),
      ) as _i2.DatabaseReference);

  @override
  _i2.DatabaseReference push() => (super.noSuchMethod(
        Invocation.method(
          #push,
          [],
        ),
        returnValue: _FakeDatabaseReference_0(
          this,
          Invocation.method(
            #push,
            [],
          ),
        ),
      ) as _i2.DatabaseReference);

  @override
  _i3.Future<void> set(Object? value) => (super.noSuchMethod(
        Invocation.method(
          #set,
          [value],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setWithPriority(
    Object? value,
    Object? priority,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #setWithPriority,
          [
            value,
            priority,
          ],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> update(Map<String, Object?>? value) => (super.noSuchMethod(
        Invocation.method(
          #update,
          [value],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> setPriority(Object? priority) => (super.noSuchMethod(
        Invocation.method(
          #setPriority,
          [priority],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> remove() => (super.noSuchMethod(
        Invocation.method(
          #remove,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<_i2.TransactionResult> runTransaction(
    _i5.TransactionHandler? transactionHandler, {
    bool? applyLocally = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #runTransaction,
          [transactionHandler],
          {#applyLocally: applyLocally},
        ),
        returnValue:
            _i3.Future<_i2.TransactionResult>.value(_FakeTransactionResult_1(
          this,
          Invocation.method(
            #runTransaction,
            [transactionHandler],
            {#applyLocally: applyLocally},
          ),
        )),
      ) as _i3.Future<_i2.TransactionResult>);

  @override
  _i2.OnDisconnect onDisconnect() => (super.noSuchMethod(
        Invocation.method(
          #onDisconnect,
          [],
        ),
        returnValue: _FakeOnDisconnect_2(
          this,
          Invocation.method(
            #onDisconnect,
            [],
          ),
        ),
      ) as _i2.OnDisconnect);

  @override
  _i3.Future<_i2.DataSnapshot> get() => (super.noSuchMethod(
        Invocation.method(
          #get,
          [],
        ),
        returnValue: _i3.Future<_i2.DataSnapshot>.value(_FakeDataSnapshot_3(
          this,
          Invocation.method(
            #get,
            [],
          ),
        )),
      ) as _i3.Future<_i2.DataSnapshot>);

  @override
  _i3.Future<_i2.DatabaseEvent> once(
          [_i5.DatabaseEventType? eventType = _i5.DatabaseEventType.value]) =>
      (super.noSuchMethod(
        Invocation.method(
          #once,
          [eventType],
        ),
        returnValue: _i3.Future<_i2.DatabaseEvent>.value(_FakeDatabaseEvent_4(
          this,
          Invocation.method(
            #once,
            [eventType],
          ),
        )),
      ) as _i3.Future<_i2.DatabaseEvent>);

  @override
  _i2.Query startAt(
    Object? value, {
    String? key,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #startAt,
          [value],
          {#key: key},
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #startAt,
            [value],
            {#key: key},
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query startAfter(
    Object? value, {
    String? key,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #startAfter,
          [value],
          {#key: key},
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #startAfter,
            [value],
            {#key: key},
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query endAt(
    Object? value, {
    String? key,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #endAt,
          [value],
          {#key: key},
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #endAt,
            [value],
            {#key: key},
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query endBefore(
    Object? value, {
    String? key,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #endBefore,
          [value],
          {#key: key},
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #endBefore,
            [value],
            {#key: key},
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query equalTo(
    Object? value, {
    String? key,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #equalTo,
          [value],
          {#key: key},
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #equalTo,
            [value],
            {#key: key},
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query limitToFirst(int? limit) => (super.noSuchMethod(
        Invocation.method(
          #limitToFirst,
          [limit],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #limitToFirst,
            [limit],
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query limitToLast(int? limit) => (super.noSuchMethod(
        Invocation.method(
          #limitToLast,
          [limit],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #limitToLast,
            [limit],
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query orderByChild(String? path) => (super.noSuchMethod(
        Invocation.method(
          #orderByChild,
          [path],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #orderByChild,
            [path],
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query orderByKey() => (super.noSuchMethod(
        Invocation.method(
          #orderByKey,
          [],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #orderByKey,
            [],
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query orderByValue() => (super.noSuchMethod(
        Invocation.method(
          #orderByValue,
          [],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #orderByValue,
            [],
          ),
        ),
      ) as _i2.Query);

  @override
  _i2.Query orderByPriority() => (super.noSuchMethod(
        Invocation.method(
          #orderByPriority,
          [],
        ),
        returnValue: _FakeQuery_5(
          this,
          Invocation.method(
            #orderByPriority,
            [],
          ),
        ),
      ) as _i2.Query);

  @override
  _i3.Future<void> keepSynced(bool? value) => (super.noSuchMethod(
        Invocation.method(
          #keepSynced,
          [value],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}

/// A class which mocks [DatabaseEvent].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseEvent extends _i1.Mock implements _i2.DatabaseEvent {
  MockDatabaseEvent() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.DatabaseEventType get type => (super.noSuchMethod(
        Invocation.getter(#type),
        returnValue: _i5.DatabaseEventType.childAdded,
      ) as _i5.DatabaseEventType);

  @override
  _i2.DataSnapshot get snapshot => (super.noSuchMethod(
        Invocation.getter(#snapshot),
        returnValue: _FakeDataSnapshot_3(
          this,
          Invocation.getter(#snapshot),
        ),
      ) as _i2.DataSnapshot);
}

/// A class which mocks [DataSnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataSnapshot extends _i1.Mock implements _i2.DataSnapshot {
  MockDataSnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.DatabaseReference get ref => (super.noSuchMethod(
        Invocation.getter(#ref),
        returnValue: _FakeDatabaseReference_0(
          this,
          Invocation.getter(#ref),
        ),
      ) as _i2.DatabaseReference);

  @override
  bool get exists => (super.noSuchMethod(
        Invocation.getter(#exists),
        returnValue: false,
      ) as bool);

  @override
  Iterable<_i2.DataSnapshot> get children => (super.noSuchMethod(
        Invocation.getter(#children),
        returnValue: <_i2.DataSnapshot>[],
      ) as Iterable<_i2.DataSnapshot>);

  @override
  bool hasChild(String? path) => (super.noSuchMethod(
        Invocation.method(
          #hasChild,
          [path],
        ),
        returnValue: false,
      ) as bool);

  @override
  _i2.DataSnapshot child(String? path) => (super.noSuchMethod(
        Invocation.method(
          #child,
          [path],
        ),
        returnValue: _FakeDataSnapshot_3(
          this,
          Invocation.method(
            #child,
            [path],
          ),
        ),
      ) as _i2.DataSnapshot);
}

/// A class which mocks [StreamSubscription].
///
/// See the documentation for Mockito's code generation for more information.
class MockStreamSubscription<T> extends _i1.Mock
    implements _i3.StreamSubscription<T> {
  MockStreamSubscription() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get isPaused => (super.noSuchMethod(
        Invocation.getter(#isPaused),
        returnValue: false,
      ) as bool);

  @override
  _i3.Future<void> cancel() => (super.noSuchMethod(
        Invocation.method(
          #cancel,
          [],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  void onData(void Function(T)? handleData) => super.noSuchMethod(
        Invocation.method(
          #onData,
          [handleData],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(Function? handleError) => super.noSuchMethod(
        Invocation.method(
          #onError,
          [handleError],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onDone(void Function()? handleDone) => super.noSuchMethod(
        Invocation.method(
          #onDone,
          [handleDone],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void pause([_i3.Future<void>? resumeSignal]) => super.noSuchMethod(
        Invocation.method(
          #pause,
          [resumeSignal],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void resume() => super.noSuchMethod(
        Invocation.method(
          #resume,
          [],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i3.Future<E> asFuture<E>([E? futureValue]) => (super.noSuchMethod(
        Invocation.method(
          #asFuture,
          [futureValue],
        ),
        returnValue: _i4.ifNotNull(
              _i4.dummyValueOrNull<E>(
                this,
                Invocation.method(
                  #asFuture,
                  [futureValue],
                ),
              ),
              (E v) => _i3.Future<E>.value(v),
            ) ??
            _FakeFuture_6<E>(
              this,
              Invocation.method(
                #asFuture,
                [futureValue],
              ),
            ),
      ) as _i3.Future<E>);
}
