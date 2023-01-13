// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;
import "../lib/console-remix.sol";

library tester
{

    function compareStrings(string memory val1, string memory val2) internal pure returns (bool) {
        if(keccak256(abi.encodePacked(val1)) == keccak256(abi.encodePacked(val2))){
            return true;
        }else{
            revert("Error stringEqual test!");
        }
    }
    function stringEqual(string memory val1, string memory val2) internal pure returns (bool) {
        if(keccak256(abi.encodePacked(val1)) == keccak256(abi.encodePacked(val2))){
            return true;
        }else{
            revert("Error stringEqual test!");
        }
    }
    function stringIsEmpty(string memory val1) internal pure{
        bytes memory str = bytes(val1);
        if(str.length != 0) revert("ERROR assert stringIsEmpty"); 
    }
    function stringIsNotEmpty(string memory val1) internal pure returns (bool) {
        if(keccak256(abi.encodePacked(val1)) != keccak256(abi.encodePacked(""))){
            return true;
        }else{
            revert("Error stringIsEmpty test!");
        }
    }
    function done() public view {
        console.log("Success test DONE!");
    }
}