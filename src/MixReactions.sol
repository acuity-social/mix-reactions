pragma solidity ^0.5.0;


contract MixReactions {

    /**
     * @dev Mapping of account to mapping of itemId to mapping of reaction block to packed reactions.
     */
    mapping (address => mapping(bytes32 => mapping(uint => bytes32))) accountItemBlockReactions;

}
