ExpectThat
=======

**ExpectThat** is a CoffeeScript library that helps you write expressive, self-documenting unit tests.
ExpectThat currently supports Pavlov, QUnit, and Jasmine.

The goals of ExpectThat are:

* to make the code of CoffeeScript unit tests speak for itself (no need to write the same thing in a comment or test name).
* to provide human readable unit test assertions.
* to leverage existing test frameworks, while at the same time adapting them to CoffeScript in new ways.

**Syntax**

With ExpectThat, you can write unit tests like this:

One object equals or does not equal another:

    expectThat -> 1.should equal 1

    expectThat -> 1.shouldnt equal 2

An object is true or false

    expectThat -> ("b"+"ar" is "bar").should be true

    expectThat -> ("foo" is "baz").shouldnt be true

    expectThat -> ("b"+"az" is "bar").should be false

    expectThat -> ("b" + "az" is "baz").shouldnt be false

    expectThat -> (null is null).should be true

    expectThat -> ("" is null).should be false

    expectThat -> (undefined is undefined).should be true

    expectThat -> ("" is undefined).should be false

A number is or is not greater than or less than another

    expectThat -> 10.1.should be greaterThan 10

    expectThat -> 9.shouldnt be greaterThan 10

    expectThat -> 10.1.should be lessThan 10.2

    expectThat -> 10.1.shouldnt be lessThan 10

A number is or is not greater than or equal to or less than or equal to another

    expectThat -> 10.should be greaterThanOrEqual to 10

    expectThat -> 9.9.shouldnt be greaterThanOrEqual to 10

    expectThat -> (10.0).should be lessThanOrEqual to 10

    expectThat -> 10.1.shouldnt be lessThanOrEqual to 10

An object is strictly equal (i.e. is or ===) to another

    testFn = ->
    testFn2 = ->

    expectThat -> testFn.should be strictlyEqual to testFn

    expectThat -> testFn.shouldnt be strictlyEqual to testFn2

A function throws an exception

    expectThat -> (-> throw "test exception").should throwException

A function throws an exception with a specific exception message (Note: The exception message must match exactly.)

    expectThat -> (-> throw "test exception").should throwException "test exception"

Most assertions can be created using the `be` and/or `to` keywords:

    expectThat -> 1.shouldnt be equal to 2

    expectThat -> ("b"+"ar" is "bar").should be true

    expectThat -> ("b" + "az" is "baz").shouldnt be false

**Examples**

The following are examples of ExpectThat in use with Pavlov.js ( https://github.com/mmonteleone/pavlov ) and QUnit respectively.
Note: More extensive examples can be found in the example folder ( https://github.com/dmohl/expectThat/tree/master/example ).

Pavlov:

    pavlov.specify "expectThat Specifications", ->
        describe "When testing should equal", ->
            foo = undefined
            before ->
                foo = "bar"
            after ->
                foo = "baz"
            expectThat -> foo.should equal "bar"
            expectThat -> foo.shouldnt equal "baz"
            expectThat -> (foo + "test").shouldnt equal "bartest2"
            expectThat -> foo.should be equal to "bar"
            expectThat -> foo.shouldnt be equal to "bah"

QUnit:

    module "When testing should equal"

    foo = "bar"

    expectThat -> foo.should equal "bar"
    expectThat -> foo.shouldnt equal "baz"
    expectThat -> (foo + "test").shouldnt equal "bartest2"
    expectThat -> foo.should be equal to "bar"
    expectThat -> foo.shouldnt be equal to "bah"

Jasmine:

    describe "Example Jasmine Specifications", ->
        foo = "bar"
        describe "When testing should equal", ->
            expectThat -> foo.should equal "bar"
        describe "When testing shouldnt equal", ->
            expectThat -> foo.shouldnt equal "baz"
        describe "When testing for true", ->
            expectThat -> (foo is "bar").should be true
            expectThat -> (foo is "baz").shouldnt be true
        describe "When testing for false", ->
            expectThat -> (foo is "baz").should be false
            expectThat -> (foo is "bar").shouldnt be false

ExpectThat also supports custom matchers. Any matcher that evaluates to true/false can be created. Here's an example of
a custom matcher for Pavlov (Note: An example for QUnit is available in the examples folder https://github.com/dmohl/expectThat/tree/master/example ):

    ((expectThat) ->
        myCustomMatchers =
            atleastTwoGreaterThan: (expected) ->
                "assertionType": "atleastTwoGreaterThan"
                "expected": expected
                "expr": (actual, expected) -> actual >= expected + 2

        expectThat.util.extend pavlov.api, myCustomMatchers
    ) expectThat

**Using ExpectThat with JavaScript**

While the syntax of ExpectThat is especially well suited and specifically designed for CoffeeScript, it can also be used
in JavaScript. Here's a Pavlov example:

    pavlov.specify("expectThat Specifications", function() {
        describe("When testing should equal", function() {
            var foo = "bar";
            expectThat(function() {
                foo.should(equal("bar"));
            });
            expectThat(function() {
                (foo + "test").should(equal("bartest"));
            });
        });
    });

**Known Issues and/or Comments**

* QUnit places all of its associated functions in the global scope. To allow seamless integration, ExpectThat for QUnit
follows this approach as well. Because of this, the QUnit "equal" function is overwritten with the ExpectThis "equal" function.
If for whatever reason you require access to the QUnit "equal" function, it can be access via qunitEqual. ExpectThat for
QUnit also adds "expectThat", "be", "to", "throwException", "greaterThan", "greaterThanOrEqual", "lessThan",
"lessThanOrEqual", "strictlyEqual", "qunitNotEqual", "qunitRaises", "qunitOk", and any custom matchers that you implement
to the global scope, though these do not currently cause direct conflicts with QUnit.

* While the Pavlov implementation does not pollute the global scope the way that the QUnit implementation does, it requires
a change to the currently released version of Pavlov to make this possible (the change has been submitted in a pull request).
For now, the modified version of the Pavlov library can be found in the ext folder of this project.

* The Jasmine implementation also pollutes the global scope by adding everything mentioned above for QUnit (expect the
qunit specific functions). It is expected that a future version of ExpectThat will eliminate this pollution.

**Roadmap**

* Add support for Node
* Add direct support for Mocha