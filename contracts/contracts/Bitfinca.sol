// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.4.22 <0.9.0;
import "./Token.sol";

contract Bitfinca {
  address public accountAddress;

  constructor(address _accountAddress) public {
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
    uint creditScore; // on a scale of 0-800
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
  mapping(address => uint256) public entrepreneurAddressToID; // entrepreneur address => ID
  mapping(address => uint256) public lenderAddressToID; // lender address => ID
  mapping(address => uint256) public validatorAddressToID; // validator address=>ID
  mapping (address => uint256) public fundingTarget; // entrepreneur address => fundingTarget
  mapping(address => mapping(address => bool)) public businessToValidators; // businessID => Validator => approval
  mapping(address => uint) public businessValidatorCount; // businessID => validatorCount
  mapping(uint => uint) public entrepreneurToCreditsScore; // id to credit score

  function addLender(string memory _name, address _account) public {
    require(lenderAddressToID[_account] == 0, "You have already registered to be a lender");
    lenders.push(Lender({
        name: _name,
        account: _account
    }));
    uint id = lenders.length;
    lenderAddressToID[_account] = id;
  }

  function addEntrepreneur(string memory _name, address _account, uint _target) public {
    require(entrepreneurAddressToID[_account] == 0, "You have already registered your business");
    entrepreneurs.push(Entrepreneur(_name,_account, _target));
    uint id = entrepreneurs.length;
    fundingTarget[_account] = _target;
    entrepreneurAddressToID[_account] = id;
    businessValidatorCount[_account] = 0; // set validator count to 0
    emit NewEntrepreneur(id, _name, _account);
  }

  function addValidator(string memory _name, address _account) public {
    require(validatorAddressToID[_account] == 0, "You have already registered to be a validator");
    validators.push(Validator({
        name: _name,
        account: _account
    }));
    uint id = validators.length;
    validatorAddressToID[_account] = id;
  }

  /* Entrepreneur */
  function setTarget(address _account, uint256 _target) public {
    require(msg.sender == _account, "only the business owner can change the target");
    fundingTarget[_account] = _target;
    entrepreneurs[entrepreneurAddressToID[_account]-1].target = _target;
  }

  function addToTarget(address _account, uint256 _target) public {
    require(msg.sender == _account, "only the business owner can change the target");
    fundingTarget[_account] += _target;
    entrepreneurs[entrepreneurAddressToID[_account]-1].target += _target;
  }
  /* Entrepreneur end */

  /* Validators */
  function validate(address business, bool approval) public {
    require(validatorAddressToID[msg.sender] != 0, "validator must be registered"); // validator must be registered
    require(msg.sender != business, "validator cannot validate it's own business"); // validator != entrepreneur

    uint entrepreneurID = entrepreneurAddressToID[business];

    if (approval) {
        businessValidatorCount[business] += 1;
        if (entrepreneurToCreditsScore[entrepreneurID] == 0) {
          entrepreneurToCreditsScore[entrepreneurID] = 690;
        } else {
          entrepreneurToCreditsScore[entrepreneurID] = entrepreneurToCreditsScore[entrepreneurID] + 50;
        }
    }
    else {
        businessValidatorCount[business] -= 1;
        if (entrepreneurToCreditsScore[entrepreneurID] == 0) {
          entrepreneurToCreditsScore[entrepreneurID] = 400;
        } else {
          entrepreneurToCreditsScore[entrepreneurID] = entrepreneurToCreditsScore[entrepreneurID] - 50;
        }
    }
    businessToValidators[business][msg.sender] = approval;

    Token(accountAddress).incrementBalance(msg.sender, 1); // placeholder for the nominal fee validators earn

    emit Validate(business, approval);
  }
  /* Validators end */
}