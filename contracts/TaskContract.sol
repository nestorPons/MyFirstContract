// SPDX-License-Identifier: MIT
pragma solidity >=0.8.5 <0.9.0;

contract TaskContract {
    uint256 counter;

    struct Task {
        uint256 id;
        string name;
        string description;
        uint8 status; // 0 ini 1 done 2 delete
        uint256 createAt;
    }

    mapping(uint256 => Task) public tasks;
    Task[] atasks; 

    constructor(){
        autoCreate();
    }
    function hello() public pure returns(string memory){
        return "Hola mundo 2";
    }
    function autoCreate() internal {
        create("T1", "Tarea 1");
        create("T2", "Tarea 2");
        create("T3", "Tarea 3");
        create("T4", "Tarea 4");
        create("T5", "Tarea 5");
        create("T6", "Tarea 6");
    }

    function getLength() public view returns(uint256){
        return atasks.length;
    }
    function create(string memory name, string memory description) public {
        uint id = atasks.length;
        atasks.push(Task(id, name, description, 0, block.timestamp));
    }
    function getTask(uint256 id) public view returns(string memory name, string memory description){
        return (tasks[id].name, tasks[id].description) ; 
    }
    function getaTask(uint _id) public view returns(uint id, string memory name, string memory description){
        uint len = atasks.length;
        uint ir = 0;  
        for (uint i = 0; i < len ; i++) {
            if (atasks[i].id == _id) return (atasks[i].id, atasks[i].name, atasks[i].description); 
            ir = len-i-1;  
            if (ir <= i ) break;
            if (atasks[ir].id == _id) (atasks[i].id, atasks[ir].name, atasks[ir].description); 
        }

        return (0, "","");
    }
    function getName(uint256 id)
        public
        view
        returns (
            string memory
        )
    {
        Task memory tsk = tasks[id];
        return tsk.name;
    }

}
