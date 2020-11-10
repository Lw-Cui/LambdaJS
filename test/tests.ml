
open OUnit2

let tests = "test suite for rev" >::: [
  "empty"  >:: (fun _ -> assert_equal true true);
]

let _ = run_test_tt_main tests