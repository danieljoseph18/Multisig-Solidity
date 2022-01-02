pragma solidity 0.8.11;

// SPDX-License-Identifier: MIT
contract MultiSig{

address[] public owners;
uint limit;

struct Transfer{
    uint amount;
    address payable receiver;
    uint approvals;
    bool hasBeenSent;
    uint id;
}

constructor(address[] memory _owners, uint _limit){
     require(_owners.length > 0);
     require(_limit <= _owners.length);

      for(uint i=0; i< _owners.length; i++){
            address owner= _owners[i];
            require(owner != address(0));
            require(!isOwner[owner]);
            owners.push(owner);
        }
        
        limit= _limit;

}

Transfer [] transferRequests;
mapping (address => bool) public isOwner;
mapping(address => mapping(uint => bool)) approvals;

function deposit() public payable{

}

function createTransfer(address _receiver, uint _amount) public {
    transferRequests.push(Transfer(_amount, payable(_receiver), 0, false, transferRequests.length));
}

modifier onlyOwners {
    require(isOwner[msg.sender]== true );
    _;
}


function approve(uint _txID) public onlyOwners {
    require(_txID < transferRequests.length);
    require(approvals[msg.sender][_txID] == false);
    require(transferRequests[_txID].hasBeenSent == false);

    approvals[msg.sender][_txID] = true;
    transferRequests[_txID].approvals++;
    if(transferRequests[_txID].approvals >= limit){
        transferRequests[_txID].hasBeenSent = true;
        transferRequests[_txID].receiver.transfer(transferRequests[_txID].amount);
    }

} 

function getTxRequests() public view returns(Transfer[] memory){
    return transferRequests;
}

function getContractBalance() public view  onlyOwners returns(uint){
    return address(this).balance;
}

}
