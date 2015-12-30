# CMake generated Testfile for 
# Source directory: /Users/sha/Code/EnvPane/cmark/test
# Build directory: /Users/sha/Code/EnvPane/cmark_xcode/testdir
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
if("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(api_test "/Users/sha/Code/EnvPane/cmark_xcode/api_test/Debug/api_test")
elseif("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(api_test "/Users/sha/Code/EnvPane/cmark_xcode/api_test/Release/api_test")
elseif("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test(api_test "/Users/sha/Code/EnvPane/cmark_xcode/api_test/MinSizeRel/api_test")
elseif("${CTEST_CONFIGURATION_TYPE}" MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test(api_test "/Users/sha/Code/EnvPane/cmark_xcode/api_test/RelWithDebInfo/api_test")
else()
  add_test(api_test NOT_AVAILABLE)
endif()
add_test(html_normalization "/usr/local/bin/python3" "-m" "doctest" "/Users/sha/Code/EnvPane/cmark/test/normalize.py")
add_test(spectest_library "/usr/local/bin/python3" "/Users/sha/Code/EnvPane/cmark/test/spec_tests.py" "--no-normalize" "--spec" "/Users/sha/Code/EnvPane/cmark/test/spec.txt" "--library-dir" "/Users/sha/Code/EnvPane/cmark_xcode/testdir/../src")
add_test(pathological_tests_library "/usr/local/bin/python3" "/Users/sha/Code/EnvPane/cmark/test/pathological_tests.py" "--library-dir" "/Users/sha/Code/EnvPane/cmark_xcode/testdir/../src")
add_test(spectest_executable "/usr/local/bin/python3" "/Users/sha/Code/EnvPane/cmark/test/spec_tests.py" "--no-normalize" "--spec" "/Users/sha/Code/EnvPane/cmark/test/spec.txt" "--program" "/Users/sha/Code/EnvPane/cmark_xcode/testdir/../src/cmark")
add_test(smartpuncttest_executable "/usr/local/bin/python3" "/Users/sha/Code/EnvPane/cmark/test/spec_tests.py" "--no-normalize" "--spec" "/Users/sha/Code/EnvPane/cmark/test/smart_punct.txt" "--program" "/Users/sha/Code/EnvPane/cmark_xcode/testdir/../src/cmark --smart")
add_test(roundtriptest_executable "/usr/local/bin/python3" "/Users/sha/Code/EnvPane/cmark/test/spec_tests.py" "--no-normalize" "--spec" "/Users/sha/Code/EnvPane/cmark/test/spec.txt" "--program" " /Users/sha/Code/EnvPane/cmark_xcode/testdir/../src/cmark")
