// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "truffle/Console.sol";

import "../lib/solidity-tester.sol";
import "../contracts/TaskContract.sol";

contract TestTask {
    TaskContract tsk;

    function beforeAll() public{
        tsk = new TaskContract();
    }
    
    function testNameIsString() public {
        Assert.isEmpty("", "Test string not is empty!");
    }
}