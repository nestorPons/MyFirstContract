// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

contract TaskContract {
    uint256 counter;

    enum States{ DELETE, INITIAL, DONE, ERROR } States status;

    struct Task {
        uint256 id;
        string name;
        string description;
        States status; // 0 delete 1 Initial 2 Done
        uint256 createAt;
    }

    mapping(uint256 => Task) public tasks;
    Task[] atasks; 

    constructor(){
        autoCreate();
    }
   
    function autoCreate() internal {
        createTask("", "");
        createTask("T1", "Tarea 1");
        createTask("T2", "Tarea 2");
        createTask("T3", "Tarea 3");
        createTask("T4", "Tarea 4");
        createTask("T5", "Tarea 5");
        createTask("T6", "Tarea 6");
    }

    function getLength() public view returns(uint256){
        return atasks.length;
    }
    function createTask(string memory name, string memory description) public {
        uint id = atasks.length;
        atasks.push(Task(id, name, description, States.INITIAL, block.timestamp));
    }
    function updateName(uint id, string memory value) public{
        uint i = getIndex(id);
        atasks[i].name = value;
    }
    function updateDescription(uint id, string memory value) public{
        uint i = getIndex(id);
        atasks[i].description = value;
    }
    function deleteTask(uint id) public {
        updateStatus(id, 0);
    }
    function resetTask(uint id) public {
        updateStatus(id, 1);
    }
    function doneTask(uint id) public{
        updateStatus(id, 2);
    }
    function updateStatus(uint id, uint8 idStatus ) internal {
        uint i = getIndex(id);
        atasks[i].status = 
            idStatus == 0 ? States.DELETE : 
            idStatus == 1 ? States.INITIAL :
            idStatus == 2 ? States.DONE :
            States.ERROR ;
        if(atasks[i].status == States.ERROR){
            revert("ERROR: Index out bound!");
        }
    }
    function getTask( uint id) public view returns(Task memory){
        uint len = atasks.length;
        uint ir = 0;  
        for (uint i = 0; i < len ; i++) {
            if (atasks[i].id == id) return atasks[i]; 
            ir = len-i-1;  
            if (ir <= i ) break;
            if (atasks[ir].id == id) return atasks[i]; 
        }

        return atasks[0];
    }
    function getIndex(uint id) internal view returns(uint){
        uint len = atasks.length;
        uint ir = 0;  
        for (uint i = 0; i < len ; i++) {
            if (atasks[i].id == id) return i; 
            ir = len-i-1;  
            if (ir <= i ) break;
            if (atasks[ir].id == id) return ir; 
        }

        return 0;
    }
}