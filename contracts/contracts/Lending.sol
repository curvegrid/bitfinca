pragma solidity >=0.4.22 <0.9.0;

contract Lending {
    struct Lender {
        string name;
        address account;
    }

    Lender[] public lenders;

    event Transfer(address from, address to, uint256 amount);

    function addLender(string memory _name, address _account) public {
        lenders.push(Lender({
            name: _name,
            account: _account
        }));
        Account.balances[_account] = 100;
    }
}
