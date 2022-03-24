//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.5.0 <0.9.0;

contract vikramcoins {
    uint256 public max_vikramcoins = 100000;
    uint256 public inr_to_vikramcoins = 10;
    uint256 public total_vikramcoins_bought = 0;
    mapping(address => uint256) equity_vikramcoins;
    mapping(address => uint256) equity_inr;

    modifier can_buy_vikramcoins(uint256 amount) {
        require(
            (amount * inr_to_vikramcoins) + total_vikramcoins_bought <=
                max_vikramcoins
        );
        _;
    }

    function equity_in_vikramcoins(address investor)
        external
        view
        returns (uint256)
    {
        return equity_vikramcoins[investor];
    }

    function equity_in_inr(address investor) external view returns (uint256) {
        return equity_inr[investor];
    }

    function buy_vikramcoins(address investor, uint256 amount)
        external
        can_buy_vikramcoins(amount)
    {
        uint256 vikramcoins_bought = amount * inr_to_vikramcoins;
        equity_vikramcoins[investor] += vikramcoins_bought;
        equity_inr[investor] =
            equity_vikramcoins[investor] /
            inr_to_vikramcoins;
        total_vikramcoins_bought += vikramcoins_bought;
    }

    function sell_vikramcoins(address investor, uint256 vikramcoins_sold)
        external
    {
        require(
            vikramcoins_sold <= equity_vikramcoins[investor],
            "investor doesn't posses this much coins"
        );
        equity_vikramcoins[investor] -= vikramcoins_sold;
        equity_inr[investor] =
            equity_vikramcoins[investor] /
            inr_to_vikramcoins;
        total_vikramcoins_bought -= vikramcoins_sold;
    }
}
