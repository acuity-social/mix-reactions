pragma solidity ^0.5.9;

import "ds-test/test.sol";
import "mix-trusted-accounts/TrustedAccounts.sol";

import "./MixReactions.sol";
import "./MixReactionsProxy.sol";


contract MixReactionsTest is DSTest {

    TrustedAccounts trustedAccounts;
    MixReactions mixReactions;

    function setUp() public {
        trustedAccounts = new TrustedAccounts();
        mixReactions = new MixReactions(trustedAccounts);
    }

    function testControlReactTooMuch() public {
        mixReactions.addReaction(hex"01", hex"01");
        mixReactions.addReaction(hex"01", hex"02");
        mixReactions.addReaction(hex"01", hex"03");
        mixReactions.addReaction(hex"01", hex"04");
        mixReactions.addReaction(hex"01", hex"05");
        mixReactions.addReaction(hex"01", hex"06");
        mixReactions.addReaction(hex"01", hex"07");
        mixReactions.addReaction(hex"01", hex"08");
        mixReactions.addReaction(hex"01", hex"08");
    }

    function testFailReactTooMuch() public {
        mixReactions.addReaction(hex"01", hex"01");
        mixReactions.addReaction(hex"01", hex"02");
        mixReactions.addReaction(hex"01", hex"03");
        mixReactions.addReaction(hex"01", hex"04");
        mixReactions.addReaction(hex"01", hex"05");
        mixReactions.addReaction(hex"01", hex"06");
        mixReactions.addReaction(hex"01", hex"07");
        mixReactions.addReaction(hex"01", hex"08");
        mixReactions.addReaction(hex"01", hex"09");
    }

    function testGetReactions() public {
        mixReactions.addReaction(hex"01", hex"01");
        mixReactions.addReaction(hex"01", hex"01");
        mixReactions.addReaction(hex"01", hex"01");
        bytes32 reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0100000000000000000000000000000000000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"02");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0100000002000000000000000000000000000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"03");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0100000002000000030000000000000000000000000000000000000000000000");

        mixReactions.removeReaction(hex"01", hex"01");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0000000002000000030000000000000000000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"04");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000000000000000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"05");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000000000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"06");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000006000000000000000000000000000000");

        mixReactions.addReaction(hex"01", hex"07");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000006000000070000000000000000000000");

        mixReactions.addReaction(hex"01", hex"08");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000006000000070000000800000000000000");

        mixReactions.addReaction(hex"01", hex"09");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000006000000070000000800000009000000");

        mixReactions.removeReaction(hex"01", hex"06");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000000000000070000000800000009000000");

        mixReactions.removeReaction(hex"01", hex"07");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0400000002000000030000000500000000000000000000000800000009000000");

        mixReactions.addReaction(hex"01", hex"0a");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"040000000200000003000000050000000a000000000000000800000009000000");

        mixReactions.addReaction(hex"01", hex"0b");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"040000000200000003000000050000000a0000000b0000000800000009000000");

        mixReactions.addReaction(hex"01", hex"0a");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"040000000200000003000000050000000a0000000b0000000800000009000000");

        mixReactions.addReaction(hex"01", hex"0b");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"040000000200000003000000050000000a0000000b0000000800000009000000");

        mixReactions.removeReaction(hex"01", hex"04");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000200000003000000050000000a0000000b0000000800000009000000");

        mixReactions.removeReaction(hex"01", hex"09");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000200000003000000050000000a0000000b0000000800000000000000");

        mixReactions.removeReaction(hex"01", hex"02");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000000000003000000050000000a0000000b0000000800000000000000");

        mixReactions.removeReaction(hex"01", hex"08");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000000000003000000050000000a0000000b0000000000000000000000");

        mixReactions.removeReaction(hex"01", hex"03");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000000000000000000050000000a0000000b0000000000000000000000");

        mixReactions.removeReaction(hex"01", hex"0b");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000000000000000000050000000a000000000000000000000000000000");

        mixReactions.removeReaction(hex"01", hex"05");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"000000000000000000000000000000000a000000000000000000000000000000");

        mixReactions.removeReaction(hex"01", hex"0a");
        reactions = mixReactions.getReactions(hex"01");
        assertEq(reactions, hex"0000000000000000000000000000000000000000000000000000000000000000");
    }

    function testGetTrustedReactions() public {
        MixReactionsProxy account0 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account1 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account2 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account3 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account4 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account5 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account6 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account7 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account8 = new MixReactionsProxy(mixReactions);
        MixReactionsProxy account9 = new MixReactionsProxy(mixReactions);

        address[] memory itemReactionAccounts;
        bytes32[] memory itemReactions;

        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 0);
        assertEq(itemReactions.length, 0);

        trustedAccounts.trustAccount(address(account0));
        trustedAccounts.trustAccount(address(account1));
        trustedAccounts.trustAccount(address(account2));
        trustedAccounts.trustAccount(address(account3));
        trustedAccounts.trustAccount(address(account4));
        trustedAccounts.trustAccount(address(account5));
        trustedAccounts.trustAccount(address(account6));
        trustedAccounts.trustAccount(address(account7));
        trustedAccounts.trustAccount(address(account8));
        trustedAccounts.trustAccount(address(account9));

        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 0);
        assertEq(itemReactions.length, 0);

        account0.addReaction(hex"01", hex"01");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 1);
        assertEq(itemReactions.length, 1);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");

        account6.addReaction(hex"01", hex"02");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 2);
        assertEq(itemReactions.length, 2);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account6));
        assertEq(itemReactions[1], hex"02");

        account9.addReaction(hex"01", hex"03");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 3);
        assertEq(itemReactions.length, 3);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account6));
        assertEq(itemReactions[1], hex"02");
        assertEq(itemReactionAccounts[2], address(account9));
        assertEq(itemReactions[2], hex"03");

        account8.addReaction(hex"01", hex"04");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 4);
        assertEq(itemReactions.length, 4);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account6));
        assertEq(itemReactions[1], hex"02");
        assertEq(itemReactionAccounts[2], address(account8));
        assertEq(itemReactions[2], hex"04");
        assertEq(itemReactionAccounts[3], address(account9));
        assertEq(itemReactions[3], hex"03");

        account8.addReaction(hex"01", hex"05");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 4);
        assertEq(itemReactions.length, 4);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account6));
        assertEq(itemReactions[1], hex"02");
        assertEq(itemReactionAccounts[2], address(account8));
        assertEq(itemReactions[2], hex"0400000005");
        assertEq(itemReactionAccounts[3], address(account9));
        assertEq(itemReactions[3], hex"03");

        account7.addReaction(hex"01", hex"06");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 5);
        assertEq(itemReactions.length, 5);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account6));
        assertEq(itemReactions[1], hex"02");
        assertEq(itemReactionAccounts[2], address(account7));
        assertEq(itemReactions[2], hex"06");
        assertEq(itemReactionAccounts[3], address(account8));
        assertEq(itemReactions[3], hex"0400000005");
        assertEq(itemReactionAccounts[4], address(account9));
        assertEq(itemReactions[4], hex"03");

        account5.addReaction(hex"01", hex"07");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 6);
        assertEq(itemReactions.length, 6);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account5));
        assertEq(itemReactions[1], hex"07");
        assertEq(itemReactionAccounts[2], address(account6));
        assertEq(itemReactions[2], hex"02");
        assertEq(itemReactionAccounts[3], address(account7));
        assertEq(itemReactions[3], hex"06");
        assertEq(itemReactionAccounts[4], address(account8));
        assertEq(itemReactions[4], hex"0400000005");
        assertEq(itemReactionAccounts[5], address(account9));
        assertEq(itemReactions[5], hex"03");

        account1.addReaction(hex"01", hex"08");
        account2.addReaction(hex"01", hex"09");
        account3.addReaction(hex"01", hex"0a");
        account4.addReaction(hex"01", hex"0b");
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 10);
        assertEq(itemReactions.length, 10);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account1));
        assertEq(itemReactions[1], hex"08");
        assertEq(itemReactionAccounts[2], address(account2));
        assertEq(itemReactions[2], hex"09");
        assertEq(itemReactionAccounts[3], address(account3));
        assertEq(itemReactions[3], hex"0a");
        assertEq(itemReactionAccounts[4], address(account4));
        assertEq(itemReactions[4], hex"0b");
        assertEq(itemReactionAccounts[5], address(account5));
        assertEq(itemReactions[5], hex"07");
        assertEq(itemReactionAccounts[6], address(account6));
        assertEq(itemReactions[6], hex"02");
        assertEq(itemReactionAccounts[7], address(account7));
        assertEq(itemReactions[7], hex"06");
        assertEq(itemReactionAccounts[8], address(account8));
        assertEq(itemReactions[8], hex"0400000005");
        assertEq(itemReactionAccounts[9], address(account9));
        assertEq(itemReactions[9], hex"03");

        trustedAccounts.untrustAccount(address(account3));
        trustedAccounts.untrustAccount(address(account5));
        trustedAccounts.untrustAccount(address(account9));
        (itemReactionAccounts, itemReactions) = mixReactions.getTrustedReactions(hex"01");
        assertEq(itemReactionAccounts.length, 7);
        assertEq(itemReactions.length, 7);
        assertEq(itemReactionAccounts[0], address(account0));
        assertEq(itemReactions[0], hex"01");
        assertEq(itemReactionAccounts[1], address(account1));
        assertEq(itemReactions[1], hex"08");
        assertEq(itemReactionAccounts[2], address(account2));
        assertEq(itemReactions[2], hex"09");
        assertEq(itemReactionAccounts[3], address(account7));
        assertEq(itemReactions[3], hex"06");
        assertEq(itemReactionAccounts[4], address(account4));
        assertEq(itemReactions[4], hex"0b");
        assertEq(itemReactionAccounts[5], address(account8));
        assertEq(itemReactions[5], hex"0400000005");
        assertEq(itemReactionAccounts[6], address(account6));
        assertEq(itemReactions[6], hex"02");
    }

}
