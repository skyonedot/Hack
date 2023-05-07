// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

import {MyERC20} from "../ERC20.sol";
import "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

contract ERC20Test is Test {
    address public alice;
    address public bob;
    MyERC20 tokenA;
    MyERC20 tokenB;
    address PancakeFactory = 0xcA143Ce32Fe78f1f7019d7d551a6402fC5350c73;
    address PancakeRouterV2 = 0x10ED43C718714eb63d5aA57B78B54704E256024E;

    function setUp() public {
        tokenA = new MyERC20();
        tokenB = new MyERC20();
        // vm.createSelectFork("bsc",27470678);
    }

    function test_addliquidity() public {
        address pairAddress = IUniswapV2Factory(PancakeFactory).createPair(address(tokenA), address(tokenB));
        tokenA.mint(address(this), 200 ether);
        tokenB.mint(address(this), 200 ether);
        tokenA.approve(PancakeRouterV2, 200 ether);
        tokenB.approve(PancakeRouterV2, 200 ether);
        IUniswapV2Router(PancakeRouterV2).addLiquidity(
            address(tokenA), address(tokenB), 100 ether, 100 ether, 0, 0, address(this), block.timestamp
        );
        assertEq(tokenA.balanceOf(address(this)), 100 ether);
        assertEq(tokenB.balanceOf(address(this)), 100 ether);
        assertEq(IERC20(pairAddress).totalSupply(), 100 ether);
        console.log("TokenA in pair amount:", tokenA.balanceOf(address(pairAddress)));
        console.log("TokenB in pair amount:", tokenB.balanceOf(address(pairAddress)));
        console.log("LP in holder amount:", IERC20(pairAddress).balanceOf(address(this)));
    }

    function test_swap() public {
        address pairAddress = IUniswapV2Factory(PancakeFactory).createPair(address(tokenA), address(tokenB));
        tokenA.mint(address(this), 200 ether);
        tokenB.mint(address(this), 200 ether);
        tokenA.approve(PancakeRouterV2, 200 ether);
        tokenB.approve(PancakeRouterV2, 200 ether);
        IUniswapV2Router(PancakeRouterV2).addLiquidity(
            address(tokenA), address(tokenB), 100 ether, 100 ether, 0, 0, address(this), block.timestamp
        );
        //必须要有一步 tranfer 才能进去
        tokenA.transfer(pairAddress, 2 ether);
        IUniswapV2Pair(pairAddress).swap(0, 1 ether, address(this), new bytes(0));
        console.log("TokenA in pair amount:", tokenA.balanceOf(address(pairAddress)));
        console.log("TokenB in pair amount:", tokenB.balanceOf(address(pairAddress)));
        console.log("LP in holder amount:", IERC20(pairAddress).balanceOf(address(this)));
    }
}

interface IUniswapV2Factory {
    function getPair(address token0, address token1) external view returns (address);
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router {
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

interface IUniswapV2Pair {
    function swap(uint256 amount0Out, uint256 amount1Out, address to, bytes calldata data) external;
}
