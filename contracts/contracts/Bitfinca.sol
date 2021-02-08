// SPDX-License-Identifier: Unlicensed

pragma solidity >=0.4.22 <0.9.0;

contract Bitfinca {
  address public accountAddress;

  constructor(address _accountAddress) public {
      accountAddress = _accountAddress;
  }
  struct Lender {
    string name;
    address account;
    bool valid; // lender is active
  }

   struct Entrepreneur {
    string founder;
    string businessName;
    address account;
    uint target;
    uint raisedAmount;
    uint creditScore; // on a scale of 0-800
    bool valid; // entrepreneur is active
  }

  struct Validator {
    string name;
    address account;
    bool valid; // validator is active
  }

  struct Roles {
    bool entrepreneur;
    bool validator;
    bool lender;
  }

  /* Roles  */
  mapping(address => Lender) public lenders;
  mapping(address => Entrepreneur) public entrepreneurs;
  mapping(address => Validator) public validators;
  mapping(address => bool) private registeredUser;

  /* RETRIEVING */
  address[] public allLenders;
  address[] public allEntrepreneurs;
  address[] public allValidators;

  /* Events */
  event NewEntrepreneur(string founder, string businessName, address account, uint target, uint creditScore);
  event NewLender(string name, address account);
  event NewValidator(string name, address account);
  event Validate(address business, bool approval);
  event RemovedEntrepreneur(address account);
  event RemovedValidator(address account);
  event RemovedLender(address account);

  /* Mappings */
  mapping (address => uint256) public fundingTarget; // entrepreneur address => fundingTarget
  mapping(address => mapping(address => bool)) public entrepreneurToValidators; // entrepreneur address => Validator => approval
  mapping(address => address[]) public entrepreneurToValidatorAdddress; // entrepreneur address => Validator address
  mapping(address => uint) public entrepreneurValidatorCount; // entrepreneur address => validatorCount
  mapping(address => uint) public entrepreneurToCreditsScore; // entrepreneur address to credit score
  mapping(address => Roles) public addressToRole; //

  /* Modifiers*/
  modifier checkValidLender(address _account) {
    require(lenders[_account].account != address(0));
    require(lenders[_account].valid);
    require(registeredUser[_account]);
    _;
  }

  modifier checkValidEntrepreneur(address _account) {
    require(entrepreneurs[_account].account != address(0));
    require(entrepreneurs[_account].valid);
    require(registeredUser[_account]);
    _;
  }

  modifier checkValidValidator(address _account) {
    require(validators[_account].account != address(0));
    require(validators[_account].valid);
    require(registeredUser[_account]);
    _;
  }

  /* constants */
  uint constant defaultCreditScore = 690;

  /* methods */
  function addLender(string memory _name, address _account) public {
    require(lenders[_account].valid == false, "You have already registered to be a lender");
    lenders[_account] = Lender({
        name: _name,
        account: _account,
        valid: true
    });
    allLenders.push(_account);
    registeredUser[_account] = true;
    addressToRole[_account].lender = true;
    emit NewLender(_name, _account);
  }

  function addEntrepreneur(string memory _name, string memory _businessName, address _account, uint _target, uint _raisedAmount) public {
    require(entrepreneurs[_account].valid == false, "You have already registered your business");
    entrepreneurs[_account] = Entrepreneur({
      founder: _name,
      businessName: _businessName,
      account: _account,
      target: _target,
      raisedAmount: _raisedAmount,
      creditScore: defaultCreditScore,
      valid: true});
    fundingTarget[_account] = _target;
    entrepreneurValidatorCount[_account] = 0; // set validator count to 0
    allEntrepreneurs.push(_account);
    registeredUser[_account] = true;
    addressToRole[_account].entrepreneur = true;

    emit NewEntrepreneur(_name, _businessName, _account, _target, _raisedAmount);
  }

  function addValidator(string memory _name, address _account) public {
    require(validators[_account].valid == false, "You have already registered to be a validator");
    validators[_account] = Validator({
        name: _name,
        account: _account,
        valid: true
    });
    allValidators.push(_account);
    registeredUser[_account] = true;
    addressToRole[_account].validator = true;
    emit NewValidator(_name, _account);
  }

  function removeValidator(address _account) public {
    require(validators[_account].valid == true, "You are not an active validator");
    validators[_account].valid = false;
    addressToRole[_account].validator = false;

    emit RemovedValidator(_account);
  }

  function removeLender(address _account) public {
    require(lenders[_account].valid == true, "You are not an active lender");
    lenders[_account].valid = false;
    addressToRole[_account].lender = false;

    emit RemovedLender(_account);
  }

  function removeEntrepreneur(address _account) public {
    require(entrepreneurs[_account].valid == true, "You are not an active entrepreneur");
    entrepreneurs[_account].valid = false;
    addressToRole[_account].entrepreneur = false;

    emit RemovedEntrepreneur(_account);
  }

  function getValidators(address _account) public view checkValidEntrepreneur(_account) returns(address[] memory){
    return entrepreneurToValidatorAdddress[_account];
  }

  /* Entrepreneur */
  function setTarget(address _account, uint256 _target) public checkValidEntrepreneur(_account) {
    require(msg.sender == _account, "only the business owner can change the target");
    fundingTarget[_account] = _target;
    entrepreneurs[_account].target = _target;
  }

  function addToTarget(address _account, uint256 _target) public checkValidEntrepreneur(_account) {
    require(msg.sender == _account, "only the business owner can change the target");
    fundingTarget[_account] += _target;
    entrepreneurs[_account].target += _target;
  }
  /* Entrepreneur end */

  /* Validators */
  function validate(address business, bool approval) public checkValidValidator(msg.sender) {
    require(msg.sender != business, "validator cannot validate it's own business"); // validator != entrepreneur

    if (approval) {
        entrepreneurValidatorCount[business] += 1;
        if (entrepreneurToCreditsScore[business] == 0) {
          entrepreneurToCreditsScore[business] = 690;
        } else {
          entrepreneurToCreditsScore[business] = entrepreneurToCreditsScore[business] + 50;
        }
    }
    else {
        entrepreneurValidatorCount[business] -= 1;
        if (entrepreneurToCreditsScore[business] == 0) {
          entrepreneurToCreditsScore[business] = 400;
        } else {
          entrepreneurToCreditsScore[business] = entrepreneurToCreditsScore[business] - 50;
        }
    }
    entrepreneurToValidators[business][msg.sender] = approval;
    entrepreneurToValidatorAdddress[business].push(msg.sender);

    emit Validate(business, approval);
  }
  /* Validators end */

  function totalEntrepreneurs() public view returns (address[] memory) {
    return allEntrepreneurs;
  }

  function totalValidators() public view returns (address[] memory) {
    return allValidators;
  }

  function totalLenders() public view returns (address[] memory) {
    return allLenders;
  }

  function numEntrepreneurs() public view returns (uint256) {
    return allEntrepreneurs.length;
  }

  function numValidators() public view returns (uint256) {
    return allValidators.length;
  }
  function numLenders() public view returns (uint256) {
    return allLenders.length;
  }
}