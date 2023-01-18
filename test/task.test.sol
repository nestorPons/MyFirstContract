//SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/TaskContract.sol";

contract TestTask {
    TaskContract tsk;           
    constructor(){
        tsk = new TaskContract();
    }

    function beforeAll() public {
        //id, name, description, expire
        tsk.createTask(1, "T1", "Task 1", block.timestamp + 7 days);
        tsk.createTask(2, "T2", "Task 2", block.timestamp + 7 days);
        tsk.createTask(3, "T3", "Task 3", block.timestamp + 7 days);
    }

    function testCreateTask() public {
        uint len = tsk.getLength();
        Assert.equal(len, 4, "testCreateTask 1");
    }

    function testDeleteTask() public {
        tsk.deleteTask(1);
        uint st = tsk.getStatus(1);
        Assert.equal(st, 0, "testDeleteTask 1");
    }

    function uint2str(uint i) internal pure returns (string memory _uintAsString) {
        if (i == 0) {
            return "0";
        }
        uint j = i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (i != 0) {
        k  = k-1;
            uint8 temp = (48 + uint8(i - i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            i /= 10;
        }
        return string(bstr);
    }

    function testChangeExpire() public {
        uint lastTimeStamp = tsk.getExpire(1);
        tsk.updateExpire(1, 1674067714);
        uint timestamp = tsk.getExpire(1);
        Assert.equal(1674067714, timestamp, "testChangeExpire 1");
        Assert.notEqual(lastTimeStamp, timestamp, "testChangeExpire 2");
    }
}