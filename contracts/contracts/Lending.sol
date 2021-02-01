pragma solidity >=0.4.22 <0.9.0;
import "./Account.sol";

contract Lending {
    struct Lender {
        string name;
        address account;
    }

    Lender[] public lenders;

    event Transfer(address from, address to, uint256 amount);

    address public accountAddress;

    constructor(address _accountAddress) public {
        accountAddress = _accountAddress;
    }

    function addLender(string memory _name, address _account) public {
        lenders.push(Lender({
            name: _name,
            account: _account
        }));
        Account(accountAddress).setBalance(_account, 100);
    }
}
