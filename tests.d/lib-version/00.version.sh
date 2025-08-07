#!/usr/bin/env bash

# shellcheck source=../../libraries.d/lib-version
source version

function main() {
  test_version::compare
  test_version::bump
}

function test_version::compare() {
  test::title "✅ Testing version::compare function"

  test::func version::compare "1.2.3" "1.2.3"
  test::func version::compare "1.2.3-alpha" "1.2.4+az123"
  test::func version::compare "1.2.3" "1.2.2"
  test::func version::compare "2.2.3" "1.2.3-alpha"
  test::func version::compare "1.2.3+a1212" "1.3.3"
  test::func version::compare "1.2.3-alpha+a123123" "1.2.3-alpha+123zer"
  test::exit version::compare "1.2a.3" "1.2.3derp"
}

function test_version::bump() {
  test::title "✅ Testing version::bump"

  test::func version::bump "0.0.0" "minor"
  test::func version::bump "1.2.3-alpha+zae345" "major"
  test::func version::bump "1.2.3-alpha+zae345" "minor"
  test::func version::bump "1.2.3-alpha+zae345" "patch"
  test::func version::bump "1.2.3-alpha+zae345" "major" keepPreRelease=true
  test::func version::bump "1.2.156-alpha" "patch" keepPreRelease=true
  test::exit version::bump "aze" "patch" keepPreRelease=true
}

main