// SPDX-License-Identifier: MIT
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
        tsk.createTask("T1", "Tarea 1");
        tsk.createTask("T2", "Tarea 2");
        tsk.createTask("T3", "Tarea 3");
        tsk.createTask("T4", "Tarea 4");
        tsk.createTask("T5", "Tarea 5");
        tsk.createTask("T6", "Tarea 6");
    }

    function testCreateTask() public {
        uint len = tsk.getLength();
        Assert.equal(len, 7, "testCreateTask 1");
    }

    function testDeleteTask() public {
        tsk.deleteTask(1);
        uint st = tsk.getStatus(1);
        Assert.equal(st, 0, "testDeleteTask 1");
    }

    function testChangeDefaultTime() public {
        tsk.changeTimeExpire(1, 2);
        uint change = tsk.getExpire(1);
        Assert.isNotZero(change,"testChangeDefaultTime 1");
        tsk.changeTimeExpire(1, 30);
        uint change2 = tsk.getExpire(1);
        Assert.notEqual(change, change2, "testChangeDefaultTime 2");
        string memory len = uint2str(change);
        Assert.isBelow(bytes(len).length,12,string.concat("testChangeDefaultTime 3:", len));
    }

    function uint2str(uint _i) internal pure returns (string memory _uintAsString) {
        if (_i == 0) {
            return "0";
        }
        uint j = _i;
        uint len;
        while (j != 0) {
            len++;
            j /= 10;
        }
        bytes memory bstr = new bytes(len);
        uint k = len;
        while (_i != 0) {
        k  = k-1;
            uint8 temp = (48 + uint8(_i - _i / 10 * 10));
            bytes1 b1 = bytes1(temp);
            bstr[k] = b1;
            _i /= 10;
        }
        return string(bstr);
    }
}