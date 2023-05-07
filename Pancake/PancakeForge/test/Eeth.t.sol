// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import {MyERC20} from "../src/ERC20.sol";
import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ERC20Test is Test {
    // address public alice;
    // address public bob;
    // MyERC20 tokenA;
    // MyERC20 tokenB;
    // address PancakeFactory = 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73;
    // address PancakeRouterV2 = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

    function setUp() public {
        vm.createSelectFork("eth", 17156141 - 40000);
    }

    function test_balance() public {
        console.log(
            IERC20(0x41545f8b9472D758bB669ed8EaEEEcD7a9C4Ec29).balanceOf(0x8a09FB23E1c8d0FF9c9Fef0BcFc9b9e07B1f0667)
        );
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}
