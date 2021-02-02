// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.4.22 <0.9.0;
import "./Token.sol";

contract Bitfinca {
  address public accountAddress;

  constructor(address _accountAddress) {
      accountAddress = _accountAddress;
  }
  struct Lender {
    string name;
    address account;
  }

   struct Entrepreneur {
    string name;
    address account;
    uint target;
  }

  struct Validator {
    string name;
    address account;
  }

  Lender[] public lenders;
  Entrepreneur[] public entrepreneurs;
  Validator[] public validators;

  /* Events */
  event NewEntrepreneur(uint256 id, string name, address account);
  event Validate(address business, bool approval);

  /* Mappings */
  mapping (address => uint256) public fundingTarget; // entrepreneur address => fundingTarget
  mapping(address => mapping(address => bool)) public businessToValidators; // businessID => Validator => approval
  mapping(address => uint) public businessValidatorCount; // businessID => validatorCount

  function addLender(string memory _name, address _account) public {
    lenders.push(Lender({
        name: _name,
        account: _account
    }));
    Token(accountAddress).setBalance(_account, 100);
  }

  function addEntrepreneur(string memory _name, address _account, uint _target) public {
    entrepreneurs.push(Entrepreneur(_name,_account, _target));
    uint id = entrepreneurs.length -1;

    emit NewEntrepreneur(id, _name, _account);
    fundingTarget[_account] = _target;
    Token(accountAddress).setBalance(_account, 100);
    businessValidatorCount[_account] = 0; // set validator count to 0
  }

  function addValidator(string memory _name, address _account) public {
    validators.push(Validator({
        name: _name,
        account: _account
    }));
  }

  function setTarget(address business, uint256 _target) public {
      fundingTarget[business] = _target;
  }

  function addToTarget(address business, uint256 _target) public {
      fundingTarget[business] += _target;
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
    Token(accountAddress).incrementBalance(msg.sender, 1); // placeholder for the nominal fee validators earn

    emit Validate(business, approval);
  }
}