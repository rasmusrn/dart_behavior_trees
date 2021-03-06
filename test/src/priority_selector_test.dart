library priority_selector_test;

import 'package:unittest/unittest.dart';
import 'package:behavior_trees/behavior_trees.dart';
import '../mocks.dart';

var update = new UpdateMock();

void main() {
  test("returns running if one child is running", () {
    var selector = new PrioritySelectorMock(3, Status.FAILURE);
    selector[1].nextStatus = Status.RUNNING;
    
    var result = selector.update(update);
    expect(result, equals(Status.RUNNING));
    
    selector[0].nextStatus = Status.RUNNING;
    selector[1].nextStatus = Status.FAILURE;
    
    result = selector.update(update);
    expect(result, equals(Status.RUNNING));
  });
  
  test("returns success if one child is succeeded", () {
    var selector = new PrioritySelectorMock(3, Status.FAILURE);
    selector[1].nextStatus = Status.SUCCESS;
    
    var result = selector.update(update);
    expect(result, equals(Status.SUCCESS));
    
    selector[0].nextStatus = Status.SUCCESS;
    selector[1].nextStatus = Status.FAILURE;
    
    result = selector.update(update);
    expect(result, equals(Status.SUCCESS));
  });
  
  test("fails if all children fail", () {
    var selector = new PrioritySelectorMock(3, Status.FAILURE);
    var result = selector.update(update);
    expect(result, equals(Status.FAILURE));
  });
  
  test("it resets children", () {
    var selector = new PrioritySelectorMock(4, Status.FAILURE);
    selector[3].nextStatus = Status.RUNNING;
    
    selector.update(update);
    expect(selector[3].status, equals(Status.RUNNING));
    
    selector[1].nextStatus = Status.RUNNING;
    selector.update(update);
    
    expect(selector[0].status, equals(Status.FAILURE));
    expect(selector[1].status, equals(Status.RUNNING));
    expect(selector[2].status, equals(Status.UNINITIALIZED));
    expect(selector[3].status, equals(Status.UNINITIALIZED));
  });
}
