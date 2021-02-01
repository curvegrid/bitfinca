pragma solidity >=0.4.22 <0.9.0;
import "./Account.sol";

contract Validation {
    struct Validator {
        string name;
        address account;
    }

    Validator[] public validators;

    event Validate(address business, bool approval);

    mapping(address => mapping(address => bool)) public businessToValidators; // businessID => Validator => approval
    mapping(address => uint) public businessValidatorCount; // businessID => validatorCount

    address public accountAddress;

    constructor(address _accountAddress) public {
        accountAddress = _accountAddress;
    }

    function addValidator(string memory _name, address _account) public {
        validators.push(Validator({
            name: _name,
            account: _account
        }));

    }

    // validate businesses
    function validate(address business, bool approval) public {
        if (approval) {
            businessValidatorCount[business] += 1;
        }
        else {
            businessValidatorCount[business] -= 1;
        }
        businessToValidators[business][msg.sender] = approval;
        Account(accountAddress).incrementBalance(msg.sender, 1); // placeholder for the nominal fee validators earn

        emit Validate(business, approval);
    }
}
