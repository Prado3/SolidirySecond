// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;
    uint256 public constant MINIMUN_USD = 5 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    address public immutable i_owner;

    constructor () {
        i_owner = msg.sender;
    }

    function fund() public payable {
        
        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        require(msg.value.getConversionRate() >= MINIMUN_USD,"didn t send enough ETH");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw () public onlyOwner {
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
        //call
        (bool callSuccess,) = payable (msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner() {
                require(msg.sender == i_owner, "Sender is not Owner!");
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable { 
        fund();
    }
}
