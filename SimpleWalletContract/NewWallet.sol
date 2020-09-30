pragma solidity ^0.5.13;

import "./Allowance.sol";
/*
This is a very simple contract.
Here the owner can add Funds to the Wallet address
@mapping (address => uint) public allowance; is used to allocate the amount of funds a certain address can use.
Check Allowance.sol for more information.
*/
contract Wallet is Allowance {
    
    event MoneyReceived (address indexed _from , uint _amount);
    event MoneySent (address indexed _benificiary , uint _amount);
    
    function withDrawMoney (address payable _to, uint _amount) public ownerOrAllowed(_amount){
       require(_amount <= address(this).balance, "There are not enough funds stored in this wallet");
       if(!isOwner()){
           reduceAllowance(msg.sender,_amount);
       }
       emit MoneySent(_to , _amount);
        _to.transfer(_amount);
    }
    
    //this is function overriding
   function renounceOwnership() public {
       revert("Can't use this feature");
   }
    // using fallback function to accept funds
    function () external payable {
       emit MoneyReceived(msg.sender , msg.value);
    }
}
