# Emscripten dylink and pthread demo

This demo shows how to build a dynamic library with pthread support in Emscripten.

First, [googletest](https://github.com/google/googletest/) is built as a dynamic library with pthread support.

Then an example test that dynamically links to googletest is also built as a dynamic library with pthread support. Although it is built as dynamic library this module contains the `main` entry point.

Finally, an empty file is built as Emscripten's main module, which hosts the system libraries. This main module dynamically links to the example test library.

## Build

Run the following commands to build the demo and launch a local web server.

```
$ docker build -t emscripten-dylink .
$ docker run --rm -it --net=host -v "$(pwd)":"/app/" emscripten-dylink
```

Once the build has finished visit [http://localhost:5000/main.html](http://localhost:5000/main.html) to see the test running in your browser. You should see the following output (up to timing differences):
```
[==========] Running 2 tests from 1 test suite.
[----------] Global test environment set-up.
[----------] 2 tests from StrCompare
[ RUN      ] StrCompare.CStrEqual
[       OK ] StrCompare.CStrEqual (614 ms)
[ RUN      ] StrCompare.CStrNotEqual
src/string-compare.cpp:19: Failure
Expected equality of these values:
  expectVal
    Which is: "hello gtest"
  actualValFalse
    Which is: "hello world"
[  FAILED  ] StrCompare.CStrNotEqual (12 ms)
[----------] 2 tests from StrCompare (632 ms total)

[----------] Global test environment tear-down
[==========] 2 tests from 1 test suite ran. (643 ms total)
[  PASSED  ] 1 test.
[  FAILED  ] 1 test, listed below:
[  FAILED  ] StrCompare.CStrNotEqual

 1 FAILED TEST
```
