// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal  view returns (uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 price,,,) = priceFeed.latestRoundData();
        return uint256(price * 1e18);
    }

    function getConversionRate(uint256 ethAmount) internal  view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountUsd;
    }

    function getVersion() internal  view returns (uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }
}