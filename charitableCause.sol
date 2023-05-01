// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract charitableCause {
    struct Cause{
        uint id;
        string name;
        uint32 targetPrice;
        uint32 amountCollected;
    }

    uint private countCauses;
    mapping(string => Cause) causes;

    function newCause(string memory _name, uint32 _targetPrice) public payable{
        countCauses = countCauses++;
        causes[_name] = Cause(countCauses,_name,_targetPrice,0);
    }

    function isTargetAchieved(string memory _name) public view returns(bool){
        if(causes[_name].amountCollected >= causes[_name].targetPrice){
            return true;
        }else
        {
            return false;
        }
    }

    function donate(string memory _name, uint32 _amount) public payable returns(bool) {
        bool donateAccepted;
        if(!isTargetAchieved(_name)){
            causes[_name].amountCollected = causes[_name].amountCollected + _amount;
            donateAccepted = true; 
        }

        return donateAccepted;
    }
}