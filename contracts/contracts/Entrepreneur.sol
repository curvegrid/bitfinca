pragma solidity >=0.4.22 <0.9.0;

contract Entrepreneur {
    struct Business {
        string name;
        address account;
    }

    Business[] public businesses;

    uint256 public constant largeNumber = 2**256-1;

    mapping(address => uint256) public balances;

    event Transfer(address from, address to, uint256 amount);

    constructor() public {
        businesses.push(Business({
            name: "ABC Farming",
            account: 0xBaC1Cd4051c378bF900087CCc445d7e7d02ad745
        }));
    }

    function addEntrepreneur(string memory _name, address _account) public {
        businesses.push(Business({
            name: _name,
            account: _account
        }));
        balances[_account] = 100;
    }

    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "insufficient funds");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);
    }
}
