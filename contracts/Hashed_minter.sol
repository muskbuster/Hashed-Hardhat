// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {

    uint256 public totalLiquidity;
    uint256 public  TokenPerETH ;
    uint randNonce = 0;
    mapping(address => uint256) public UserBalance;
    constructor() ERC20("MyToken", "MTK") {
        TokenPerETH=20;
    }

    function mintOnPayment( ) public payable  {
       uint256 amount= msg.value*TokenPerETH;

        _mint(msg.sender, amount);
        UserBalance[msg.sender]+=amount;
    }

       function RandomMinter(uint256 _value) public payable  {
        uint256 randomvalue=randMod(_value);


        _mint(msg.sender, randomvalue);
        UserBalance[msg.sender]+=randomvalue;
    }


    function redeemOnburn(uint256 amount) public payable{
        require(amount<=UserBalance[msg.sender],"You have not minted so much");
        require(amount>0,"amount cant be zero");
       uint256 EthOwed= amount/TokenPerETH;
        payable(msg.sender).transfer(EthOwed);

    }

    function setValue(uint256 _value) public onlyOwner{
     TokenPerETH= _value;
    }

    function randMod(uint _modulus) internal returns(uint)
{
   // increase nonce
   randNonce++;
   return uint(keccak256(abi.encodePacked(block.timestamp,msg.sender, randNonce))) % _modulus;
 }
}
