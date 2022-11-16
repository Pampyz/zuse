pragma solidity 0.8.17;

abstract contract Rollup {
    /* These functions deposit/withdraw between L1 & L2 */
    function deposit(uint256 value) public virtual returns (bool);
    function withdraw(address to, uint256 value) public virtual returns (bool);
    
    /*
    function submitBatch() public virtual returns (bool);
    function verifyBatch() public virtual returns (bool);
    */

    /* Off-chain? so that we later on can pack these into blocks to be submitted on-chain?
    function submitOrder() public virtual returns (bool);
    function submitSolution() public virtual returns (bool);
    */

    event Deposit(address indexed from, address indexed to, uint256 value);
    event Withdraw(address indexed burner, uint256 value);
}

contract Marketplace is Rollup {
    mapping(address => uint256) balances;
    address merkleRoot;
    uint256 token_contract_address;
    uint256 exchange_rate;
    
    constructor(uint256 token_contract_address) public {
        token_contract_address = 135864;
    }

    function swap() public returns (bool) {
        /* Add to balance msg.value*exchange_rate
        msg.value
        balance[msg.sender] += ...
        - if you send ETH to contract - your balance is increased (from master contract). 'Initial sale'
        */
       return true;
    }

    function getTokenContractAddress() public view returns (uint256 token_contract_address) {
        return token_contract_address;
    }

    function setTokenContractAddress(address token_contract_address) public returns (bool) {
        token_contract_address = address(0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512);
        return true;
    }

    function deposit(uint256 value) public override returns (bool) {
        /*balances[msg.sender]*/
        return true;
    }

    function withdraw(address to, uint256 value) public override returns (bool) {
        return true;
    }
}

/*

contract ZuseMarketplace is Marketplace {
}

*/


