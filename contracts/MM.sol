pragma solidity 0.8.17;

interface ERC20Interface{
    function totalSupply() external view returns (uint256);
    function balanceOf(address who) external view returns (uint256);
    function transfer(address to, uint256 value) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function approve(address spender, uint256 value) external returns (bool);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed burner, uint256 value);
}

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
    
    uint16      public ask = 10000; /* 10000 10^5 tokens/wei gives ~$123 mil mkt cap using 1 ETH = $1000 */
    uint16      public bid = 9000; /* 9000 0.9*10^5 tokens/wei gives ~$12.3 mil diff */
    
    uint256     public tokens_sold = 0;
    uint256     public tokens_bought = 0;

    address public token_address;
    address public owner_address;

    ERC20Interface public cont;
    
    constructor(address _token_address) {
        token_address = _token_address;
        owner_address = msg.sender;
        cont = ERC20Interface(token_address);
    }

    function sell_tokens(address payable to, uint256 sold_tokens) public returns (bool) {
        tokens_sold = tokens_sold + sold_tokens;
        
        if (cont.balanceOf(msg.sender) < sold_tokens) {
            revert('Not enough tokens to sell!');
        }

        if (cont.allowance(msg.sender, address(this)) < sold_tokens) {
            revert('Increase allowance of token contract');
        }

        uint256 eth_bought = sold_tokens.mul(bid);
        cont.transferFrom(msg.sender, address(this), sold_tokens);
        
        (bool sent, bytes memory data) = to.call{value: eth_bought}("");
        require(sent, "Failed to send Ether!");
        
        return true;
    }

    function buy_tokens() public payable returns(bool) {
        uint256 purchased_tokens = msg.value.mul(ask);
        tokens_bought = tokens_bought + purchased_tokens;
        
        if (cont.balanceOf(address(this)) < purchased_tokens) {
            revert("Not enough tokens in MM contract!");
        }

        cont.transferFrom(address(this), msg.sender, purchased_tokens);
        return true;
    }

    function balance() public view returns (uint256) {
        return address(this).balance;
    }

    function token_balance() public view returns (uint256) {
        return cont.balanceOf(address(this));
    }

    receive() payable external {
        revert();
    }

    fallback() payable external {
        revert();
    }

}