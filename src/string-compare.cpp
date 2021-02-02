#include <gtest/gtest.h> // googletest header file

#include <string>
#include <thread>
using std::string;

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