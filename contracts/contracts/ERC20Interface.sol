// SPDX-License-Identifier: Unlicensed

pragma solidity >= 0.5.0;
pragma experimental ABIEncoderV2;

// Based on https://eips.ethereum.org/EIPS/eip-20
// Updated to Solidity 0.5.x

contract ERC20Interface {
    function totalSupply() public view returns (uint);
    function balanceOf(address tokenOwner) public view returns (uint balance);
    function allowance(address tokenOwner, address spender) public view returns (uint remaining);
    function transfer(address to, uint tokens) public returns (bool success);
    function approve(address spender, uint tokens) public returns (bool success);
    function transferFrom(address from, address to, uint tokens) public returns (bool success);

    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    function name() public view returns (string memory);
    function symbol() public view returns (string memory);
    function decimals() public view returns (uint8);

    function owner() public returns (address account);
    function mint(uint tokens) public returns (bool success);
    function burn(uint tokens) public returns (bool success);
}
