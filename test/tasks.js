const TaskContracts= artifacts.require("TaskContract");

contract("testTsk", ()=>{
    before(async () => {
        this.tsk = await TaskContracts.deployed()

    })

    it('migrate deployed successfully', async ()=>{
        const address = this.tsk.address
        assert.equal(address.length, 42) 
    })
})