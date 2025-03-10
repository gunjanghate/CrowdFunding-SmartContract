//SPDX-License-Identifier:MIT

pragma solidity ^0.8.19;

contract CrowdFunding {
    mapping(address => uint256) public contributers;
    address public manager;
    uint256 public minContri;
    uint256 public deadline;
    uint256 public target;
    uint256 public raisedAmt;
    uint256 public noOfContri;

    constructor(uint256 _target, uint256 _deadline) {
        target = _target;
        deadline = block.timestamp + _deadline;
        minContri = 100 wei;
        manager = msg.sender;
    }

    struct Req{
        string desc;
        address payable recipient;
        uint value;
        bool completed;
        uint noOfVoters;
        mapping(address=>bool) voters;

    }
    mapping(uint=>Req) public requests;
    uint public numReq;

    function sendETH() public payable {
        require(block.timestamp <= deadline, "Ether cant be sent as its dead");
        require(msg.value >= minContri, "Ether cant be sent as its not enough");
        if (contributers[msg.sender] == 0) {
            noOfContri++;
        }
        if (msg.value >= minContri) {
            contributers[msg.sender] += msg.value;
            raisedAmt += msg.value;
        }
    }

    function getBalance() public view returns(uint){
        return address(this).balance;
    }

    function refund() public{
        require(block.timestamp>deadline && raisedAmt<target, "No Ether Refunded");
        require(contributers[msg.sender]>0);
        address payable user = payable(msg.sender);
        user.transfer(contributers[msg.sender]);
        contributers[msg.sender] = 0;
    }
    modifier onlyManager{
        require(msg.sender==manager, "Unauthorized");
        _;
    }

    function CreateReq(string memory _desc, address payable _recipient, uint _value) public onlyManager {
        Req storage newReq = requests[numReq];
        numReq++;
        newReq.desc=_desc;
        newReq.recipient=_recipient;
        newReq.value=_value;
        newReq.completed=false;
        newReq.noOfVoters=0;
    }  

    function VoteReq(uint _reqNum) public{
        require(contributers[msg.sender]>0,"You must be contributer");
        Req storage thisReq =requests[_reqNum];
        require(thisReq.voters[msg.sender]==false, "You have already voted");
        thisReq.voters[msg.sender]=true;
        thisReq.noOfVoters++;
    }  

    function makePayment(uint _reqNo) public onlyManager{
        require(raisedAmt>=target);
        Req storage thisReq = requests[_reqNo];
        require(thisReq.completed==false, "The request has been completed");
        require(thisReq.noOfVoters > noOfContri/2,"Majority don't support");
        thisReq.recipient.transfer(thisReq.value);
        thisReq.completed=true;
    } 
}
