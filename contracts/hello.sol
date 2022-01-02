// SPDX-License-Identifier: MIT
pragma solidity 0.8.11;

contract Helloworld{

    string message;
    function setMessage(string memory _newMessage) public returns(string memory){
        message = _newMessage;
        return message;
    }

    function hello() public pure returns(string memory){
        return "Hello World!";
        }
}
