// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

// import {Test} from "forge-std/Test.sol";
// import {console} from "forge-std/console.sol";
// import {stdStorage, StdStorage, Test} from "forge-std/Test.sol";
import {MyERC20} from "../src/ERC20.sol";
import "forge-std/Test.sol";

contract ERC20Test is Test {
    MyERC20 public erc20;
    //define decimals
    // TestUser alice;
    // TestUser bob;
    address public alice;
    address public bob;

    function setUp() public {
        erc20 = new MyERC20();
        alice = address(0x123);
        bob = address(0x456);
        // vm.createSelectFork("bsc");
        // erc20.mint(address(this), 100);
        //check eth balance
        // console.log(msg.sender.balance/10**decimals);
        // console.log(bob.balance);
    }

    function test_MintToken() public {
        erc20.mint(address(alice), 100 ether);
        assertEq(erc20.balanceOf(alice), 100 ether);
        assertEq(erc20.totalSupply(), 100 ether);

        erc20.mint(address(bob), 100 ether);
        assertEq(erc20.balanceOf(bob), 100 ether);
        assertEq(erc20.totalSupply(), 200 ether);
    }

    function test_SetEtherBalance() public {
        vm.deal(address(alice), 100 ether);
        assertEq(address(alice).balance, 100 ether);
        vm.deal(address(bob), 100 ether);
        assertEq(address(bob).balance, 100 ether);
    }

    // function test_MintToken_ByBob() public {
    //     vm.prank(address(0x123));
    //     erc20.mint(address(0x123), 100*10**decimals);
    //     // assertEq(erc20.balanceOf(address(this)), 100*10**decimals);
    //     assertEq(erc20.balanceOf(address(0x123)), 100*10**decimals);
    //     assertEq(erc20.totalSupply(), 100*10**decimals);
    //     vm.prank(address(0x123));
    //     console.log(msg.sender);
    // }
}
