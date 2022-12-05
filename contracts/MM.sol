pragma solidity 0.8.17;

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        assert(c / a == b);
        return c;
    }
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a / b;
        return c;
    }
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        assert(b <= a);
        return a - b;
    }
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        assert(c >= a);
        return c;
    }
}

contract SimpleMM {
    using SafeMath for uint256;

    string     public name = "SimpleMM";
    uint8      public decimals = 18;
    
    uint16      public ask; /* 10000 10^5 tokens/wei gives ~$123 mil mkt cap using 1 ETH = $1000 */
    uint16      public bid; /* 9000 0.9*10^5 tokens/wei gives ~$12.3 mil diff */
    
    uint256     public tokens_sold = 0;
    uint256     public tokens_bought = 0;

    address     public token_address; /* Owner necessary? */
    ZUSE cont; 
    
    constructor(uint16 ask, uint16 bid, address token_address) {
        ask = ask;
        bid = bid;
        token_address = token_address;
        cont = ZUSE(token_address);
    }

    function sell_tokens(address payable to, uint256 sold_tokens) public returns (bool) {
        // sold_tokens = quantity.mul(bid);
        
        if (cont.balanceOf(msg.sender) < sold_tokens) {
            revert('Not enough tokens to sell!')
        }

        if (cont.allowance(msg.sender, this) < sold_tokens) {
            revert('Increase allowance of token contract')
        }

        eth_bought = sold_tokens.mul(bid);
        cont.transferFrom(msg.sender, this, quantity)


        /* invoke transfer(msg.sender, ) */
        /* allowance(owner, spender) -> gets allowance */
        /* approve(...)    */
        
        tokens_sold = tokens_sold + sold_tokens;
    }

    function buy_tokens() public payable override returns (bool) {
        purchased_tokens = msg.value.mul(ask)
        
        if (cont.balanceOf(this) < purchased_tokens) {
            revert("Not enough tokens in MM contract!");
        }

        tokens_bought = tokens_bought + purchased_tokens;
        cont.transferFrom(this, msg.sender, purchased_tokens)
    }

    function balance() public returns (uint256) {
        return address(this).balance;
    }

    function token_balance() public returns (uint256) {
        return cont.balanceOf(this);
    }
}