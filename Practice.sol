// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FirstProgram{
    string public hey;
    uint256 public no;
    //We Can update the veriable with the help of constructor at the time of deployment.  in this we can update the state variable with the help of constructor at the time of deployment.
    function addInfo(string memory _hey , uint256 _no) public{
        hey =_hey;
        no =_no;
    }   
    //print the state variable
    function printInfo() public view returns (string memory , uint256){
        return (hey,no);
    }
    //

}


