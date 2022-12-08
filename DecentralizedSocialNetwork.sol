// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.4;

import "hardhat/console.sol";

//Version 1.0
//Author: Prof. Fabio Santos
contract DecentralizedSocialNetwork {
  
  // Owner address fixed on contract creation
  address private owner;
 
  // Post length hard-coded and fixed on contract creation
  uint16 limitPostLength = 280; 

  // Struct of post
  struct _postContent {
    string contents;
    address authorAddress;
    uint timestamp;
  }

  //message of owner
  string ownerMessage;
  
  //array of messages
  _postContent[] Messages;  
  
  constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor        
    }
  
  // ----------- Post functions ---------------------
  
  function postMessage(string memory _content)
    checkLength(_content)
    public {
    Messages.push(_postContent(_content, msg.sender, block.timestamp));
    console.log("author Address:", msg.sender);
    console.log("Post message:", _content);
    console.log("timestamp:", block.timestamp);
  }

  function postOwnerMessage(string memory _content)
    checkLength(_content)
    checkOwner()
    public {
    ownerMessage = _content;
  }

  // -------------- Validation funcs ------------------

  modifier checkValidIndex(uint i) {
    require(i < getMessageCount());
    require(i >= 0); _;
  }

  modifier checkLength(string memory _content) {
    require(strlen(_content) <= limitPostLength); _;
  }

  modifier checkOwner() {
    require(owner==msg.sender); _;
  }
  
  // ---------------- Public Getters --------------------
  
  function getMessageCount()
    public view returns (uint) {
    return Messages.length;
  }

  function getMessageContents(uint i) checkValidIndex(i)
    public view returns (string memory) {
    return Messages[i].contents;
  }

  function getMessageAddress(uint i) checkValidIndex(i)
    public view returns (address) {
    return Messages[i].authorAddress;
  }

  function getMessageTimestamp(uint i) checkValidIndex(i)
    public view returns (uint) {
    return Messages[i].timestamp;
  }

  function getOwnerAddress() public view returns (address) {
    return owner;
  }
  
  function getLimitPostLength() public view returns (uint16) {
    return limitPostLength;
  }
  
  function getOwnerMessage() public view returns (string memory) {
    return ownerMessage;
  }

  // ---------------- Utility funcs --------------------
  function strlen(string memory _content) private pure returns ( uint256) {
        return bytes(_content).length;
  }
    
}