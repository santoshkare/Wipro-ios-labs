# Wipro Swift Lab 1A

## Test Cases – Swift Basics, Variables, Types and Operators

**Student Name:** Santosh Kare  
**Roll Number:** 101  
**Programming Language:** Swift  
**Compiler Version:** Swift 6.1.3

---

## 1. Test Case Table

| Test Case | Input / Condition | Expected Output | Actual Output | Status |
|---|---|---|---|---|
| TC-01 | Marks: 85, 78, 90, 75, 88 | Total: 416, Average: 83.2, Percentage: 83.2%, PASS | Total: 416, Average: 83.2, PASS | PASS |
| TC-02 | All five subject marks: 0 | Total: 0, Percentage: 0%, FAIL | Total: 0, Percentage: 0%, FAIL | PASS |
| TC-03 | All five subject marks: 100 | Total: 500, Percentage: 100%, PASS | Total: 500, Percentage: 100%, PASS | PASS |
| TC-04 | Marks: 30, 80, 80, 80, 80 | Percentage: 70%, FAIL | Percentage: 70%, FAIL | PASS |
| TC-05 | All five subject marks: 35 | Total: 175, Percentage: 35%, PASS | Total: 175, Percentage: 35%, PASS | PASS |
| TC-06 | Attendance: 105% | Invalid Attendance | Invalid Attendance | PASS |
| TC-07 | Attendance: 0% | Valid Attendance | Valid Attendance | PASS |
| TC-08 | Optional student name: nil | Unknown Student | Unknown Student | PASS |

---

## 2. Test Case Details

### TC-01: Normal Marks
- Input: 85, 78, 90, 75, 88
- Expected Total: 416
- Expected Average: 83.2
- Expected Percentage: 83.2%
- Actual Result: PASS

### TC-02: Minimum Marks
- Input: 0, 0, 0, 0, 0
- Expected Total: 0
- Expected Percentage: 0%
- Actual Result: FAIL

### TC-03: Maximum Marks
- Input: 100, 100, 100, 100, 100
- Expected Total: 500
- Expected Percentage: 100%
- Actual Result: PASS

### TC-04: Failing Marks
- Input: 30, 80, 80, 80, 80
- Expected Percentage: 70%
- Reason: One subject has less than 35 marks.
- Actual Result: FAIL

### TC-05: Passing Boundary
- Input: 35, 35, 35, 35, 35
- Expected Total: 175
- Expected Percentage: 35%
- Actual Result: PASS

### TC-06: Invalid Attendance
- Input: Attendance = 105%
- Actual Output: Invalid Attendance

### TC-07: Zero Attendance
- Input: Attendance = 0%
- Actual Output: Valid Attendance

### TC-08: Nil-Coalescing Operator
- Input: Optional Student Name = nil
- Actual Output: Unknown Student

---

## 3. Test Summary

- Total Test Cases: 8
- Passed Test Cases: 8
- Failed Test Cases: 0
- Passing Boundary: 35 marks per subject
- Minimum Marks: 0
- Maximum Marks: 100
- Valid Attendance Range: 0% to 100%
- Nil-Coalescing Default Value: Unknown Student

---

## 4. Conclusion

All eight test cases were executed successfully using the Swift program.

The program demonstrates variables, data types, arithmetic calculations, operators, conditional statements, switch statements, pass/fail conditions, attendance validation, and nil-coalescing behavior.

**Final Status: All 8 Test Cases Passed.**