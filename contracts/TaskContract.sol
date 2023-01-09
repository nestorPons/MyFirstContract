// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15 <0.9.0;

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
        return "Hola mundo";
    }
    function autoCreate() internal {
        create("T1", "Tarea 1");
    }

    function getLength() public view returns(uint256){
        return atasks.length;
    }
    function create(string memory name, string memory description) public {
        uint id = counter++;
        atasks.push(Task(id, name, description, 0, block.timestamp));
        tasks[id] = Task(id, name, description, 0, block.timestamp);
    }
    function getTask(uint256 id) public view returns(string memory name, string memory description){
        for (uint256 index = 0; index < atasks.length; index++) {
            if (id == index) return (atasks[index].name, atasks[index].description);
        }
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
