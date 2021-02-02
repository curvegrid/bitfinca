pragma solidity >=0.4.22 <0.9.0;
import "./Account.sol";
import "./Validation.sol";

contract Entrepreneur {
    address public accountAddress;

    constructor(address _accountAddress) public {
        accountAddress = _accountAddress;
    }

    struct Business {
        string name;
        address account;
        uint target;
    }

    event NewEntrepreneur(uint256 id, string name, address account);

    Business[] public _businesses;
    mapping (address => uint256) public fundingTarget;

    function addEntrepreneur(string memory _name, address _account, uint _target) public {
        _businesses.push(Business(_name,_account, _target));
        uint id = _businesses.length -1;

        emit NewEntrepreneur(id, _name, _account);
        fundingTarget[_account] = _target;
        Account(accountAddress).setBalance(_account, 100);
        Validation(accountAddress).addBusiness(_account);
    }

    function setTarget(address business, uint256 _target) public {
        fundingTarget[business] = _target;
    }

    function addToTarget(address business, uint256 _target) public {
        fundingTarget[business] += _target;
    }
}
