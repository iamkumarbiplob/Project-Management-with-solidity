// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Market {
    struct item {
        address owner;
        uint256 price;
        bool sell;
        string data;
    }

    mapping (uint256 => item) public itemList;

    uint256 public itemCounter=0;

    function addItem (uint256 _price, string memory _data) public {
        item memory _item = item(msg.sender,_price, false, _data);
        itemList[itemCounter] = _item;
        itemCounter+=1;
    }

    function sellItem (uint256 _itemCounter) public payable {
        require (msg.sender != itemList[_itemCounter].owner, "Owner is same. You are not elligable for sell.");
        require (msg.value == itemList[_itemCounter].price,"Not Enough Balance");
        itemList[_itemCounter].owner=msg.sender;
        itemList[_itemCounter].sell=true;
    }
    function updateItem (uint256 _itemCounter, uint256 _price) public{
        require (msg.sender == itemList[_itemCounter].owner, "Owner is not same. You are not elligable for Update.");
        require (false == itemList[_itemCounter].sell, "You are not elligable for Update.");
        itemList[_itemCounter].price=_price;
    }

}
