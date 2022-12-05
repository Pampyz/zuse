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

abstract contract IERC20 {
    function totalSupply() public virtual view returns (uint256);
    function balanceOf(address who) public virtual view returns (uint256);
    function transfer(address to, uint256 value) public virtual returns (bool);
    function allowance(address owner, address spender) public virtual view returns (uint256);
    function transferFrom(address from, address to, uint256 value) public virtual returns (bool);
    function approve(address spender, uint256 value) public virtual returns (bool);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Burn(address indexed burner, uint256 value);
}

contract ERC20 is IERC20 {
    using SafeMath for uint256;
    mapping(address => uint256) balances;
    mapping (address => mapping (address => uint256)) internal allowed;

    uint256 totalSupply_;
    uint256 burnedTotalNum_;
    uint private constant MAX_UINT = 2**256 - 1;


    function totalSupply() public override view returns (uint256) {
        return totalSupply_;
    }
    function balanceOf(address _owner) public override view returns (uint256) {
        return balances[_owner];
    }
    function transfer(address _to, uint256 _value) public override returns (bool) {
        if (_to == address(0)) {
            return burn(_value);
        }

        require(_value <= balances[msg.sender]);
        balances[msg.sender] = balances[msg.sender].sub(_value);
        balances[_to] = balances[_to].add(_value);
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function burn(uint256 _value) public returns (bool) {
        require(_value <= balances[msg.sender]);

        address burner = msg.sender;
        balances[burner] = balances[burner].sub(_value);
        totalSupply_ = totalSupply_.sub(_value);
        burnedTotalNum_ = burnedTotalNum_.add(_value);

        emit Burn(burner, _value);
        return true;
    }
    function totalBurned() public view returns (uint256) {
        return burnedTotalNum_;
    }

    function burnFrom(address _owner, uint256 _value) public returns (bool) {
        require(_owner != address(0));
        require(_value <= balances[_owner]);
        require(_value <= allowed[_owner][msg.sender]);

        balances[_owner] = balances[_owner].sub(_value);
        if (allowed[_owner][msg.sender] < MAX_UINT) {
            allowed[_owner][msg.sender] = allowed[_owner][msg.sender].sub(_value);
        }
        totalSupply_ = totalSupply_.sub(_value);
        burnedTotalNum_ = burnedTotalNum_.add(_value);

        emit Burn(_owner, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool) {
        if (_to == address(0)) {
            return burnFrom(_from, _value);
        }

        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);

        if (allowed[_from][msg.sender] < MAX_UINT) {
            allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        }
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public override returns (bool) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public override view returns (uint256) {
        return allowed[_owner][_spender];
    }

    function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
        allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }

    function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
        uint oldValue = allowed[msg.sender][_spender];
        if (_subtractedValue > oldValue) {
            allowed[msg.sender][_spender] = 0;
        } else {
            allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
        }
        emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
        return true;
    }
}


contract CalculatingToken is ERC20 {}
contract StorageToken is ERC20{}
contract L2Token is ERC20{}

contract ZUSE is ERC20 {
    using SafeMath for uint256;

    string     public name = "Zuse";
    string     public symbol = "ZUSE";
    uint8      public decimals = 18;
    uint16      public ask = 10000; /* 10^5 tokens/wei gives ~$123 mil mkt cap using 1 ETH = $1000 */
    uint16      public bid = 9000; /* 0.9*10^5 tokens/wei gives ~$12.3 mil diff */
    address     public owner;

    constructor() {
        totalSupply_ = 1230123012301230123012301230;
        balances[msg.sender] = totalSupply_;
        owner = msg.sender;
    }


    function batchTransfer(address[] calldata accounts, uint256[] calldata amounts)
        external
        returns (bool)
    {
        require(accounts.length == amounts.length);
        for (uint i = 0; i < accounts.length; i++) {
            require(transfer(accounts[i], amounts[i]), "transfer failed");
        }
        return true;
    }
    // NP solvers
    function askSolve() public view returns (bool) {
        return true;
    }

    // Storage functions
    function provideStorage() public view returns (bool) {
        return true;
    }

    function askStorage() public view returns (bool) {
        return true;
    }

    // Debug functions to be removed
    function getSender() public view returns (address) {
        return msg.sender;
    }

    receive() payable external {
        revert();
    }

    fallback() payable external {
        revert();
    }
}