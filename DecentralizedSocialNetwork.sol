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

  // Struct of a Post
  struct Post {
    string contents;
    address authorAddress;
    uint timestamp;
    uint256 likes;
  }

  //message of owner
  string ownerPost;
  
  //array of messages
  Post[] Posts;  
  
  constructor() {
        console.log("Owner contract deployed by:", msg.sender);
        owner = msg.sender; // 'msg.sender' is sender of current call, contract deployer for a constructor        
    }
  
// -------------- Modifiers ------------------

  modifier checkValidIndex(uint i) {
    require(i < getPostsCount());
    require(i >= 0); _;
  }

  modifier checkLength(string memory _content) {
    require(strlen(_content) <= limitPostLength); _;
  }

  modifier checkOwner() {
    require(owner==msg.sender); _;
  }
  

  // ----------- Post functions ---------------------
  
  function sendPost(string memory _content)
    checkLength(_content)
    public {
    Posts.push(Post(_content, msg.sender, block.timestamp,0));
    console.log("Author Address:", msg.sender);
    console.log("Post message:", _content);
    console.log("Timestamp:", block.timestamp);
  }

  function postOwnerMessage(string memory _content)
    checkLength(_content)
    checkOwner()
    public {
    ownerPost = _content;
    console.log("Post message:", _content);
  }

  function setLikesPost(uint i) checkValidIndex(i)
    public {
    Posts[i].likes+=1;
  }
  
  // ---------------- Public Getters --------------------
  
  function getPostsCount()
    public view returns (uint) {
    return Posts.length;
  }

  function getPostContents(uint i) checkValidIndex(i)
    public view returns (string memory) {
    return Posts[i].contents;
  }

  function getPostAddress(uint i) checkValidIndex(i)
    public view returns (address) {
    return Posts[i].authorAddress;
  }

  function getPostTimestamp(uint i) checkValidIndex(i)
    public view returns (uint) {
    return Posts[i].timestamp;
  }

  function getOwnerAddress() public view returns (address) {
    return owner;
  }
  
  function getLimitPostLength() public view returns (uint16) {
    return limitPostLength;
  }
  
  function getOwnerPost() public view returns (string memory) {
    return ownerPost;
  }

  function getLikesPost(uint i) checkValidIndex(i)
    public view returns (uint256) {
    return Posts[i].likes;
  }

  // ---------------- Utility funcs --------------------
  function strlen(string memory _content) private pure returns ( uint256) {
        return bytes(_content).length;
  }
    
}