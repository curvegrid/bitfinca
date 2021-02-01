pragma solidity >=0.4.22 <0.9.0;

contract Account {

  address private owner;

  event Send(address from, address to, uint256 amount);
  event Deposit(uint256 amount);
  event Withdraw(uint256 amount);

  mapping(address => uint256) balances; // account -> balance

  constructor() public {
    owner = msg.sender;
  }

  function send(address _to, uint256 _amount) public {
      require(balances[msg.sender] >= _amount, "insufficient funds");
      balances[msg.sender] -= _amount;
      balances[_to] += _amount;

      emit Send(msg.sender, _to, _amount);
  }

  function deposit(uint256 _amount) public {
      require(address(this).balance >= _amount, "insufficient funds to deposit");
      require(owner == msg.sender, "You may only deposit from your own account");
      balances[msg.sender] += _amount;

      emit Deposit(_amount);
  }

  function withdraw(uint256 _amount) public {
    require(msg.sender == owner, "You may only withdraw from your own account");
    require(balances[msg.sender] >= _amount, "insufficient funds in your account");

    balances[msg.sender] -= _amount;

    emit Withdraw(_amount);
  }

  function balance() public view returns (uint) {
    return balances[msg.sender];
  }

}