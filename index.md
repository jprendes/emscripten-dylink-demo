## Emscripten dylink and pthread demo

Run threaded unit tests in the browser

```c++
#include <gtest/gtest.h> // googletest header file
#include <thread>

const char *actualValTrue  = "hello gtest";
const char *actualValFalse = "hello world";
const char *expectVal      = "hello gtest";

TEST(StrCompare, CStrEqual) {
    std::thread([]{
        EXPECT_STREQ(expectVal, actualValTrue);
    }).join();
}

TEST(StrCompare, CStrNotEqual) {
    std::thread([]{
        EXPECT_STREQ(expectVal, actualValFalse);
    }).join();
}
```

<iframe src="./build/embedded.html" style="width:100%; height: 23em; border: none; resize: vertical; border-radius: 0.3rem;"></iframe>

### About

This demo shows how to build a dynamic library with pthread support in [Emscripten](https://emscripten.org/).

First, [googletest](https://github.com/google/googletest/) is built as a dynamic library with pthread support.

Then an example test that dynamically links to googletest is also built as a dynamic library with pthread support. Although it is built as dynamic library this module contains the `main` entry point.

Finally, an empty file is built as Emscripten's main module, which hosts the system libraries. This main module dynamically links to the example test library.

<span style="display: flex; flex-direction: row; justify-content: center;">
<svg xmlns="http://www.w3.org/2000/svg" width="663" height="190" style="font:700 12pt Helvetica,Helvetica,sans-serif" stroke-linecap="round" stroke-linejoin="round"><path fill="none" stroke="#33322e" stroke-width="3" d="M79.6 111l45.9 35.5h20"/><path fill="#33322e" stroke="#33322e" stroke-width="3" d="M132.2 151.8l6.6-5.3-6.6-5.3 13.3 5.3z"/><path fill="none" stroke="#33322e" stroke-width="3" d="M79.6 80l45.9-35.5h20"/><path fill="#33322e" stroke="#33322e" stroke-width="3" d="M132.2 49.8l6.6-5.3-6.6-5.3 13.3 5.3z"/><path fill="none" stroke="#33322e" stroke-width="3" d="M272.5 146.5h20l24-12.5h0"/><path fill="#33322e" stroke="#33322e" stroke-width="3" d="M307.2 144.9l3.4-7.8-8.4-1.7 14.3-1.4z"/><path fill="none" stroke="#33322e" stroke-width="3" d="M468.5 95.5h40"/><path fill="#33322e" stroke="#33322e" stroke-width="3" d="M495.2 100.8l6.6-5.3-6.6-5.3 13.3 5.3z"/><path fill="#eee8d5" stroke="#33322e" stroke-width="3" d="M145.5 13.5h127v62h-127z" data-name="main.js"/><path fill="none" stroke="#33322e" stroke-width="3" d="M145.5 44.5h127" data-name="main.js"/><text x="209" y="35" style="font:700 12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="main.js" text-anchor="middle">main.js</text><text x="153.5" y="66" style="font:12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="main.js">system libraries</text><path fill="#eee8d5" stroke="#33322e" stroke-width="3" d="M145.5 115.5h127v62h-127z" data-name="main.wasm"/><path fill="none" stroke="#33322e" stroke-width="3" d="M145.5 146.5h127" data-name="main.wasm"/><text x="209" y="137" style="font:700 12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="main.wasm" text-anchor="middle">main.wasm</text><text x="153.5" y="168" style="font:12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="main.wasm">system libraries</text><path fill="#eee8d5" stroke="#33322e" stroke-width="3" d="M312.5 57.5h156v77h-156z" data-name="string-compare.so"/><path fill="none" stroke="#33322e" stroke-width="3" d="M312.5 88.5h156" data-name="string-compare.so"/><text x="390.5" y="79" style="font:700 12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="string-compare.so" text-anchor="middle">string-compare.so</text><text x="353.051" y="110" style="line-height:normal" fill="#33322e" data-name="string-compare.so" font-family="Helvetica,Helvetica,sans-serif" font-size="16" font-weight="400">entry point</text><text x="373.805" y="125" style="line-height:normal" fill="#33322e" data-name="string-compare.so" font-family="Helvetica,Helvetica,sans-serif" font-size="16" font-weight="400">tests</text><path fill="#eee8d5" stroke="#33322e" stroke-width="3" d="M508.5 64.5h142v62h-142z" data-name="gtest.so"/><path fill="none" stroke="#33322e" stroke-width="3" d="M508.5 95.5h142" data-name="gtest.so"/><text x="579.5" y="86" style="font:700 12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="gtest.so" text-anchor="middle">gtest.so</text><text x="516.5" y="117" style="font:12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="gtest.so">testing framework</text><path fill="#eee8d5" stroke="#33322e" stroke-width="3" d="M13.5 80.5h92v31h-92z" data-name="main.html"/><text x="59.5" y="102" style="font:700 12pt Helvetica,Helvetica,sans-serif" fill="#33322e" data-name="main.html" text-anchor="middle">main.html</text><path fill="none" stroke="#33322e" stroke-width="3" d="M208.5 77.722v35.692"/><path fill="#33322e" stroke="#33322e" stroke-width="3" d="M203.2 100.2l5.3 6.6 5.3-6.6-5.3 13.3zM213.8 90.72l-5.3-6.6-5.3 6.6 5.3-13.3z"/></svg>
</span>

### Build

Get the source

```bash
$ git clone https://github.com/jprendes/emscripten-dylink-demo.git
```

Then run the following commands to build the demo and launch it in a local web server.

```bash
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
