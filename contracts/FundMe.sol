// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {PriceConvert} from "./PriceConverter.sol";

contract FundMe {
    using PriceConvert for uint256;
    uint256 public minimumUsd = 5 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;


    function fund() public payable {
        
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        require(msg.value.getConversionRate() >= minimumUsd,"didn t send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
}