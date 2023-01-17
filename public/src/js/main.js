const app = {
    provider: null,
    init: async function() {
        console.log('App constructor... ')
        this.functions()
        await this.connectEthereum()
        await this.loadContracts()
    },
    functions: function() {
        $('#frmTask').on('submit', e => {
            e.preventDefault()
            this.addTask();
        })
    },
    addTask: function() {
        console.log('Add task...')
        let name = $('#name').val()
        let description = $('#description').val()
        let card = $('#template_card').clone()
        card.attr('id', '')
        card.find('.name').text(name)
        card.find('.description').text(description)
        $('#container_cards').append(card)

    },
    connectEthereum: async function() {
        if (window.ethereum) {
            console.log('Window ethereum exist!')
            this.provider = window.ethereum
            await this.provider.request({
                method: 'eth_requestAccounts'
            })
        } else {
            console.log('Please install MetaMask!')
        }
    },
    loadContracts: async function() {
        const res = await fetch("TaskContract.json")
        const json = await res.json()
        console.log(json)
    }
}

console.log('Iniciaized...')
$(() => app.init())