// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract TaskContract {
    
    enum States{ DELETE, INITIAL, DONE, ERROR } States status;
    
    struct Task {
        uint256 id;
        string name;
        string description;
        States status; // 0 delete 1 Initial 2 Done
        uint256 create;
        uint256 expire;
    }

    struct Self {
        uint256 counter;
        Task[] tasks; 
    }
    
    Self self;
    
    constructor(){
        createTask(0,"","",0); // trash register
    }

    function getLength() public view returns(uint256){
        return self.tasks.length;
    }

    function createTask(uint id, string memory name, string memory description, uint expire) public {
        self.tasks.push(Task(id, name, description, States.INITIAL, block.timestamp , expire));
    }

    function updateName(uint id, string memory value) public{
        uint i = getIndex(id);
        self.tasks[i].name = value;
    }

    function updateDescription(uint id, string memory value) public{
        uint i = getIndex(id);
        self.tasks[i].description = value;
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

    function updateExpire(uint id, uint timestamp) public {
        uint i = getIndex(id);
        self.tasks[i].expire = timestamp;
    }

    function updateStatus(uint id, uint8 idStatus ) internal {
        uint i = getIndex(id);
        self.tasks[i].status = 
            idStatus == 0 ? States.DELETE : 
            idStatus == 1 ? States.INITIAL :
            idStatus == 2 ? States.DONE :
            States.ERROR ;
        if(self.tasks[i].status == States.ERROR){
            revert("ERROR: Index out bound!");
        }
    }

    function getTask( uint id) public view returns(Task memory){
        uint len = self.tasks.length;
        uint ir = 0;  
        for (uint i = 0; i < len ; i++) {
            if (self.tasks[i].id == id) return self.tasks[i]; 
            ir = len-i-1;  
            if (ir <= i ) break;
            if (self.tasks[ir].id == id) return self.tasks[i]; 
        }

        return self.tasks[0];
    }

    function getIndex(uint id) internal view returns(uint){
        uint len = self.tasks.length;
        uint ir = 0;  
        for (uint i = 0; i < len ; i++) {
            if (self.tasks[i].id == id) return i; 
            ir = len-i-1;  
            if (ir <= i ) break;
            if (self.tasks[ir].id == id) return ir; 
        }
        return 0;
    }

    function getStatus(uint id) public view returns(uint8) {
        uint i = getIndex(id);
        uint8 respond =
            self.tasks[i].status == States.DELETE ? 0 : 
            self.tasks[i].status == States.INITIAL ? 1:
            2 ;
        return respond;
    }
    function getExpire(uint id) public view returns(uint){
        uint i = getIndex(id);
        return self.tasks[i].expire;
    }
}