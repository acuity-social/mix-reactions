pragma solidity ^0.5.0;

import "ds-test/test.sol";

import "./MixReactions.sol";

contract MixReactionsTest is DSTest {
    MixReactions reactions;

    function setUp() public {
        reactions = new MixReactions();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
