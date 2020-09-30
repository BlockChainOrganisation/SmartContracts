pragma solidity ^0.5.13;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/docs-v2.x/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/docs-v2.x/contracts/math/SafeMath.sol";

contract Allowance is Ownable {
    
    using SafeMath for uint;
     event AllowanceChanged(address indexed _forWho , address indexed _fromWhom, uint oldAmount , uint newAmount);

     mapping (address => uint) public allowance;
    
    function addAllowance(address payable _to , uint _amount) public onlyOwner{
        emit AllowanceChanged(_to ,msg.sender , allowance[_to], _amount);
        allowance[_to] = _amount;
    }
    
    modifier ownerOrAllowed(uint _amount){
        require(isOwner() || allowance[msg.sender] >= _amount,"You are not allowed");
        _;
    }
    
     function reduceAllowance (address _account , uint _amount) internal {
         emit AllowanceChanged(msg.sender , _account , allowance[_account] , allowance[_account].sub(_amount));
        allowance[_account] = allowance[_account].sub(_amount);
    }
}