pragma solidity >=0.4.22 <0.9.0;

contract Entrepreneur {
    struct Business {
        string name;
        address account;
    }

    Business[] public businesses;

    mapping(address => uint256) balances;

    function addEntrepreneur(string memory _name, address _account) public {
        businesses.push(Business({
            name: _name,
            account: _account
        }));
        balances[_account] = 0;
    }

}
