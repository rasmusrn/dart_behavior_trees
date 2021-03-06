library behavior_test;

import 'package:unittest/unittest.dart';
import 'package:behavior_trees/behavior_trees.dart';
import '../mocks.dart';

var update = new UpdateMock();

void main() {
  test("status", () {
    var behavior = new BehaviorMock(Status.RUNNING);
    expect(behavior.status, equals(Status.UNINITIALIZED));
    expect(behavior.update(update), equals(Status.RUNNING));
    expect(behavior.status, equals(Status.RUNNING));
    behavior.nextStatus = Status.FAILURE;
    expect(behavior.update(update), equals(Status.FAILURE));
    expect(behavior.status, equals(Status.FAILURE));
  });
  
  test("initialization", () {
    var behavior = new BehaviorMock(Status.RUNNING);
    expect(behavior.initializeCalls, equals(0));
    behavior.update(update);
    expect(behavior.initializeCalls, equals(1));
    behavior.update(update);
    expect(behavior.initializeCalls, equals(1));
  });
  
  test("termination", () {
    var behavior = new BehaviorMock(Status.RUNNING);
    expect(behavior.terminationCalls, equals(0));
    behavior.update(update);
    expect(behavior.terminationCalls, equals(0));
    behavior.nextStatus = Status.SUCCESS;
    behavior.update(update);
    expect(behavior.terminationCalls, equals(1));
  });
}
